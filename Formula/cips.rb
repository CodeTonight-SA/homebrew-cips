# Homebrew formula for CIPS - Claude Instance Preservation System
# https://github.com/CodeTonight-SA/cips

class Cips < Formula
  desc "Claude Instance Preservation System - AI session continuity and efficiency"
  homepage "https://github.com/CodeTonight-SA/cips"
  url "https://github.com/CodeTonight-SA/cips/releases/download/v5.0.2/cips-5.0.2.tar.gz"
  sha256 "88c27d3e26abccee0059e3ff4dbeb8868720a8fa2950394daf71a30ad29657dc"
  license "Apache-2.0"
  version "5.0.2"

  depends_on "node"
  depends_on "python@3.11"
  depends_on "jq"

  def install
    bin.install "bin/cips"
    (share/"cips").install Dir["share/cips/*"]
  end

  def caveats
    <<~EOS
      CIPS v#{version} installed!

      Requires Claude Code. CIPS will offer to install it on first run, or:
        npm install -g @anthropic-ai/claude-code

      Run 'cips' to begin. First run will:
        - Install Claude Code (if needed)
        - Create ~/.claude/ directory
        - Copy CIPS infrastructure (53 skills, 29 agents)
        - Guide you through identity setup

      Quick commands after setup:
        cips              # Auto-resume or fresh session
        cips resume latest # Resume last session
        cips fresh        # Start fresh session
        cips list         # List available sessions

      Optional: Semantic RL++ (pattern learning)
        After setup, run: ~/.claude/scripts/bootstrap-semantic-rl.sh
        Downloads embedding model (~90MB) for pattern detection.

      Documentation: https://github.com/CodeTonight-SA/cips
    EOS
  end

  test do
    assert_match "CIPS v#{version}", shell_output("#{bin}/cips --version")
  end
end
