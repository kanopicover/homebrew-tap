class Cov < Formula
  desc "Kanopi Covenant CLI"
  homepage "https://kanopi-dev.com"
  version "1.0.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.9/cov-aarch64-apple-darwin.tar.xz"
      sha256 "000cc83ae100130584cef2d787e9bf0cfffd49b82d76c5b6b53651e97e5374a5"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.9/cov-aarch64-apple-darwin.tar.xz"
      sha256 "000cc83ae100130584cef2d787e9bf0cfffd49b82d76c5b6b53651e97e5374a5"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.9/cov-x86_64-apple-darwin.tar.xz"
      sha256 "6e51947f7c23343a9449e7d40881d0793dc7e216717b8af9418e6575e39bd65f"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.9/cov-x86_64-apple-darwin.tar.xz"
      sha256 "6e51947f7c23343a9449e7d40881d0793dc7e216717b8af9418e6575e39bd65f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.9/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3b6503066ca6167fc8d4802bb74943eacdcddd48e9e4651737de205ac3f40bb3"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.9/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3b6503066ca6167fc8d4802bb74943eacdcddd48e9e4651737de205ac3f40bb3"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.9/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "075fb5e2afd6833a6423a2cd4095f3aede95ae76cb5548299736921177613749"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.9/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "075fb5e2afd6833a6423a2cd4095f3aede95ae76cb5548299736921177613749"
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
