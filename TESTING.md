# In-game test plan

Run this before every release (about 15 minutes) and paste the results into the release's
verification issue. Anything that doesn't behave as expected: press <kbd>F8</kbd> right there,
then attach the end of `gitgudgym.log` (*Log* button on the game page).

**Setup:** Elden Ring offline without Easy Anti-Cheat, in **Borderless** or **Windowed** mode.
Git Gud Gym running, with the Elden Ring module installed from the Library (not a dev build).

## 1. Attach

| # | Do | Expect |
|---|---|---|
| 1.1 | Open the Elden Ring page and click **Launch game** (or start the game yourself) | Status goes *Game starting* → *Attaching* → **Active** within ~30 s of the title screen |
| 1.2 | Load your save | *You* HP bar matches your in-game HP |
| 1.3 | Press <kbd>F8</kbd> and open the log | `WorldChrMan global …`, `Player …` with your HP, a `pos (…)` that changes when you move and re-probe, and `character list: N entries` with N > 0 |

## 2. Player immortality

| # | Do | Expect |
|---|---|---|
| 2.1 | Let a normal enemy kill you | No death screen. HP refills, a "YOU DIED" pop-up and sound, *Deaths* +1 |
| 2.2 | Press <kbd>F5</kbd> twice (off, then on) | Both "can't die" switches in the app follow the hotkey |

## 3. Boss

| # | Do | Expect |
|---|---|---|
| 3.1 | Walk into a boss arena (Margit is a good first test) | *Live fight* shows the boss's HP; activity says *Tracking boss* |
| 3.2 | Hit the boss | *Dealt* and *Hits* go up and the boss bar drops; the attempt timer starts |
| 3.3 | Take the boss to zero | The boss doesn't die. Its HP refills, "BOSS DEFEATED" pop-up, *Boss defeats* +1 |
| 3.4 | Die to the boss | *Deaths* +1, and a new attempt starts on the next hit |
| 3.5 | **Let boss die once** (<kbd>F7</kbd>) on a boss whose phase change is a death (Rennala) | The boss dies and the next phase is picked up automatically |

## 4. Falls

| # | Do | Expect |
|---|---|---|
| 4.1 | Stand still on flat ground for a second, then walk off a tall cliff | You're put back on the ground you stood on, with a "YOU FELL" pop-up and *Falls* +1 |
| 4.2 | Jump down a short ledge (under the fall distance) | Nothing happens |

## 5. Overlay and stats

| # | Do | Expect |
|---|---|---|
| 5.1 | Look at the top-left of the game | Mini HUD with deaths, defeats, the attempt timer and a boss HP bar |
| 5.2 | Click **Stats folder** | `attempts.csv` has a row per attempt with sensible numbers |
| 5.3 | Close Git Gud Gym | The mod unloads and the game stays running normally |

## Reporting

For each section: ✅ works / ❌ broken (with the log) / ⏭️ not tested.
Note the game patch shown on the game page.
