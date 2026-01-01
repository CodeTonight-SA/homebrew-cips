# Homebrew formula for CIPS - Claude Instance Preservation System
# https://github.com/CodeTonight-SA/cips

class Cips < Formula
  desc "Claude Instance Preservation System - AI session continuity and efficiency"
  homepage "https://github.com/CodeTonight-SA/cips"
  url "https://github.com/CodeTonight-SA/cips/archive/refs/tags/v4.1.0.tar.gz"
  sha256 "00ac66ac215cc7a4a486421ec3e15c650dedd5073771159be25a2bf8a2299359"
  license "Apache-2.0"
  version "4.1.0"

  depends_on "python@3.11"
  depends_on "jq"

  def install
    # Install main CLI scripts
    bin.install "bin/cips"
    bin.install "bin/cipsc" if File.exist?("bin/cipsc")
    bin.install "bin/claude-ut" if File.exist?("bin/claude-ut")

    # Install CIPS infrastructure to share directory
    (share/"cips").install "agents" if File.directory?("agents")
    (share/"cips").install "skills" if File.directory?("skills")
    (share/"cips").install "lib" if File.directory?("lib")
    (share/"cips").install "hooks" if File.directory?("hooks")
    (share/"cips").install "commands" if File.directory?("commands")
    (share/"cips").install "config" if File.directory?("config")
    (share/"cips").install "scripts" if File.directory?("scripts")
  end

  def caveats
    <<~EOS
      CIPS v#{version} installed!

      Run 'cips' to begin. First run will:
        - Create ~/.claude/ directory
        - Copy CIPS infrastructure (52+ skills, 29 agents)
        - Launch /login wizard for identity setup

      Quick commands after setup:
        cips              # Auto-resume or fresh session
        cips resume latest # Resume last session
        cips fresh        # Start fresh session
        cips list         # List available sessions

      Documentation: https://github.com/CodeTonight-SA/cips
    EOS
  end

  test do
    assert_match "CIPS", shell_output("#{bin}/cips --version 2>&1", 0)
  end
end
