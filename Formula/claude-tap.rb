class ClaudeTap < Formula
  desc "Dynamic Island-style notifications, sound alerts and status line for Claude Code"
  homepage "https://github.com/EdoardoCroci/claude-tap"
  url "https://github.com/EdoardoCroci/claude-tap/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "06628bb25a220ac28cb1fe5cc2b9f00ab3239ebdd8374e4b8f99e914462be32f"
  version "1.8.0"
  license "MIT"

  depends_on :macos
  depends_on "jq"

  def install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"macos/setup.sh" => "claude-tap-setup"
    bin.install_symlink prefix/"macos/configure.sh" => "claude-tap-configure"
    bin.install_symlink prefix/"macos/uninstall.sh" => "claude-tap-uninstall"
  end

  # Re-run setup after every `brew install` / `brew upgrade` so new Swift
  # sources are recompiled, hooks stay registered, and the AX permission
  # prompt (if still needed) fires at upgrade time. setup.sh is idempotent
  # and `--quiet` suppresses its informational lines — failures are
  # logged but do not fail the brew install.
  def post_install
    system "#{bin}/claude-tap-setup", "--quiet"
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
