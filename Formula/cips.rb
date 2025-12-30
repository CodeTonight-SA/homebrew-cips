# Homebrew formula for CIPS - Claude Instance Preservation System
# https://github.com/CodeTonight-SA/claude-optim

class Cips < Formula
  desc "Claude Instance Preservation System - AI session continuity and efficiency"
  homepage "https://github.com/CodeTonight-SA/claude-optim"
  url "https://github.com/CodeTonight-SA/homebrew-cips/releases/download/v4.1.0/cips-4.1.0.tar.gz"
  sha256 "fffcf879b9c4c6b48b3573ea04eac75e7c8bc8271119bbe4edfe2dfbe41e5dea"
  license "MIT"
  version "4.1.0"

  depends_on "python@3.11"
  depends_on "jq"

  def install
    bin.install "bin/cips"
    (share/"cips").install Dir["share/cips/*"]
  end

  def caveats
    <<~EOS
      CIPS v#{version} installed!

      Run 'cips' to begin. First run will:
        - Create ~/.claude/ directory
        - Copy CIPS infrastructure (46 skills, 28 agents, 55+ libraries)
        - Guide you through identity setup

      Team members: Set your team password in ~/.claude/.env
        echo 'CIPS_TEAM_PASSWORD="your-password"' >> ~/.claude/.env

      Quick commands after setup:
        cips              # Auto-resume or fresh session
        cips resume latest # Resume last session
        cips fresh        # Start fresh session
        cips list         # List available sessions

      Documentation: https://github.com/CodeTonight-SA/claude-optim
    EOS
  end

  test do
    assert_match "CIPS v#{version}", shell_output("#{bin}/cips --version")
  end
end
