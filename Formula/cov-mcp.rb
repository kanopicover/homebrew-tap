class CovMcp < Formula
  desc "Kanopi Covenant authoring MCP"
  homepage "https://kanopi-dev.com"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopi-dev.com/cli/cov-mcp-v1.0.0/cov-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "4b0ba7beaad38b02993c8d23ef198c398b181859099ed35c3708b740debb0de9"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-mcp-v1.0.0/cov-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "4b0ba7beaad38b02993c8d23ef198c398b181859099ed35c3708b740debb0de9"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopi-dev.com/cli/cov-mcp-v1.0.0/cov-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "0e51644b95dc5fb4fb228f2fcb55c27b2afdd457eddee925bb9aab2c47205535"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-mcp-v1.0.0/cov-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "0e51644b95dc5fb4fb228f2fcb55c27b2afdd457eddee925bb9aab2c47205535"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopi-dev.com/cli/cov-mcp-v1.0.0/cov-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e02aa54f47ec7976bbb5fc17a7cae12e7c67f557a3b89ac7dde42cfe41bb1d25"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-mcp-v1.0.0/cov-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e02aa54f47ec7976bbb5fc17a7cae12e7c67f557a3b89ac7dde42cfe41bb1d25"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopi-dev.com/cli/cov-mcp-v1.0.0/cov-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "962fd01bfe461a16f6c4175430197c498d4a24c4b5c18071d473ace861cd0184"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-mcp-v1.0.0/cov-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "962fd01bfe461a16f6c4175430197c498d4a24c4b5c18071d473ace861cd0184"
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
      bin.install "cov-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cov-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cov-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cov-mcp"
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
