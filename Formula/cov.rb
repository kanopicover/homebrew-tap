class Cov < Formula
  desc "Kanopi Covenant CLI"
  homepage "https://kanopi-dev.com"
  version "1.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.5/cov-aarch64-apple-darwin.tar.xz"
      sha256 "96f142af5032499ee484d78bd9e96e5302e09a9c94eb267edb5aaff10c6a0180"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.5/cov-aarch64-apple-darwin.tar.xz"
      sha256 "96f142af5032499ee484d78bd9e96e5302e09a9c94eb267edb5aaff10c6a0180"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.5/cov-x86_64-apple-darwin.tar.xz"
      sha256 "c6365f5148c383636c351d777ee7036717b7beda5c591075eb79fac292139899"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.5/cov-x86_64-apple-darwin.tar.xz"
      sha256 "c6365f5148c383636c351d777ee7036717b7beda5c591075eb79fac292139899"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.5/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "003c53efbb7b724db13b2aedca7e7abe90f8cd716bd52e0db571a4de4739d7a3"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.5/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "003c53efbb7b724db13b2aedca7e7abe90f8cd716bd52e0db571a4de4739d7a3"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.5/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c1b6dc5b4c10d3c1a188c044dbd47d15eccde11d8b74882a2a6a1ec5a03bcaa4"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.5/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c1b6dc5b4c10d3c1a188c044dbd47d15eccde11d8b74882a2a6a1ec5a03bcaa4"
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
