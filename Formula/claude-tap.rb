class ClaudeTap < Formula
  desc "Dynamic Island-style notifications, sound alerts and status line for Claude Code"
  homepage "https://github.com/EdoardoCroci/claude-tap"
  url "https://github.com/EdoardoCroci/claude-tap/archive/refs/tags/v1.7.1.tar.gz"
  sha256 "866bcc7eaed5b9181a158ad1702dddf5f0a78226b61d919a48032de2834f73d8"
  version "1.7.1"
  license "MIT"

  depends_on :macos
  depends_on "jq"

  def install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"macos/setup.sh" => "claude-tap-setup"
    bin.install_symlink prefix/"macos/configure.sh" => "claude-tap-configure"
    bin.install_symlink prefix/"macos/uninstall.sh" => "claude-tap-uninstall"
  end

  def caveats
    <<~EOS
      Run the setup to get started:
        claude-tap-setup

      To customize settings (interactive wizard):
        claude-tap-configure

      To uninstall hooks and config:
        claude-tap-uninstall

      Config: ~/.config/claude-tap/config.json
    EOS
  end

  test do
    assert_predicate prefix/"macos/install.sh", :exist?
    assert_predicate prefix/"macos/setup.sh", :exist?
    assert_predicate prefix/"config.example.json", :exist?
  end
end
