class Obsidize < Formula
  desc "A simple Clojure CLI tool"
  homepage "https://github.com/stefanesco/obsidize"
  license "AGPL-3.0"
  version "0.1.7-alpha"

  on_macos do
    on_arm do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.7-alpha/obsidize-arm64-macOS.tar.gz"
      sha256 "c9feb7c71d0e8bd97237a57a704ae4348d953a0422f70aa507e49a6d2408ffa8"
    end
    on_intel do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.7-alpha/obsidize-amd64-macOS.tar.gz"
      sha256 "61c5337bc910046cd7e498bd5cd792e840a45c58f093fcfcaf1868489f74e3b5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.7-alpha/obsidize-amd64-Linux.tar.gz"
      sha256 "e495950493b391b5f977722ec616b9960f51af70f190de78714b45450187023a"
    end
  end

  def install
    bin.install "obsidize"
  end

  test do
    assert_match "obsidize", shell_output("#{bin}/obsidize --help")
  end
end
