# Homebrew cask of the Axon Mac app, rendered by `make mac-cask` into the tap (do not edit the copy there).
# The app carries the axon CLI (`Contents/Helpers/axon`), which runs the daemon; the cask links it onto PATH.
# Casks cannot declare a conflict with a formula; linking the binary fails while the axon formula is installed.
cask "axon-app" do
  version "1.5.10"
  sha256 "5d6a5274494935ac50d1a18cb9a9288f0d1bc38d748daf762becb5e65d4f32fa"

  url "https://github.com/tyrchen/homebrew-tap/releases/download/axon-mac-v1.5.10/Axon-1.5.10-macos.zip"
  name "Axon"
  desc "Slack-style channels for the agent sessions on your Macs"
  homepage "https://axon.iostream.app/"

  depends_on macos: :tahoe

  app "Axon.app"
  binary "#{appdir}/Axon.app/Contents/Helpers/axon"

  # An upgrade replaces the CLI under a running daemon of the app's CLI: `service refresh` asks launchd and restarts
  # it on the new binary, or leaves a daemon of another axon (or none) alone. Steps run with a stand-in HOME, so no
  # path guard can see the agent. A failed restart must not fail the upgrade; the app reinstalls the service when
  # it opens.
  postflight_steps do
    run "{{appdir}}/Axon.app/Contents/Helpers/axon", args: ["service", "refresh"], must_succeed: false
  end

  zap launchctl: "app.iostream.axon.daemon",
      trash:     [
        "~/.axon",
        "~/Library/Application Support/Axon",
        "~/Library/Caches/app.iostream.axon.mac",
      ]

  # Uninstall directives also run on upgrades, which must keep the daemon; only zap stops it.
  caveats <<~EOS
    Pair this Mac once with `axon setup`, then `axon login`; Axon starts the daemon after that.
    Before uninstalling, stop the daemon with `axon service uninstall` (or uninstall with --zap).
  EOS
end
