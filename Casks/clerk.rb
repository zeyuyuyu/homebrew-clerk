cask "clerk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.8.7"
  sha256 arm:   "7788c8636578ab57efffcd5c7c2ec018f5a9d47d158b7745b36b42d104e0b5c9",
         intel: "012dd2dd6b8fd22a1f73dbd141339b8597cefdddc71b6e8818b4b801d4e3a53b"

  # Versioned on purpose. The unversioned /download/mac/#{arch} always serves
  # the current build, so its bytes change under the cask and every install
  # would fail its checksum until this file caught up.
  url "https://www.getcomputeruse.com/download/mac/#{version}/#{arch}",
      verified: "getcomputeruse.com/"
  name "Clerk"
  desc "Computer-use agent driven from a browser chat box"
  homepage "https://www.getcomputeruse.com/"

  depends_on macos: ">= :monterey"

  app "Clerk.app"

  uninstall quit:   "ai.clerk.agent",
            signal: [["TERM", "ai.clerk.agent"]]

  # The agent's own state — transcripts, settings, device id. Left alone by
  # `uninstall` so reinstalling doesn't wipe someone's history; `--zap` removes it.
  zap trash: [
    "~/.clerk",
  ]

  # Setup instructions, not a warning: the agent literally cannot move the
  # pointer or see the screen until these two are granted, so without this a
  # fresh install looks broken.
  caveats <<~EOS
    On first run macOS will ask for two permissions, and Clerk cannot act
    until both are granted:

      System Settings > Privacy & Security > Accessibility
      System Settings > Privacy & Security > Screen Recording
  EOS
end
