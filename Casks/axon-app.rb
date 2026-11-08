# Homebrew cask of the Axon Mac app, rendered by `make mac-cask` into the tap (do not edit the copy there).
cask "axon-app" do
  version "1.2.0"
  sha256 "aa1737b4aa4c139fba58c8735f0e001849c782e7125393105a5e427f16f1f2be"

  url "https://github.com/tyrchen/homebrew-tap/releases/download/axon-mac-v1.2.0/Axon-1.2.0-macos.zip"
  name "Axon"
  desc "Slack-style channels for the agent sessions on your Macs"
  homepage "https://axon.iostream.app"

  depends_on macos: ">= :tahoe"
  depends_on formula: "tyrchen/tap/axon"

  app "Axon.app"

  zap trash: [
    "~/Library/Application Support/Axon",
    "~/Library/Caches/app.iostream.axon.mac",
  ]
end
