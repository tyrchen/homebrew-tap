# Homebrew cask of the Axon Mac app, rendered by `make mac-cask` into the tap (do not edit the copy there).
# The app carries the axon CLI (`Contents/Helpers/axon`), which runs the daemon; the cask links it onto PATH.
# Casks cannot declare a conflict with a formula; linking the binary fails while the axon formula is installed.
cask "axon-app" do
  version "1.5.1"
  sha256 "d73be12298daae9c67e8948ef88ebd02a94738dbcd95ff34f8b31ef6750a216d"

  url "https://github.com/tyrchen/homebrew-tap/releases/download/axon-mac-v1.5.1/Axon-1.5.1-macos.zip"
  name "Axon"
  desc "Slack-style channels for the agent sessions on your Macs"
  homepage "https://axon.iostream.app/"

  depends_on macos: :tahoe

  app "Axon.app"
  binary "#{appdir}/Axon.app/Contents/Helpers/axon"

  # An upgrade replaces the CLI under a running daemon of the app's CLI: restart it on the new binary.
  postflight do
    agent = File.expand_path("~/Library/LaunchAgents/app.iostream.axon.daemon.plist")
    if File.exist?(agent) && File.read(agent).include?("#{appdir}/Axon.app/Contents/Helpers/axon")
      # A failed restart must not fail the upgrade; the app retries when it opens.
      system_command "#{appdir}/Axon.app/Contents/Helpers/axon", args: ["service", "install"], must_succeed: false
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
