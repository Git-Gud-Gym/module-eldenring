# Git Gud Gym for Elden Ring

The Elden Ring module for [Git Gud Gym](https://git-gud-gym.github.io/), the endless boss-practice
hub for souls-likes. Neither you nor the boss can die, and every attempt is tracked.

[![Release](https://img.shields.io/github/v/release/Git-Gud-Gym/module-eldenring?color=d4a84b&style=flat-square)](https://github.com/Git-Gud-Gym/module-eldenring/releases/latest)
[![Build](https://img.shields.io/github/actions/workflow/status/Git-Gud-Gym/module-eldenring/build.yml?branch=main&style=flat-square)](https://github.com/Git-Gud-Gym/module-eldenring/actions/workflows/build.yml)
![Elden Ring](https://img.shields.io/badge/Elden%20Ring-1.12.0-0c0d12?style=flat-square)

## Install

Install **[Git Gud Gym](https://github.com/Git-Gud-Gym/launcher/releases/latest)**, then add
Elden Ring from its **Library**. You don't need to download anything from this repo.

## What it does

- **Player can't die:** lethal hits refill your HP and count as a death.
- **Boss can't die:** at zero HP the boss refills to full and it counts as a defeat. Phase changes
  triggered by HP thresholds still happen.
- **Falling counts as death:** fall off a ledge and you're put back on the last solid ground.
- **Let boss die once (F7):** for phase changes triggered by a scripted death (Rennala, Radagon).
- **Automatic boss detection:** picks the enemy with the highest max HP within 80 m.

## Compatibility

| Patch | `eldenring.exe` | Status |
|---|---|---|
| 1.12.0 | 2.2.0.0 | ✅ Tested |
| Others | | ⚠️ Untested. Game data is found by pattern scan, so it may work. |

The memory offsets are in `gitgudgym-eldenring.ini` (installed next to the module), so a broken
offset can be fixed without a rebuild. Press <kbd>F8</kbd> in game to dump what they resolve to.

## How it works

`src/eldenring_game.cpp` implements the SDK's `GameAdapter`:
- `WorldChrMan` is found by pattern scan. The player is at `+0x1E508`, and the loaded-character list
  is at `+0x1F1B8` / `+0x1F1C0`.
- HP lives in `ChrDataModule` (`+0x138` / `+0x13C`), and position in `ChrPhysicsModule` (`+0x70`).
- "Can't die" is the per-character flag at `ChrDataModule+0x19B`, bit 0.

## Building

```bat
build.bat                                                   :: fetches the SDK version pinned in CMakeLists.txt
build.bat -DFETCHCONTENT_SOURCE_DIR_GGG_SDK=..\sdk          :: or use a local SDK checkout
```

The output lands in `bin\eldenring\`. Set `GGG_DEV_MODULES` to that `bin` folder to load it in Git
Gud Gym as a dev build. See the SDK's
[Adding a game](https://github.com/Git-Gud-Gym/sdk/blob/main/docs/ADDING_A_GAME.md) guide.

## Releasing

1. Run the [in-game test plan](TESTING.md) and post the results in the release's verification issue.
2. Bump `version` in `module.json` and add a `## vX.Y.Z` section to `CHANGELOG.md`.
3. Push the tag `vX.Y.Z`.

## License

[MIT](LICENSE). Not affiliated with or endorsed by FromSoftware or Bandai Namco. ELDEN RING is a
trademark of its respective owners.
