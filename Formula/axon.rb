# Homebrew formula of the axon CLI, rendered by `make cli-formula` into the tap (do not edit the copy there).
class Axon < Formula
  desc "Drive Claude Code and Codex sessions on your Mac from your iPhone"
  homepage "https://axon.iostream.app"
  url "https://github.com/tyrchen/homebrew-tap/releases/download/axon-v1.11.10/axon-1.11.10-macos-universal.tar.gz"
  version "1.11.10"
  sha256 "e5b886ef3f3fba2a4f4ce65d6087c99111d56ab29244e973c11f79c3c3c504dc"

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
