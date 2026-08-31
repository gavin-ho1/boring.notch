<h1 align="center">
  boring.notch — HUD-only fork
</h1>

This is a personal fork of [Boring Notch](https://github.com/TheBoredTeam/boring.notch), stripped down to do exactly one thing: show a clean inline HUD near the notch for **volume and brightness changes**. All of the original project's other notch features — music live activity, calendar, shelf/AirDrop, hover-to-open, battery notifications, face animation, gestures — have been removed.

## What's different from upstream

- **Notch UI stripped to the inline HUD only.** The notch no longer opens, expands on hover, or shows music/calendar/shelf/battery content. It just renders the inline volume/brightness/backlight indicator when a change happens, then disappears.
- **No more click/tick sound on volume change.** The system beep that played on each volume key press has been removed entirely.
- **HUD reacts to changes from any source**, not just the keyboard media keys — volume changed from Control Center, another app, AirPods, or System Settings will now trigger the HUD too, since it listens directly to CoreAudio for volume/mute changes and polls the actual screen brightness for changes.
- Settings for the HUD itself (glow effect, accent color tint, gradient vs. hierarchical progress bar, "Replace system HUD" toggle) are unchanged from upstream.

## Requirements

- macOS 14 (Sonoma) or later
- Apple Silicon or Intel Mac
- Xcode 26 or later (to build)

## Building from source

1. **Clone the repository**:
   ```bash
   git clone https://github.com/gavin-ho1/boring.notch
   cd boring.notch
   ```

2. **Open the project in Xcode**:
   ```bash
   open boringNotch.xcodeproj
   ```

3. **Build and run**: select the `boringNotch` scheme and press `Cmd + R`, or build from the command line:
   ```bash
   xcodebuild -scheme boringNotch -configuration Debug -destination 'platform=macOS' build
   ```
   The built app lands in DerivedData, e.g.:
   ```
   ~/Library/Developer/Xcode/DerivedData/boringNotch-*/Build/Products/Debug/boringNotch.app
   ```
   Launch it with `open path/to/boringNotch.app` (never execute the `.app` bundle directly or with `sudo`).

4. **(Optional) Move it to /Applications** so it launches from Spotlight/Launchpad like a normal app:
   ```bash
   cp -R "path/to/boringNotch.app" /Applications/
   ```
   Note: this is a manual copy, not a symlink or install — the `/Applications` copy won't update itself when you rebuild. If you rebuild after changing code, either re-run this copy step or launch straight from the DerivedData path above. Since the signature is the same across rebuilds from the same machine, your Accessibility permission grant (see below) should carry over.

## First-run setup

1. Click the sparkle icon in the menu bar → **Settings** → **HUD** tab.
2. Toggle **"Replace system HUD"** on. macOS will prompt for **Accessibility** permission — approve it in System Settings → Privacy & Security → Accessibility.
3. Change the volume or brightness from any source to see the inline HUD appear near the top of the screen.

> If the toggle looks "on" but nothing happens after rebuilding the app, macOS's Accessibility grant is tied to the app's exact code signature. A fresh local (ad-hoc signed) build can invalidate a previous grant. Remove the stale entry in System Settings → Privacy & Security → Accessibility and re-toggle "Replace system HUD" to re-trigger the permission prompt.

## Acknowledgments

All credit for the original design, architecture, and feature set goes to **[TheBoredTeam/boring.notch](https://github.com/TheBoredTeam/boring.notch)**. This fork exists purely as a minimal, personal HUD-only variant and is not affiliated with or endorsed by the upstream project.

See [Third-Party Licenses](./THIRD_PARTY_LICENSES.md) for full attributions.
