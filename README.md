# dotfiles
These are most of the configuration files I use to get my setup to look and behave how it does. Here are some notable things about them. (Screenshots coming soon-ish)

The directories in the root of the repository (*not* files such as this README) have symlinks pointing to them with the same names, located in `~/.config/`, unless stated otherwise.

<table>
	<tr>
		<td>
<!-- AUTO-GENERATED-CONTENT:START (TOC:collapse=true&collapseText=Table of Contents) -->
<details>
<summary>Table of Contents</summary>

- [Colors](#colors)
- [Glamor](#glamor)
  * [i3](#i3)
  * [compton](#compton)
  * [polybar](#polybar)
  * [dunst](#dunst)
  * [rofi](#rofi)
  * [wal](#wal)
  * [Firefox](#firefox)
  * [Sublime Text 3](#sublime-text-3)
  * [Electron apps](#electron-apps)
    + [Atom](#atom)
    + [Discord](#discord)
  * [Fonts](#fonts)
- [Terminal environment](#terminal-environment)
  * [kitty](#kitty)
  * [fish](#fish)
  * [ranger](#ranger)
  * [neofetch](#neofetch)
- [Scripts](#scripts)
  * [rofi](#rofi-1)
  * [Backups](#backups)
  * [Scripts you should know about that weren't mentioned elsewhere](#scripts-you-should-know-about-that-werent-mentioned-elsewhere)
- [Miscellanea](#miscellanea)

</details>
<!-- AUTO-GENERATED-CONTENT:END -->
		</td>
	</tr>
</table>


## Colors
[pywal](https://github.com/dylanaraps/pywal) is a tool that picks a wallpaper and generates a color palette from the dominant colors in it. The colors are used in various parts of my desktop, including:

- i3 (and i3-lock)
- polybar
- rofi
- kitty (and other terminal emulators)
- Sublime Text
- Atom
- Firefox
- Discord
- the RGB keyboard in my laptop  
	(still trying to make it work on my not-programmable-over-USB keyboard...)

Some of these refresh their colors automatically but most need to be told to refresh either by [a script](scripts/pywal) or by [a parent program](i3/config#L270).


## Glamor
### [i3](i3/config)
[i3-gaps](https://github.com/Airblader/i3) is a fork of the tiling window manager that adds the ability to create gaps between windows in tiling mode so your wallpaper can peek through. In addition to window styling, my config adds quite a few keyboard shortcuts for things like starting apps quickly, opening rofi menus, and taking screenshots.

### [compton](compton.conf)
compton is a small but powerful composition backend for X desktops. `tryone144`'s [dual_kawase](https://github.com/tryone144/compton/tree/dual_kawase) branch adds a really nice blur behind windows that can go up to much higher radii which I prefer. I gave most windows a subtle shadow as well that just makes things look a little less flat.

compton has the ability to make windows semi-transparent but I chose to forgo this feature in favor of creating transparent areas within some apps. I then turned off blurring in compton's config for any program that's opaque, because there's no reason to blur something I'm not even going to see.

### [polybar](polybar)
This was actually one of the first pieces I added to my environment. I started with [this theme](https://github.com/adi1090x/polybar-themes#-polybar-4) and heavily modified it over time using [polybar's wiki](https://github.com/polybar/polybar/wiki) for help. As you can probably tell it looks rather different but I'm keeping the attribution just for record-keeping's sake.

There's the `main` bar, and one called `secondary` which is stripped down for multi-monitor setups.

### [dunst](dunst/dunstrc)
A notification daemon that displays desktop notifications. Its appearance is pretty extensively customizable, but sadly the one thing that it can't do is variable transparency, so it has to be applied to the entire notification. Luckily it's not too noticeable (in my opinion). It doesn't use colors from wal because I think it looks better without them.

### [rofi](rofi/config.rasi)
Mostly just preferences for behavior rather than appearance, which is taken care of in [this wal template](wal/templates/colors-rofi-dark.rasi). When I have time I want to go through and update the theme to account for some features I didn't know about when I first made it (like the `-mesg` line).

### [wal](wal)
Contains templates to make it easier for other programs to import the colors.

### Firefox
I'm using the [Pywalfox](https://github.com/Frewacom/pywalfox) extension + a few UI tweaks in my [`userChrome.css`](firefox/userChrome.css).

### Sublime Text 3
*Symlinked as ~/.config/sublime-text-3/Packages/User*

I'm trying out Sublime Text for a bit and so far it seems incredibly smooth and snappy. I was an avid Atom user until it started becoming slow and unresponsive most of the time. I also tried VSCodium, but ultimately I wanted to move away from Electron when I have the choice.

I'll keep the Atom section below for now, but in the future I may move it (and some other old stuff) to an `archive` branch.

### Electron apps
Electron-based applications are nice because they use CSS to change how they look. Many of them support user stylesheets (and maybe even transparency) out of the box, but others need to be modified a little.

#### [Atom](atom)
*Symlinked as ~/.atom*

Because it does not support transparent themes out of the box (on Linux, at least), I needed to make a quick modification to its internals. Don't worry, it doesn't involve building anything from source. Here are the steps I followed:
0. Make sure you have `npm`, then install `asar` with `sudo npm i -g asar`.
1. Exit Atom completely.
2. cd into `/usr/share/atom/resources/`, then unpack the main program with `sudo asar extract app.asar app.asar.extracted`. You must use `sudo` because it's in a write-protected directory.
3. Open the file `app.asar.extracted/src/main-process/atom-window.js` in your text editor of choice (with root privileges).
4. Around line 38 inside the `options` object and outside of the `webPreferences` object, add the line `transparent: true,` which will make the window background transparent. (I've also added `frame: false,` to mine which will hide the window title and menu bars. You don't have to.)
5. Save this file, then package it back up in the terminal with `sudo asar pack app.asar.extracted app.asar`. If you did it correctly you should be able to start Atom again! You won't see a difference at first because...
6. You need a theme that supports transparency! I'm using my [Fang](https://github.com/katacarbix/fang-ui) and [Wave](https://github.com/katacarbix/wave-ui) UI themes (dark and light mode, respectively). [native-ui](https://atom.io/themes/native-ui) works rather well too.

I wrote some styles to go along with Fang/Wave in [my stylesheet](atom/styles.less) that adds colors from pywal.

#### Discord
<small><em><strong>NOTE:</strong> Modifying the Discord client's code goes against Discord's Terms of Service! By doing this your account is subject to suspension. Though I have not heard of this happening, If it happens to you don't say I didn't warn you.</em>
Okay where were we...</small>

First I installed [EnhancedDiscord](https://github.com/joe27g/EnhancedDiscord) for its CSS loading and other neat plugins.
To enable transparency (and blur on supported systems/DEs) you should install [Glasscord](https://github.com/AryToNeX/Glasscord). I used it for a while but was having some issues with recent versions of the Discord client and didn't feel like fixing it (don't tell Naomi 🤫) so I opted for a similar method to the one for Atom. The package you'll want to modify is `~/.config/discord/0.0.XX/modules/discord_desktop_core/core.asar` (where "XX" is the current version number). I won't say more beyond that so I can cover my a\$\$ 🤐. I bet you can figure it out.
I then start it each time (or just modify the application entry) with the command line argument `--remote-debugging-port=1666` to allow [the `lightswitch` script](scripts/lightswitch) to switch between light and dark mode.
I'm using the pywal variant of my [Bliss theme](https://github.com/katacarbix/discord-stuff/) which gets recompiled by the pywal script.

### Fonts
The sans-serif font I use is [Roboto](https://github.com/googlefonts/roboto). I use a [Nerd Font](https://github.com/ryanoasis/nerd-fonts)-patched version of [Fira Code](https://github.com/tonsky/FiraCode), a monospaced programming font, in my terminal and code editor. I have an older version of it installed as well because [the newer version doesn't look right in polybar](https://github.com/polybar/polybar/issues/2045).

## Terminal environment
### [kitty](kitty/kitty.conf)
I like [kitty](https://sw.kovidgoyal.net/kitty/) because it's fast, rendered on the GPU, and has many settings to get it to look and work how I want it to. A good terminal emulator makes working inside of it much more enjoyable. Pywal can set the colors of most terms automatically, and kitty is one of them.

My config contains only the features that I need. I tried not to get bogged down by learning every single thing that it can do and just rely on i3 for most of that.

### [fish](fish)
fish is nice because it leaves behind some of the typical shell paradigms carried through the decades in favor of having a much more friendly user experience.

I was hesitant to try it at first because people said it's "not POSIX-compliant". But what does that mean, really? The scripts that I had written already have a [hashbang](https://en.wikipedia.org/wiki/Shebang_(Unix)) line at the top, which should always be standard practice anyway. Another supposed drawback is that most shell-code pasted into the terminal won't always work right away, but I found this to be the case with zsh sometimes too.

Overall I think fish is easier to use, and if backwards-compatibility is needed it's easy to just switch to another shell temporarily.

I'm using [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) with the `bobthefish` theme.

### ranger
A TUI file manager. It's highly customizable but I found that there isn't much that I really needed to change to make it work well. There's a bit of a learning curve to it but there are plenty of helpful resources you can find.

### neofetch
A simple little fetch utility that displays info about the computer.


## [Scripts](scripts)
*Symlinked as ~/scripts*

All of the scripts below were either written by me or borrowed from someone else and modified for my use case. I don't want to reupload unmodified scripts. Instead, check out the section near the end with links to scripts and packages that I find useful.

**battery-notify** *by [beatle on archlinux forums](https://bbs.archlinux.org/viewtopic.php?pid=1037160#p1037160)*
Runs in the background and warns me when laptop battery gets too low.

**colors** *by me*
Custom visualizations of terminal colors. I'm sure there are better implementations out there but this was fun to make.

**ddpv** *by me*
Basic script for imaging disks with a progress bar and notifications.

**gcal-repl** *by me*
A wrapper around [`gcalcli`](https://github.com/insanum/gcalcli) which turns it into a REPL (read-eval-print loop) rather than having to enter the full command every time. This gets wrapped with `kitty-popup` by polybar when I click the date/time widget for easy access.

**kitty-popup** *by me*
Create terminal script popup windows using kitty's remote control and i3-msg to manipulate the window.

**lightswitch** *by me*
Tells certain programs to switch to light or dark mode depending on a command line argument.

**lock** *by me*
Runs [i3lock-color](https://github.com/Raymo111/i3lock-color) using colors from wal to save lines of code elsewhere. You want to make sure you have compositor blurring or something behind it, otherwise your desktop will be visible.

**mkgameshortcut** *by me*
Creates an application shortcut given an itch.io game folder so you can access it from your app launcher or add it to Steam.

**polybar** *by me*
Starts polybar. The `main` bar goes on the primary display and a `secondary` bar goes on all the other ones.

**pywal** *by me*
Grabs a random wallpaper (or reads a path from `argv`), sets it and loads a color scheme with wal, then tells everything to update its color scheme (either directly or indirectly). Supports light and dark mode, and has an automatic option using `redshift -p`.

**rgbctl** *by me*
Sets the colors of physical devices with RGB in my setup. Right now it only sets the colors of the keyboard on my Razer Blade. It has the ability to set the Yeelight bulbs over my local network but I turned that off because it hurts my eyes 😵.

**startup-apps** *by me*
Uses i3's `append_layout` feature to restore layouts and shuffle windows upon login so I don't have to waste my time doing it manually.

**startup-daemons** *by me*
Background processes which add to my setup what other desktop environments have built in.

**update** *by me*
Update system-wide packages from different package managers in parallel. Uses rofi-askpass when not run from a terminal.

### rofi
Scripts that use rofi as their UI.

**displayout** *by me*
Menu for switching between single- and dual-monitor setups. The xrandr commands were generated by [ARandR](https://christian.amsuess.com/tools/arandr/)

**power** *by [tostiheld](https://github.com/tostiheld/dotfiles/blob/master/bin/power-menu.sh)*
Menu for shutting down, logging out, etc.

**tweet** *by me*
A wrapper around [tweet.sh](https://github.com/piroor/tweet.sh) so I can send tweets without having to open Twitter (or a terminal).

**usb** *by [luyves](https://github.com/luyves/polybar-rofi-usb-mount)*
USB device manager and client for `udisks2`.

**wiktionary** *by me*
Look up definitions from Wiktionary. You can set the language as well.

### Backups
I wrote three scripts for managing backups:
- [`backup`](scripts/backup) — The main script. It can start and stop backups, and it will keep running until it's done. It's basically just a wrapper for `rsync` with extra features like notifications and logging.
- [`backupctl`](scripts/rofi/backupctl) — A rofi menu where you can start or stop a backup in the background and open the log file without having to do it a terminal manually.
- [`backup-status`](polybar/scripts/backup-status) — An indicator for polybar which shows if a backup is running, just ran, failed, or is out of date. It might need some modification to work with other status bars but it's a good base to start with. Here's the polybar module:
	```ini
	[module/backup]
	type = custom/script
	exec = ~/.config/polybar/scripts/backup-status
	tail = true
	click-left = ~/scripts/rofi/backupctl
	```
	The line `tail = true` tells it to show only the last line of output.

The [`backup`](backup) directory contains a config file for path variables and a file containing patterns to exclude.

**Why?**
For years I'd been looking for a simple backup solution for Linux that also felt seamless and integrated into the desktop. Once I looked into rsync I immediately loved how easy it was but I got tired of typing the entire command each time (or scrolling through my term history for it) so I wrote these in a day to make things easier for me.

**Shortcomings**
I didn't include the ability to create multiple backups or schedule them, but I don't think it would be hard to add those features.

It's also highly tailored to my needs and setup which means you might need to translate some of the code to work with your desktop if you use different programs than me.

_**BUG:** Does not report errors correctly._
_**NOTE:** My backup server has been down for several months and I don't know when I'll have it back up again. There are a few issues that have gone unaddressed for a while because of this. Please check back later for updates._

### Scripts you should know about that weren't mentioned elsewhere
*Located in ~/.local/bin/ or installed using a package manager*

[**askpass-rofi**](https://github.com/davatorium/rofi/issues/584#issuecomment-384555551)
Gives scripts a way to prompt for sudo access. Prepend commands with `SUDO_ASKPASS=/path/to/askpass-rofi sudo -A` to use.

[**autojump**](https://github.com/wting/autojump)
Quickly navigates your filesystem by keeping a record of your most-visited directories.

[**git-get**](https://github.com/pietvanzoen/git-get)
Clones git repos and organizes them by their URL (like `go get`). Pairs well with autojump.

[**kb-backlight**](https://github.com/hastinbe/i3-kb-backlight)
Controls keyboard backlight brightness.

[**maim**](https://github.com/naelstrof/maim)
Takes screenshots.

[**ripgrep (`rg`)**](https://github.com/BurntSushi/ripgrep)
Searches for patterns within files in a directory. Super fast.


## Miscellanea 
*Stored in [`misc/`](misc))*

- [`libinput-gestures.conf`](misc/libinput-gestures.conf) *Symlinked in ~/.config/* — Touchpad gestures for libinput.
- [`logid.cfg`](misc/logid.cfg) *Symlinked in /etc/* — Gesture and button mapping for Logitech mice using [logiops](https://github.com/PixlOne/logiops).
- [`rofimoji.rc`](misc/rofimoji.rc) *Symlinked in ~/.config/* Config for [rofimoji](https://github.com/fdw/rofimoji), a Unicode character picker.
- [`.xinitrc`](misc/.xinitrc) *Symlinked in ~* — Script that runs when X session starts.
