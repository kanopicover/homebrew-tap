class Cov < Formula
  desc "Kanopi Covenant CLI"
  homepage "https://kanopi-dev.com"
  version "1.0.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.8/cov-aarch64-apple-darwin.tar.xz"
      sha256 "96c6fe335515daad28d9293ba485365dbb7c3cd9c986a5712181c0d7c27dc5d6"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.8/cov-aarch64-apple-darwin.tar.xz"
      sha256 "96c6fe335515daad28d9293ba485365dbb7c3cd9c986a5712181c0d7c27dc5d6"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.8/cov-x86_64-apple-darwin.tar.xz"
      sha256 "eff2175675c1fa6d1d049c6a84ffd024d14653d81b400dff498f22b66521c6b9"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.8/cov-x86_64-apple-darwin.tar.xz"
      sha256 "eff2175675c1fa6d1d049c6a84ffd024d14653d81b400dff498f22b66521c6b9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.8/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8a64a124a432f41bfc88825e39096d008c68e51836058dd835f92896fd4ee2a0"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.8/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8a64a124a432f41bfc88825e39096d008c68e51836058dd835f92896fd4ee2a0"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.8/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "51a6ea8b738b977f87426048fe4c622bc0d63774e6aef855fd2ffe5dbfd3a485"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.8/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "51a6ea8b738b977f87426048fe4c622bc0d63774e6aef855fd2ffe5dbfd3a485"
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
