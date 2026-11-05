class Cov < Formula
  desc "Kanopi Covenant CLI"
  homepage "https://kanopi-dev.com"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopi-dev.com/cli/cov-v1.0.4/cov-aarch64-apple-darwin.tar.xz"
      sha256 "3532a9db87c2e35905197551c8ed86a6b3c906f06119d75737ae7312be4ec752"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.4/cov-aarch64-apple-darwin.tar.xz"
      sha256 "3532a9db87c2e35905197551c8ed86a6b3c906f06119d75737ae7312be4ec752"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopi-dev.com/cli/cov-v1.0.4/cov-x86_64-apple-darwin.tar.xz"
      sha256 "3c9e7c10956dd4a827151d4c06cf22a60864c1473345b6411d073a6ddc2f228f"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.4/cov-x86_64-apple-darwin.tar.xz"
      sha256 "3c9e7c10956dd4a827151d4c06cf22a60864c1473345b6411d073a6ddc2f228f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopi-dev.com/cli/cov-v1.0.4/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dcf7b323665b7146beee7b0c447e2061112daec201f2b4781bd8d57c667b464b"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.4/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dcf7b323665b7146beee7b0c447e2061112daec201f2b4781bd8d57c667b464b"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopi-dev.com/cli/cov-v1.0.4/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e1e3e99007fd00219dffbefde0238892a981ce40a3538b4be6ee8333eac5c9ef"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.4/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e1e3e99007fd00219dffbefde0238892a981ce40a3538b4be6ee8333eac5c9ef"
    end
  end
  license "UNLICENSED"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cov"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cov"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cov"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cov"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
