cask "ai-swaplane" do
  version "0.1.0"
  sha256 "8ba195a9a340a9fcfef5f3d5b7859309298516b48669ecd86eab27a342cbd364"

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
