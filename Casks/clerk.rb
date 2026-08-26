cask "clerk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.8.1"
  sha256 arm:   "15084abbe047e730130004e3a29a9ba283fd6f1c60c356c263dcb7d787356c60",
         intel: "561b594d20026e510b22da2297400a43c55037f9ddcfc0cfec6f0ee7e8475349"

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

  caveats <<~EOS
    Clerk drives your Mac: it moves the pointer, types, and reads the screen.
    On first run macOS will ask for two permissions, and the agent cannot act
    until both are granted:

      System Settings > Privacy & Security > Accessibility
      System Settings > Privacy & Security > Screen Recording

    Screenshots taken while a task runs are uploaded to your account so the
    transcript syncs across devices. They capture whatever is on screen, so
    close anything you would not want recorded before starting a task:
    https://www.getcomputeruse.com/privacy
  EOS
end
