# Clerk — Homebrew tap

[Clerk](https://www.getcomputeruse.com) is a computer-use agent you drive from
a browser chat box: you describe the task, it works on your own Mac — moving
the pointer, typing, opening pages, and handing coding sub-tasks to Cursor or
Claude Code.

```sh
brew install --cask zeyuyuyu/clerk/clerk
```

Update it with everything else:

```sh
brew upgrade --cask clerk
```

Remove it, keeping your transcripts:

```sh
brew uninstall --cask clerk
```

Remove it along with `~/.clerk` (history, settings, device id):

```sh
brew uninstall --zap --cask clerk
```

## Before you install

Clerk is **not sandboxed and cannot be** — moving the pointer and typing are
things macOS only permits outside the sandbox, which is also why it isn't on
the Mac App Store. On first run it asks for **Accessibility** and **Screen
Recording**, and it cannot act until both are granted.

The builds are signed with a Developer ID certificate and notarized by Apple,
so they open without a Gatekeeper prompt and `--no-quarantine` is not needed.

It really does operate your computer, which means it can do irreversible
things — delete files, send messages, submit forms. Models make mistakes and
misread intent. Run it on a machine where you are willing to accept that.

Screenshots taken while a task runs are uploaded to your account so the
transcript syncs across your devices, and they capture whatever is on screen.
See the [privacy policy](https://www.getcomputeruse.com/privacy).

## Links

- [Website](https://www.getcomputeruse.com)
- [Terms](https://www.getcomputeruse.com/terms) ·
  [Privacy](https://www.getcomputeruse.com/privacy) ·
  [Refunds](https://www.getcomputeruse.com/refund)
