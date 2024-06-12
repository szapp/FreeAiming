# Free Aiming

[![Scripts](https://github.com/szapp/FreeAiming/actions/workflows/scripts.yml/badge.svg)](https://github.com/szapp/FreeAiming/actions/workflows/scripts.yml)
[![Validation](https://github.com/szapp/FreeAiming/actions/workflows/validation.yml/badge.svg)](https://github.com/szapp/FreeAiming/actions/workflows/validation.yml)
[![Build](https://github.com/szapp/FreeAiming/actions/workflows/build.yml/badge.svg)](https://github.com/szapp/FreeAiming/actions/workflows/build.yml)
[![GitHub release](https://img.shields.io/github/v/release/szapp/FreeAiming.svg)](https://github.com/szapp/FreeAiming/releases/latest)  
[![World of Gothic](https://raw.githubusercontent.com/szapp/patch-template/main/.github/actions/initialization/badges/wog.svg)](https://www.worldofgothic.de/dl/download_613.htm)
[![Spine](https://raw.githubusercontent.com/szapp/patch-template/main/.github/actions/initialization/badges/spine.svg)](https://clockwork-origins.com/spine)
[![Steam Gothic 1](https://img.shields.io/badge/steam-Gothic%201-2a3f5a?logo=steam&labelColor=1b2838)](https://steamcommunity.com/sharedfiles/filedetails/?id=2786959658)
[![Steam Gothic 2](https://img.shields.io/badge/steam-Gothic%202-2a3f5a?logo=steam&labelColor=1b2838)](https://steamcommunity.com/sharedfiles/filedetails/?id=2786958841)

Free aiming patch for Gothic, Gothic Sequel, Gothic 2 and Gothic 2 NotR

This is a modular modification (a.k.a. patch or add-on) that can be installed and uninstalled at any time and is virtually compatible with any modification.
It supports <kbd>Gothic 1</kbd>, <kbd>Gothic Sequel</kbd>, <kbd>Gothic II (Classic)</kbd> and <kbd>Gothic II: NotR</kbd>.

<sup>Generated from [szapp/patch-template](https://github.com/szapp/patch-template).</sup>

## About

Free aiming for ranged combat and spells incl. free movement while aiming (new animations).
Head shots are critical hits.
Projectiles have variable trajectory, gravity and damage.

<div align="center">
  <a href="https://www.youtube.com/watch?v=9CrFlxo21Qw"><img src="https://github.com/szapp/FreeAiming/assets/20203034/ede80ca5-845f-4ea1-92d2-e2b401467b49" alt="GFA Trailer" /></a>
</div><br />

This patch is based on [Gothic Free Aim](https://github.com/szapp/GothicFreeAim/wiki#wiki-content).

## Settings

Free aiming is available in two configurations that are accessible from the game menu.

<table><tbody>
<tr>
  <td><code>OFF</code></td>
  <td>Use Gothic's traditional auto aiming</td>
</tr><tr>
  <td><code>BALANCED</code></td>
  <td>Free aiming in balanced configuration</td>
</tr><tr>
  <td><code>REALISTIC</code></td>
  <td>More difficult with additional modulators on accuracy:

- If the bow is not drawn to its full extend (see reticle animation),
   - the shooting distance decreases (faster gravity drop)
   - the accuracy decreases (lower hit chance)
   - the damage output is reduced
- If the crossbow is not held steadily, i.e. no mouse movement (see reticle animation),
   - the accuracy decreases (lower hit chance)
   - the damage output is reduced
- The crossbow has a weapon recoil (vertical camera shift) depending on the player's strength.
- Moving while shooting reduces the accuracy by 20%

  </td>
</tr>
</tbody></table>

## Further configuration

In your Gothic installation, you find a file called Gothic.ini, e.g. in `C:\Program Files (x86)\Steam\steamapps\common\Gothic II\System\`.
More settings are available in the Gothic.ini file.
For detailed information visit the [wiki](https://github.com/szapp/GothicFreeAim/wiki/Settings-for-Players).

## Notes

- The settings automatically adjust to the game's language.
[![](https://raw.githubusercontent.com/wiki/szapp/GothicFreeAim/media/flagDE.png)](#)
[![](https://raw.githubusercontent.com/wiki/szapp/GothicFreeAim/media/flagEN.png)](#)
[![](https://raw.githubusercontent.com/wiki/szapp/GothicFreeAim/media/flagPL.png)](#)
[![](https://raw.githubusercontent.com/wiki/szapp/GothicFreeAim/media/flagRU.png)](#)

- Patch includes Gothic Free Aim.

    Gothic Free Aim, Copyright (C)  2016-2024 Sören Zapp.  
    http://github.com/szapp/GothicFreeAim  
    Released under the MIT License.

## Installation

1. Download the latest release of `FreeAiming.vdf` from the [releases page](https://github.com/szapp/FreeAiming/releases/latest).

2. Copy the file `FreeAiming.vdf` to `[Gothic]\Data\`. To uninstall, remove the file again.

The patch is also available on
- [World of Gothic](https://www.worldofgothic.de/dl/download_613.htm) | [Forum thread](https://forum.worldofplayers.de/forum/threads/1515287)
- [Spine Mod-Manager](https://clockwork-origins.com/spine/)
- [Steam Workshop Gothic 1](https://steamcommunity.com/sharedfiles/filedetails/?id=2786959658)
- [Steam Workshop Gothic 2](https://steamcommunity.com/sharedfiles/filedetails/?id=2786958841)

### Requirements

<table><thead><tr><th>Gothic</th><th>Gothic Sequel</th><th>Gothic II (Classic)</th><th>Gothic II: NotR</th></tr></thead>
<tbody><tr><td><a href="https://www.worldofgothic.de/dl/download_34.htm">Version 1.08k_mod</a></td><td>Version 1.12f</td><td><a href="https://www.worldofgothic.de/dl/download_278.htm">Report version 1.30.0.0</a></td><td><a href="https://www.worldofgothic.de/dl/download_278.htm">Report version 2.6.0.0</a></td></tr></tbody>
<tbody><tr><td colspan="4" align="center"><a href="https://github.com/szapp/Ninja/wiki#wiki-content">Ninja 2.9.15</a> or higher</td></tr></tbody></table>

<!--

If you are interested in writing your own patch, please do not copy this patch!
Instead refer to the PATCH TEMPLATE to build a foundation that is customized to your needs!
The patch template can found at https://github.com/szapp/patch-template.

-->
