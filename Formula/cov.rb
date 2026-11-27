class Cov < Formula
  desc "Kanopi Covenant CLI"
  homepage "https://kanopi-dev.com"
  version "1.0.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.10/cov-aarch64-apple-darwin.tar.xz"
      sha256 "c672cbcd5c43d6e2d67775fefdf4dba568f243747a621a39486459cb6d2e643c"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.10/cov-aarch64-apple-darwin.tar.xz"
      sha256 "c672cbcd5c43d6e2d67775fefdf4dba568f243747a621a39486459cb6d2e643c"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.10/cov-x86_64-apple-darwin.tar.xz"
      sha256 "392802d7d7355c86493caad657461540c9bbc77e9b196aed4f8510f9abafb1b4"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.10/cov-x86_64-apple-darwin.tar.xz"
      sha256 "392802d7d7355c86493caad657461540c9bbc77e9b196aed4f8510f9abafb1b4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.10/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b976bce834aebd09f9e802533fa3bb2ab0f38f715057dd319578bed7d8a4f6b6"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.10/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b976bce834aebd09f9e802533fa3bb2ab0f38f715057dd319578bed7d8a4f6b6"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.10/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7ce6bc3f5042507912a4c38abaf62023bce3f83306a36f494aa0dea59099a480"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.10/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7ce6bc3f5042507912a4c38abaf62023bce3f83306a36f494aa0dea59099a480"
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
