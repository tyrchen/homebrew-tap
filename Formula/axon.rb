# Homebrew formula of the axon CLI, rendered by `make cli-formula` into the tap (do not edit the copy there).
class Axon < Formula
  desc "Drive Claude Code and Codex sessions on your Mac from your iPhone"
  homepage "https://axon.iostream.app"
  url "https://github.com/tyrchen/homebrew-tap/releases/download/axon-v1.5.3/axon-1.5.3-macos-universal.tar.gz"
  version "1.5.3"
  sha256 "8d70f26acf8d67c567494e407dd6688a91e38b07f8390ab7f79d237569b04a93"

  depends_on :macos

  def install
    bin.install "axon"
  end

  def caveats
    <<~EOS
      Finish with:
        axon setup     # hooks for Claude Code and Codex, and the background daemon
        axon login     # then approve the code in the Axon app
        axon doctor    # checks everything
      After `brew upgrade axon`, run `axon service install` to restart the daemon.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/axon --version")
  end
end
