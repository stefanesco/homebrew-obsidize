class Obsidize < Formula
  desc "Claude to Obsidian converter"
  homepage "https://github.com/stefanesco/obsidize"
  license "AGPL-3.0"
  version "0.1.79"

  on_macos do
    on_arm do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.79/obsidize-0.1.79-macos-aarch64.tar.gz"
      sha256 "6e34e99308bffb8096da7aba6e633293618c1c7543dc7644739c0f89f4bb8abe"
    end
    on_intel do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.79/obsidize-0.1.79-macos-x64.tar.gz"
      sha256 "57dbacc1be9de0a110f6869eef7da5b379eb787aad3f9ea829afb754b7c834bb"
    end
  end

  
  on_linux do
    on_intel do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.79/obsidize-0.1.79-linux-amd64.tar.gz"
      sha256 "a12cc43b259d33d9b38f49f5578dac315a71bf78e2a57d39b98433690b7cd623"
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
          (bin/"obsidize").write <<~EOS
            #!/bin/bash
            exec "#{libexec}/bin/obsidize" "$@"
          EOS
          (bin/"obsidize").chmod 0755
        else
          odie "No jlink executable found in macOS x86 package"
        end
      end
    else
      # Linux: JLink runtime package (includes JRE + application)
      libexec.install Dir["*"]
      
      if (libexec/"bin/obsidize").exist?
        # Create wrapper for JLink package
        (bin/"obsidize").write <<~EOS
          #!/bin/bash
          exec "#{libexec}/bin/obsidize" "$@"
        EOS
        (bin/"obsidize").chmod 0755
      else
        odie "No jlink executable found in Linux package"
      end
    end
  end

  test do
    assert_match "obsidize", shell_output("#{bin}/obsidize --help")
  end
end