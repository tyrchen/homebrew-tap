# Homebrew cask of the Axon Mac app, rendered by `make mac-cask` into the tap (do not edit the copy there).
# The app carries the axon CLI (`Contents/Helpers/axon`), which runs the daemon; the cask links it onto PATH.
# Casks cannot declare a conflict with a formula; linking the binary fails while the axon formula is installed.
cask "axon-app" do
  version "1.5.5"
  sha256 "4da37ccda1bbcbee8e3351d5d7c3de48101020aff5aeee6031e59cf065ff174b"

  url "https://github.com/tyrchen/homebrew-tap/releases/download/axon-mac-v1.5.5/Axon-1.5.5-macos.zip"
  name "Axon"
  desc "Slack-style channels for the agent sessions on your Macs"
  homepage "https://axon.iostream.app/"

  depends_on macos: :tahoe

  app "Axon.app"
  binary "#{appdir}/Axon.app/Contents/Helpers/axon"

  # An upgrade replaces the CLI under a running daemon of the app's CLI: `service refresh` restarts it on the new
  # binary, and leaves a daemon of another axon alone. A failed restart must not fail the upgrade; the app
  # reinstalls the service when it opens.
  postflight_steps do
    if_path_exists "~/Library/LaunchAgents/app.iostream.axon.daemon.plist" do
      run "{{appdir}}/Axon.app/Contents/Helpers/axon", args: ["service", "refresh"], must_succeed: false
    end
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
