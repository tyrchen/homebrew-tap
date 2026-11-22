# Homebrew formula of the axon CLI, rendered by `make cli-formula` into the tap (do not edit the copy there).
class Axon < Formula
  desc "Drive Claude Code and Codex sessions on your Mac from your iPhone"
  homepage "https://axon.iostream.app"
  url "https://github.com/tyrchen/homebrew-tap/releases/download/axon-v1.17.7/axon-1.17.7-macos-universal.tar.gz"
  version "1.17.7"
  sha256 "9d72e22c53f053dadfd8fafd13e96bd00fb33f5bd48eb0386b517e02932aa94c"

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
