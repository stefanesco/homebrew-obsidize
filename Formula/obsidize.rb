class Obsidize < Formula
  desc "Claude to Obsidian converter"
  homepage "https://github.com/stefanesco/obsidize"
  license "AGPL-3.0"
  version "0.1.74-alpha"

  on_macos do
    on_arm do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.74-alpha/obsidize-0.1.74-alpha-macos-aarch64.tar.gz"
      sha256 "6307c999d07914290cc38ef1482521464c1ef6b47fcf2a449f6a27a243cfb1ff"
    end
    on_intel do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.74-alpha/obsidize-0.1.74-alpha-macos-x64.tar.gz"
      sha256 "b28c2f1ace58a9f41c1d15d14de814be1977145546edac2eae3d952a5a68834d"
    end
  end

  
  on_linux do
    on_intel do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.74-alpha/obsidize-0.1.74-alpha-linux-amd64.tar.gz"
      sha256 "748e111538d64ed63b36e3dd8a1e2ec05c5a7eee2684db8f60b66e1cefca880d"
    end
  end
  

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        # macOS ARM64: Native executable package (direct binary)
        if (buildpath/"bin/obsidize").exist?
          # Install native binary directly
          bin.install "bin/obsidize"
        else
          odie "No native executable found in macOS ARM64 package"
        end
      else
        # macOS x86: JLink runtime package (includes JRE + application)
        libexec.install Dir["*"]
        
        if (libexec/"bin/obsidize").exist?
          # Create wrapper for JLink package
          bin.write "obsidize", <<~EOS
            #!/bin/bash
            exec "#{libexec}/bin/obsidize" "$@"
          EOS
          chmod 0755, bin/"obsidize"
        else
          odie "No jlink executable found in macOS x86 package"
        end
      end
    else
      # Linux: JLink runtime package (includes JRE + application)
      libexec.install Dir["*"]
      
      if (libexec/"bin/obsidize").exist?
        # Create wrapper for JLink package
        bin.write "obsidize", <<~EOS
          #!/bin/bash
          exec "#{libexec}/bin/obsidize" "$@"
        EOS
        chmod 0755, bin/"obsidize"
      else
        odie "No jlink executable found in Linux package"
      end
    end
  end

  test do
    assert_match "obsidize", shell_output("#{bin}/obsidize --help")
  end
end