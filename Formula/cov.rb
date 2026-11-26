class Cov < Formula
  desc "Kanopi Covenant CLI"
  homepage "https://kanopi-dev.com"
  version "1.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.6/cov-aarch64-apple-darwin.tar.xz"
      sha256 "f7644cf00d37f720836bccfbb7f627f5e9bf22e755d8168c2977373e98eccf04"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.6/cov-aarch64-apple-darwin.tar.xz"
      sha256 "f7644cf00d37f720836bccfbb7f627f5e9bf22e755d8168c2977373e98eccf04"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.6/cov-x86_64-apple-darwin.tar.xz"
      sha256 "d4e7bdc7002d1ed90e9ff82d3c5852cd030c76be2da4c27bcce4515342224a1f"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.6/cov-x86_64-apple-darwin.tar.xz"
      sha256 "d4e7bdc7002d1ed90e9ff82d3c5852cd030c76be2da4c27bcce4515342224a1f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.6/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "618fde422265a9fa7bf5174f5fe673d09ccaf23b3ddca9aa38fb1cab7a74866a"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.6/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "618fde422265a9fa7bf5174f5fe673d09ccaf23b3ddca9aa38fb1cab7a74866a"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.6/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ffd1605d04720d144ca16419c3dcc2db5429a48c82ca8a74331e568af707ec4b"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.6/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ffd1605d04720d144ca16419c3dcc2db5429a48c82ca8a74331e568af707ec4b"
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
