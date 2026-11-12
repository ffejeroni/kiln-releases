# Kiln

**Sixteen mixing plugins for Logic Pro, fired for heavy, dreamy rock.**

This repository holds the ready-to-install downloads. Each plugin does one job, with a few
big controls instead of a wall of numbers, and each comes in its own colour.

| Plugin | For | What it does |
| --- | --- | --- |
| **Kiln Wedge** | Drums | Drums that hit. One strip for every drum. |
| **Kiln Foot** | Bass | The ground the song stands on. Amp voices from a clean DI to full fuzz, blended so the low end never thins out. |
| **Kiln Grog** | Guitars | All the grit. None of the pain. Amp voices for DI guitars, or straight shaping for tracks already through an amp. |
| **Kiln Lip** | Vocals | The voice, up front. A complete vocal chain in one window: gate, de-ess, tone, two stages of compression, warmth and a built-in double. |
| **Kiln Ember** | Restore | Breathe on it. For tracks that went flat. |
| **Kiln Cone** | Tube warmth | Heat, measured. Tube saturation with the controls of real hardware: four preamps, up to four tubes, bias, sag, and the slight mismatch between channels. |
| **Kiln Rib** | EQ | Shape the profile. Four big knobs when you want speed, a live curve when you want detail, and three moves that fix the common problems for you. |
| **Kiln Glaze** | Mix bus | The final coat. The last plugin on the mix: bus compression, low-end control, tone, tube colour and loudness to streaming targets, with fair A/B built in. |
| **Kiln Wheel** | Chorus | Five choruses, one wheel. From the shimmering '80s pedal to string-machine ensemble to natural double-tracking, each mode with its own voices and motion. |
| **Kiln Raku** | Shoegaze | A wall of sound on one dial. Built for shoegaze. |
| **Kiln Hearth** | Reverb | Space, kept warm. Room, Chamber, Plate, Hall and Shimmer. |
| **Kiln Caliper** | Pitch correction | Tuned to the band. Pitch correction that listens to your guitars and bass to find the key, can follow the chords they're holding, and leaves breaths and whispers alone. |
| **Kiln Firing** | Mix analyzer and guide | A second set of ears that doesn't get tired. (Formerly Spyhole.) |
| **Kiln Coil** | Snare | Wound tight. One Fat dial for a thick, loud snare. |
| **Kiln Slake** | Track prep | First on every track. Brings a quiet recording up to a healthy level and clears out the hum, rumble and hiss that came with it. |
| **Kiln Damper** | Vocal gate | Drums out, singer in. A gate that rides like a fader and learns how your drums bleed into the vocal mic. |

## Install

**With one line in Terminal (easiest)**

Open Terminal (Applications → Utilities → Terminal), paste this and press Return:

```bash
curl -fsSL https://raw.githubusercontent.com/ffejeroni/kiln-releases/main/install.sh | bash
```

It downloads the Kiln menu-bar app, puts it in Applications and opens it. Because Terminal does
the download, macOS doesn't block it. Run it again any time to get the newest app.
Then click the flame in the menu bar and choose **Install all**, or install plugins one at a time.
Later, **Update all** updates only the plugins you have; new ones show up under **Install new**.
The flame changes to a circled flame when updates are waiting. If Logic was open:
**Settings → Plug-in Manager → Reset & Rescan Selection**.

**With the Kiln menu-bar app, downloaded by hand**

1. Download **Kiln-Installer.zip** from the [latest release](../../releases/tag/latest) and unzip
   it. It includes **Install Instructions.txt** with these steps.
2. Drag **Kiln.app** into Applications.
3. The first time, macOS blocks it because it isn't signed with a paid Apple developer
   certificate yet. Either run this once in Terminal:
   ```bash
   xattr -dr com.apple.quarantine /Applications/Kiln.app
   ```
   or try to open it once, then go to **System Settings → Privacy & Security** and click
   **Open Anyway**.
4. Click the flame in the menu bar and install the plugins, as above.

**By hand**

1. Download **Kiln-mac-arm64.zip** from the [latest release](../../releases/tag/latest) and unzip it.
2. Copy the `.component` files to `~/Library/Audio/Plug-Ins/Components` (and the `.vst3` files
   to `~/Library/Audio/Plug-Ins/VST3` for other hosts). In Finder, use **Go → Go to Folder**.
3. Clear the download quarantine once, in Terminal:
   ```bash
   xattr -dr com.apple.quarantine ~/Library/Audio/Plug-Ins/Components/Kiln*.component
   ```
4. In Logic, rescan as above. The plugins appear under **Audio FX → Audio Units → Kiln**.


## Windows and Linux (in testing)

Every release also has Windows and Linux builds. They're for testers for now: not yet signed (Windows may show a
SmartScreen warning: More info → Run anyway) and not yet tested in every DAW.

| File | What's in it |
| --- | --- |
| `Kiln-Setup.exe` | **Windows**: installs the VST3 and CLAP plugins where DAWs look, and the standalone apps. Start here. |
| `Kiln-windows-x64.zip`, `-CLAP.zip`, `-Standalone.zip` | Windows, to install by hand (steps inside). |
| `Kiln-linux-x64.zip` | **Linux**: VST3 and LV2 (copy to `~/.vst3` and `~/.lv2`; steps inside). Or install with one line: `curl -fsSL https://raw.githubusercontent.com/ffejeroni/kiln-releases/main/install-linux.sh \| bash` (add `-s -- --all` after `bash` for CLAP and standalone). |
| `Kiln-linux-x64-CLAP.zip`, `-Standalone.zip` | Linux CLAP (`~/.clap`) and standalone apps. |
| `Kiln-mac-arm64-CLAP.zip`, `-Standalone.zip` | Mac CLAP and standalone apps (the menu-bar app installs AU and VST3). |

## Requirements

Apple Silicon Mac, macOS 12 or later (the menu-bar app needs macOS 13). AU for Logic Pro;
VST3 for other hosts.

## Tips

- **Kiln Caliper** hears your band through Logic's side chain: open the **Side Chain** menu at
  the top of its window and pick your guitar or bass track.
- **Kiln Firing** (formerly Spyhole): put one on each group (set its Role) and one on the stereo out set to
  **Master**, then play the song. The Master window lists what to look at.
- **Kiln Damper** hears the drums through the side chain too: pick your drum bus in its
  **Side Chain** menu. It learns the bleed by itself, or press **Learn** during a drums-only part.
- **Kiln Raku**, **Lip**, **Hearth** and **Wheel** widen a mono track: insert them as
  **Mono → Stereo**.

## Licence

Kiln is licensed to you under the [Kiln End-User Licence Agreement](EULA.md): use it on your own
computers for any music, personal or commercial; just don't copy its code or redistribute it.

The plugin interfaces use Inter by Rasmus Andersson, under the SIL Open Font License
(`LICENSE-Inter.txt`).
