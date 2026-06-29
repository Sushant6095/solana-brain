# Homebrew formula for solana-brain.
#
# Ship from a tap (github.com/Sushant6095/homebrew-tap), then:
#   brew install Sushant6095/tap/solana-brain          # latest tagged release
#   brew install --HEAD Sushant6095/tap/solana-brain    # bleeding edge from main
#
#   solana-brain            # onboard the brain into the current repo's ./.claude
#   solana-brain --user     # onboard user-wide (~/.claude)
#
# For a tagged release: set `version`, point `url` at the release tarball, and fill `sha256`
#   (brew fetch --build-from-source ./solana-brain.rb prints the sha256).
class SolanaBrain < Formula
  desc "Brain + memory for building & operating a Solana company (BUILD/SHIP/SECURE/GROW/OPERATE)"
  homepage "https://github.com/Sushant6095/solana-brain"
  url "https://github.com/Sushant6095/solana-brain/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "<fill-in-release-tarball-sha256>"
  license "MIT"
  version "0.2.0"
  head "https://github.com/Sushant6095/solana-brain.git", branch: "main"

  def install
    # Bundle the skillpack (markdown + installer) into libexec; expose the installer as `solana-brain`.
    libexec.install Dir["*"]
    (bin/"solana-brain").write <<~SH
      #!/usr/bin/env bash
      exec "#{libexec}/install.sh" "$@"
    SH
    chmod 0755, bin/"solana-brain"
  end

  def caveats
    <<~EOS
      Onboard the brain into a repo:   cd your-solana-repo && solana-brain
      Or install user-wide:            solana-brain --user

      Read-only / key-safe — solana-brain never asks for a private key; your wallet signs.
    EOS
  end

  test do
    assert_predicate libexec/"skill/SKILL.md", :exist?
    assert_predicate libexec/"skill/RESOLVER.md", :exist?
    assert_predicate libexec/"skill/references/memory.md", :exist?
    assert_predicate libexec/"install.sh", :exist?
    # Installer must run and route into a temp project without prompting.
    system bin/"solana-brain", "--project", testpath/"proj", "-y", "--plain"
    assert_predicate testpath/"proj/.claude/skills/solana-brain/SKILL.md", :exist?
    assert_predicate testpath/"proj/.solana-brain/MEMORY.md", :exist?
  end
end
