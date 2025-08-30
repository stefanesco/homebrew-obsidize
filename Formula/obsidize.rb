class Obsidize < Formula
  desc "Claude to Obsidian converter"
  homepage "https://github.com/stefanesco/obsidize"
  license "AGPL-3.0"
  version "0.1.76-alpha"

  on_macos do
    on_arm do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.76-alpha/obsidize-0.1.76-alpha-macos-aarch64.tar.gz"
      sha256 "068413cf1f5448edcfb4e1a303e0e25019cef98069fff842320bb19d070e6954"
    end
    on_intel do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.76-alpha/obsidize-0.1.76-alpha-macos-x64.tar.gz"
      sha256 "533f5ade782504528d1fb8192be3a1fa68754ee77ccb30550e4a89f783d14970"
    end
  end

  
  on_linux do
    on_intel do
      url "https://github.com/stefanesco/obsidize/releases/download/v0.1.76-alpha/obsidize-0.1.76-alpha-linux-amd64.tar.gz"
      sha256 "5824651e1378e6f6529c334dbfe96ecfabfb5969220137d84a6ddceef93582a9"
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