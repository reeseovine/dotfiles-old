# dotfiles
These are most of the configuration files I use to get my setup to look and behave how it does. Here are some notable things about them. (Screenshots coming soon-ish)

The directories in the root of the repository (*not* files such as this README) have symlinks pointing to them with the same names, located in `~/.config/`, unless stated otherwise. The files in the root are mostly there for repo management.

There is also an [`archive` branch](https://github.com/katacarbix/dotfiles/tree/archive) that contains interesting stuff for apps that I don't use anymore including Atom and Vivaldi. It's worth checking out if you don't see what you're looking for in here.

Note: I've been trying out Wayland recently and I may or may not switch to it in the future, which means a bunch of stuff in this repo could change. If that's the case it will all be available in the archive.

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
  * [Sublime Text](#sublime-text)
  * [Discord](#discord)
  * [Fonts](#fonts)
- [Terminal environment](#terminal-environment)
  * [kitty](#kitty)
  * [fish](#fish)
  * [ranger](#ranger)
  * [Scripts](#scripts)
    + [rofi](#rofi-1)
    + [Backups](#backups)
    + [Scripts you should know about that weren't mentioned elsewhere](#scripts-you-should-know-about-that-werent-mentioned-elsewhere)
- [Miscellanea](#miscellanea)
- [Package lists](#package-lists)

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
- Firefox
- Discord
- the RGB keyboard in my laptop  
  (still trying to make it work on my not-programmable-over-USB keyboard...)

Some of these refresh their colors automatically but most need to be told to refresh either by [a script](scripts/pywal) or by [a parent program](https://github.com/katacarbix/dotfiles/blob/bb6a9675db69ca6dacb3486502b54762e22f9585/i3/config#L278).


## Glamor
### [i3](i3/config)
[i3-gaps](https://github.com/Airblader/i3) is a fork of the tiling window manager that adds the ability to create gaps between windows in tiling mode so your wallpaper can peek through. In addition to window styling, my config adds quite a few keyboard shortcuts for things like starting apps quickly, opening rofi menus, and taking screenshots.

### [compton](misc/compton.conf)
A small but powerful composition backend for X desktops. tryone144's [dual_kawase](https://github.com/tryone144/compton/tree/dual_kawase) branch adds a really nice strong blur behind windows. I gave most windows a subtle shadow too which just makes things look a little less flat.

Compton has the ability to make windows semi-transparent but I chose to forgo this feature in favor of creating transparent areas within some apps. I then turned off blurring in compton's config for any program that's opaque, because there's no reason to blur something I'm not even going to see.

### [polybar](polybar)
A status bar with easy access to scripts and whatever else I need. There's the `main` bar, and one called `secondary` which is stripped down for multi-monitor setups. The [`polybar`](scripts/polybar) script detects monitors and places these bars automatically.

### [dunst](dunst/dunstrc)
A notification daemon that displays desktop notifications. Its appearance is pretty extensively customizable, but sadly one thing it can't do is background transparency so it has to be applied to the entire notification. Luckily it's not too noticeable (in my opinion). It doesn't use colors from wal because I think it looks better without them.

### [rofi](rofi/config.rasi)
Mostly just preferences for behavior rather than appearance, which is taken care of in [this wal template](wal/templates/colors-rofi-dark.rasi). When I have time I want to go through and update the theme to account for some things I didn't know about when I first made it (like the `-mesg` line).

### [wal](wal)
Contains templates for programs to import the colors and handmade color schemes for some wallpapers.

### [Firefox](firefox)
I'm using the [Pywalfox](https://github.com/Frewacom/pywalfox) extension + a few UI tweaks in my `userChrome.css` and `userContent.css`. I'm also using everything in my [`userstyles` repo](https://github.com/katacarbix/userstyles) with the [Stylus](https://github.com/openstyles/stylus) extension.

### [Sublime Text](sublime-text)
*Symlinked as ~/.config/sublime-text-3/Packages/User*
I have yet to create a UI theme that matches the rest of my desktop, so for now I'm using the [gruvbox](https://packagecontrol.io/packages/gruvbox) theme. It works with any color scheme, not just gruvbox.

### Discord
<small><em><strong>NOTE:</strong> Modifying the Discord client's code goes against Discord's Terms of Service! By doing this your account is subject to suspension. Though I have not heard of this happening, if it happens to you don't say I didn't warn you.</em>  
Okay where were we...</small>

First I installed [EnhancedDiscord](https://github.com/joe27g/EnhancedDiscord) for its CSS loading and other neat plugins. To enable transparency follow these steps:

1. Make sure you have `npm`, then install `asar` with `sudo npm i -g asar`.
2. Exit Discord completely.
3. cd into `~/.config/discord/0.0.XX/modules/discord_desktop_core/` (where "XX" is the current version number), then unpack the core program with `asar extract core.asar core.asar.extracted`.
4. Open the file `core.asar.extracted/app/mainScreen.js` in your text editor of choice.
5. Around line `372` inside the `mainWindowOptions` object and outside of the `webPreferences` object, set `backgroundColor: '#00000000'` and `frame: false`, and add the line `transparent: true`. Make sure there's a comma after all of these.
6. Save this file, then package it back up with `asar pack core.asar.extracted core.asar`. If you did it correctly you should be able to start Discord again!

I modified the application entry to use the command line argument `--remote-debugging-port=1666` which allows [the `lightswitch` script](scripts/lightswitch) to switch between light and dark mode.
I'm using the pywal variant of my [Bliss theme](https://github.com/katacarbix/discord-stuff/) which gets recompiled by the pywal script.

### Fonts
The sans-serif font I use is [Roboto](https://github.com/googlefonts/roboto). I use a [Nerd Font](https://github.com/ryanoasis/nerd-fonts)-patched version of [Fira Code](https://github.com/tonsky/FiraCode), a monospaced programming font, in my terminal and code editor. I have an older version of it installed as well because [the newer version doesn't look right in polybar](https://github.com/polybar/polybar/issues/991).

## Terminal environment
### [kitty](kitty/kitty.conf)
I like [kitty](https://sw.kovidgoyal.net/kitty/) because it's fast and has many settings to get it to look and work how I want it to. A good terminal emulator makes working inside of it much more enjoyable. Pywal can set the colors of most terms automatically, and kitty is one of them.

My config contains only the features that I need. I try not to get bogged down by learning every single thing that it can do and just rely on i3 for most of that.

### [fish](fish)
fish is nice because it leaves behind some of the typical shell paradigms carried through the decades in favor of having a much more friendly user experience.

I was hesitant to try it at first because people say it's "not POSIX-compliant". But what does that mean, really? The scripts that I had written already have a [hashbang](https://en.wikipedia.org/wiki/Shebang_(Unix)) line at the top, which should always be standard practice anyway. Another supposed drawback is that most shell-code pasted into the terminal won't always work right away, but I found this to be the case with zsh sometimes too.

Overall I think fish is easier to use, and if backwards-compatibility is needed it's easy to just switch to another shell temporarily.

I'm using [oh my fish](https://github.com/oh-my-fish/oh-my-fish) with the `bobthefish` theme.

### [ranger](ranger)
A TUI file manager. It's highly customizable but I found that there isn't much that I really needed to change to make it work well. There's a bit of a learning curve to it but there are plenty of helpful resources you can find.


### [Scripts](scripts)
*Symlinked as ~/scripts*  
*Included in $PATH*

All of the scripts below were either written by me or borrowed from someone else and modified for my use case. I don't want to reupload unmodified scripts, so for those, check out the section near the end with links to other scripts and packages that I find useful.

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

**rebar** *by me*  
(Re)starts polybar. It detects primary and secondary displays and puts the correct bar on each.

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

#### [rofi](scripts/rofi)
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

#### Backups
I made a few files for managing backups:
- [`backup`](scripts/backup) - The main script. It can start and stop backups, and it will keep running until it's done. It's basically just a wrapper for `rsync` with extra features like notifications, logging, and a single-instance lock.
- [`backupctl`](scripts/rofi/backupctl) - A rofi menu where you can start or stop a backup in the background and view the log file without having to do it manually in a terminal.
- [`backup-status`](polybar/scripts/backup-status) - An indicator for polybar that shows if a backup is running, finished, failed, or out of date. It might need some modification to work with other status bars. Here's my polybar module:
  ```ini
  [module/backup]
  type = custom/script
  exec = ~/.config/polybar/scripts/backup-status
  tail = true ; only show last line of output
  click-left = ~/scripts/rofi/backupctl
  ```
- [`backup/`](backup) - Contains a [config](backup/config) file, a [list](backup/excludelist) of patterns to exclude, and the rsync daemon [config](backup/rsyncd.conf) that goes on the server.

**Why?**  
For a while I'd been looking for a simple backup solution for Linux that also felt seamless and integrated into the desktop, but none suited my needs. Once I looked into rsync I immediately loved how easy it was but I got tired of typing the entire command each time (or scrolling through my term history for it) so I wrote these in a day to make things easier for me.

**Shortcomings**  
I didn't include the ability to create multiple backups or schedule them, but I don't think it would be hard to add those features. It's also highly tailored to my needs and setup which means you might need to translate some of the code to work if you use different programs than me.

_**BUG:** Does not report errors correctly._

#### Scripts you should know about that weren't mentioned elsewhere
*Located in ~/.local/bin/ or installed using a package manager*

[**askpass-rofi**](https://github.com/davatorium/rofi/issues/584#issuecomment-384555551)  
Gives scripts a way to prompt for sudo access without a terminal. Prepend commands with `SUDO_ASKPASS=/path/to/askpass-rofi sudo -A` (or add the first part to `.profile`/`.bashrc`) to use.

[**autojump**](https://github.com/wting/autojump)  
Quickly navigates your filesystem by keeping a record of your most-visited directories.

[**Bitwarden**](https://bitwarden.com/), [**rbw**](https://github.com/doy/rbw), and [**rofi-rbw**](https://github.com/fdw/rofi-rbw)  
Open-source password manager with apps and extensions for many platforms.

[**clipster**](https://github.com/mrichar1/clipster) and [**rofi-clipster**](https://github.com/fdw/rofi-clipster)  
Simple and performance-friendly clipboard history manager.

[**h**](https://github.com/zimbatm/h)  
Clones git repos and organizes them by their URL (like `go get`) and `cd`s into them.

[**kb-backlight**](https://github.com/hastinbe/i3-kb-backlight)  
Controls keyboard backlight brightness.

[**maim**](https://github.com/naelstrof/maim)  
Takes screenshots.

[**ripgrep (`rg`)**](https://github.com/BurntSushi/ripgrep)  
Searches for patterns within files in a directory. Super fast.


## Miscellanea
*Stored in [`misc/`](misc)*

- [`.bash_aliases`](misc/.bash_aliases) *Symlinked in \~* - Command aliases sourced by bash and fish.
- [`.profile`](misc/.profile) *Symlinked in \~* - Script that runs when a shell is opened.
- [`.xinitrc`](misc/.xinitrc) *Symlinked in \~* - Script that runs when X session starts.
- [`libinput-gestures.conf`](misc/libinput-gestures.conf) *Symlinked in ~/.config/* - Touchpad gestures for libinput.
- [`lightdm-mini-greeter.conf`](misc/libinput-gestures.conf) *Symlinked in /etc/lightdm/* - Config file for [lightdm-mini-greeter](https://github.com/prikhi/lightdm-mini-greeter).
- [`logid.cfg`](misc/logid.cfg) *Symlinked in /etc/* - Gesture and button mapping for Logitech mice using [logiops](https://github.com/PixlOne/logiops).
- [`rofimoji.rc`](misc/rofimoji.rc) *Symlinked in ~/.config/* - Config for [rofimoji](https://github.com/fdw/rofimoji), a Unicode character picker.


## Package lists
There are a few lists of packages installed by different package managers; most of them reside in [`pkg/`](pkg). The lists are as follows:

- [Aptitude](pkg/apt.txt)
- [Cargo (Rust)](pkg/cargo.txt)
- [Git](pkg/git.txt) - these are built from source (when needed) and installed globally.
- [NPM (NodeJS)](package.json) - (under "dependencies")
- [Oh My Fish](pkg/omf.txt)
- [Pip (Python)](pkg/pip.txt)
