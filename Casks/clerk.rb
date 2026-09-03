cask "clerk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.15.0"
  sha256 arm:   "a0ada099a9edd8f00e9fdff209df11afcca11b44f06d43bc08f3508cd601518f",
         intel: "be496d3b03b8f3f131ec1657befca1e9ebeaeb8dac7344b2235fb444e2a3688d"

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
