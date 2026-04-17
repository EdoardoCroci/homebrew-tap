class ClaudeTap < Formula
  desc "Dynamic Island-style notifications, sound alerts and status line for Claude Code"
  homepage "https://github.com/EdoardoCroci/claude-tap"
  url "https://github.com/EdoardoCroci/claude-tap/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "44e65c6230d8d39aa126a263196f6de02c218d4f614a3aea45b7888f65c6750a"
  version "1.7.0"
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
