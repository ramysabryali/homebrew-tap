cask "ai-swaplane" do
  version "0.2.0"
  sha256 "a404ec2639dace848bd5c0b1e2aa2a3edbaa5c9865eb186f9d79ad47f719422e"

  url "https://github.com/ramysabryali/ai-swaplane/releases/download/#{version}/AI-Swaplane-#{version}.zip"
  name "AI Swaplane"
  desc "Switch between Claude accounts from the menu bar"
  homepage "https://github.com/ramysabryali/ai-swaplane"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "AI Swaplane.app"
  binary "#{appdir}/AI Swaplane.app/Contents/Resources/bin/swaplane"

  # Releases are ad-hoc signed until they are notarized, so clear the quarantine flag.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/AI Swaplane.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Swaplane",
    "~/Library/Preferences/app.swaplane.mac.plist",
    "~/Library/Saved Application State/app.swaplane.mac.savedState",
  ]
end
