class Cov < Formula
  desc "Kanopi Covenant CLI"
  homepage "https://kanopi-dev.com"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopi-dev.com/cli/cov-v1.0.1/cov-aarch64-apple-darwin.tar.xz"
      sha256 "78617aa28cfc0b258aaf2cc892a62c36e4d4c5508e146c9e28b8720ff9294688"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.1/cov-aarch64-apple-darwin.tar.xz"
      sha256 "78617aa28cfc0b258aaf2cc892a62c36e4d4c5508e146c9e28b8720ff9294688"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopi-dev.com/cli/cov-v1.0.1/cov-x86_64-apple-darwin.tar.xz"
      sha256 "0aed1c2d1b0ec8c61b96ea1116469ad4f73e53a802e1b4db155559f50bfdfab0"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.1/cov-x86_64-apple-darwin.tar.xz"
      sha256 "0aed1c2d1b0ec8c61b96ea1116469ad4f73e53a802e1b4db155559f50bfdfab0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopi-dev.com/cli/cov-v1.0.1/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7350433618187105b95299600b93f558ae1196e0b1372d5560d2946257afe6c"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.1/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7350433618187105b95299600b93f558ae1196e0b1372d5560d2946257afe6c"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopi-dev.com/cli/cov-v1.0.1/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a3afc5df5f78cf84e3e5974dfc62daa5c8244d2b4affef30b8e8b8ebba146c7b"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.1/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a3afc5df5f78cf84e3e5974dfc62daa5c8244d2b4affef30b8e8b8ebba146c7b"
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
