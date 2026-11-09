# Homebrew formula of the axon CLI, rendered by `make cli-formula` into the tap (do not edit the copy there).
class Axon < Formula
  desc "Drive Claude Code and Codex sessions on your Mac from your iPhone"
  homepage "https://axon.iostream.app"
  url "https://github.com/tyrchen/homebrew-tap/releases/download/axon-v1.5.8/axon-1.5.8-macos-universal.tar.gz"
  version "1.5.8"
  sha256 "00ed249e7d10a8b998bd4eb83713942d29690afdfde255d5f04e28c1d7f4cc46"

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
