cask "clerk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.9.4"
  sha256 arm:   "0b3da200ae0e7513208415c85fee1e8a9bfc650ce0b2f67adf89a21229f678b0",
         intel: "d1ca878145efe8e707e3c0f0e3fd2a2b2ec6cf5322f13e27ec65319aa72957cd"

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
