# Homebrew formula template for solana-brain.
#
# Ship this from a tap (e.g. github.com/Sushant6095/homebrew-tap), then:
#   brew install Sushant6095/tap/solana-brain
#   solana-brain            # installs the brain into the current repo's ./.claude
#   solana-brain --user     # installs user-wide (~/.claude)
#
# Fill in `url` (a tagged release tarball) and `sha256` before publishing.
class SolanaBrain < Formula
  desc "Brain for building & operating a Solana company — routes across BUILD/SHIP/SECURE/GROW/OPERATE"
  homepage "https://github.com/Sushant6095/solana-brain"
  url "https://github.com/Sushant6095/solana-brain/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "<fill-in-release-tarball-sha256>"
  license "MIT"
  version "0.1.0"

  def install
    # Install the skillpack (markdown) into libexec, expose the installer as `solana-brain`.
    libexec.install Dir["*"]
    (bin/"solana-brain").write <<~SH
      #!/usr/bin/env bash
      exec "#{libexec}/install.sh" "$@"
    SH
    chmod 0755, bin/"solana-brain"
  end

  test do
    assert_predicate libexec/"skill/SKILL.md", :exist?
    assert_predicate libexec/"skill/RESOLVER.md", :exist?
  end
end
