class Cov < Formula
  desc "Kanopi Covenant CLI"
  homepage "https://kanopi-dev.com"
  version "1.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.7/cov-aarch64-apple-darwin.tar.xz"
      sha256 "d6db4709edf5d7506744c3ceab35ca54fec52be148facce8fe0baf3b54b023f5"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.7/cov-aarch64-apple-darwin.tar.xz"
      sha256 "d6db4709edf5d7506744c3ceab35ca54fec52be148facce8fe0baf3b54b023f5"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.7/cov-x86_64-apple-darwin.tar.xz"
      sha256 "afb21f661c0e3bfdc6bdc62d89dd44aaf4fb8db8725d8ff6d644e49aad22bcdd"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.7/cov-x86_64-apple-darwin.tar.xz"
      sha256 "afb21f661c0e3bfdc6bdc62d89dd44aaf4fb8db8725d8ff6d644e49aad22bcdd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.7/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1d45e73e41d96e35ad63b9a36d24caf13834c3ff593d0686e468f496c80184e7"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.7/cov-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1d45e73e41d96e35ad63b9a36d24caf13834c3ff593d0686e468f496c80184e7"
    end
    if Hardware::CPU.intel?
      url "https://downloads.kanopicover.io/cli/cov-v1.0.7/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "612a708f58c4760d2caaf56b949588df83919220a59f85fff8aa53ec5e78031c"
      mirror "https://github.com/kanopicover/covenant/releases/download/cov-v1.0.7/cov-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "612a708f58c4760d2caaf56b949588df83919220a59f85fff8aa53ec5e78031c"
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
