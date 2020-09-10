# dotfiles
These are most of the configuration files I use to get my setup to look and behave how it does. Here are some notable things about them. (Screenshots coming soon-ish)

All of the files and directories in the root of the repository (except the README of course) have symlinks pointing to them with the same names, located in `~/.config/`, unless stated otherwise.

<details>
<summary><strong>Table of Contents</strong></summary>

<!-- toc -->

- [Colors](#colors)
- [Glamor](#glamor)
  * [i3](#i3)
  * [compton](#compton)
  * [polybar](#polybar)
  * [dunst](#dunst)
  * [rofi](#rofi)
  * [wal](#wal)
  * [Vivaldi](#vivaldi)
  * [Electron apps](#electron-apps)
- [Terminal environment](#terminal-environment)
  * [kitty](#kitty)
  * [fish](#fish)
  * [ranger](#ranger)
  * [neofetch](#neofetch)
- [Scripts](#scripts)
  * [rofi](#rofi-1)
  * [Backups](#backups)
- [Miscellanea](#miscellanea)

<!-- tocstop -->

</details>

<!-- AUTO-GENERATED-CONTENT:START (TOC:maxDepth=3&collapse=true&collapseText=<strong>Table of Contents</strong>) -->
<!-- AUTO-GENERATED-CONTENT:END -->


## Colors
[pywal](https://github.com/dylanaraps/pywal) is a tool that picks a wallpaper and generates a color palette from the dominant colors in it. The colors are then applied to various parts of my desktop, including:

- i3 (and i3-lock)
- polybar
- rofi
- kitty (and other terminal emulators)
- Atom
- Vivaldi
- Discord
- the RGB keyboard in my laptop  
  (still trying to make it work on my not-programmable-over-USB keyboard...)

Some of these refresh their colors automatically but most need to be told to refresh either by [a script](scripts/pywal) or by [a parent program](/katacarbix/dotfiles/blob/a9a48029a841bcfb61112c4153b24b875f49f6cb/i3/config#L268).


## Glamor
### [i3](/katacarbix/dotfiles/blob/master/i3/config)
[i3-gaps](https://github.com/Airblader/i3) is a tiling window manager. This fork adds the ability to create gaps between windows in tiling mode so your wallpaper can peek through. In addition to window styling, my config adds quite a few keyboard shortcuts for things like starting apps quickly, opening rofi menus, and taking screenshots.

### [compton](/katacarbix/dotfiles/blob/master/compton.conf)
compton is a small but powerful composition backend for X desktops. `tryone144`'s [dual_kawase](https://github.com/tryone144/compton/tree/dual_kawase) branch adds a really nice blur behind windows can go up to much higher radii which I prefer. Most windows I gave a subtle shadow as well that just makes things look a little less flat.

compton has the ability to set window transparency but I chose to forgo this feature in favor of creating transparent areas within some apps. I then turned off transparency and blurring in compton's config for any program that's opaque.

### [polybar](/katacarbix/dotfiles/blob/master/polybar)
This was actually one of the first pieces I added to my environment. I started with [this theme](https://github.com/adi1090x/polybar-themes#-polybar-4) and heavily modified it over time using [polybar's wiki](https://github.com/polybar/polybar/wiki) for help. As you can probably tell it looks rather different but I'll keep the attribution anyway just for record-keeping's sake

### [dunst](/katacarbix/dotfiles/blob/master/dunst/dunstrc)
A notification daemon that displays desktop notifications. The style is pretty extensively customizable, but sadly the one thing that it can't do is variable transparency, so it has to be applied to the entire thing. Luckily it's not too noticeable (in my opinion). It doesn't use colors from wal because I think it looks cleaner without them.

### [rofi](/katacarbix/dotfiles/blob/master/rofi/config.rasi)
I'll admit my theme is just...okay. But you know what, it gets the job done without looking too obtrusive.

### [wal](/katacarbix/dotfiles/blob/master/wal)
Contains templates to make it easier for other programs to import the colors. My rofi theme template is in there as well.

### Vivaldi
Vivaldi can use [custom CSS](/katacarbix/dotfiles/blob/master/vivaldi/common.css) with an [experimental toggle](https://forum.vivaldi.net/topic/37802/css-modifications-experimental-feature) which is nice, but it doesn't go so far as to be pywal-friendly (at least not without restarting every time). Fortunately I can use [this script](/katacarbix/dotfiles/blob/master/scripts/vivwal) (which I modified slightly) to set the theme colors automatically through a remote Chromium console. It's pretty clever honestly.

### Electron apps
Electron-based applications are nice because they use CSS to change how they look. A lot of them will support user stylesheets (and maybe even transparency) out of the box, but some of them needed to be modified a little.

#### [Atom](/katacarbix/dotfiles/blob/master/atom)
*Symlinked as ~/.atom*

Because it does not support transparent themes out of the box (on Linux, at least), I needed to make a quick modification to its internals. Don't worry, it doesn't involve building anything from source. Here are the steps:
0. Make sure you have `npm`, then install `asar` with `sudo npm i -g asar`.
1. Exit Atom completely.
2. cd into `/usr/share/atom/resources/`, then unpack the main program with `sudo asar extract app.asar app.asar.extracted`. You must use `sudo` because it's in a write-protected directory.
3. Open the file `app.asar.extracted/src/main-process/atom-window.js` in your text editor of choice (with root privileges).
4. Around line 38 inside the `options` object and outside of the `webPreferences` object, add the line `transparent: true,` which will make the window background transparent. (I've also added `frame: false,` to mine which will hide the window title and menu bars. You don't have to.)
5. Save this file, then package it back up in the terminal with `sudo asar pack app.asar.extracted app.asar`. If you did it correctly you should be able to start Atom again! You won't see a difference at first because...
6. You need a theme that supports transparency! I'm using my [Bliss UI theme](https://github.com/katacarbix/atom-bliss-blur-ui). I believe [native-ui](https://atom.io/themes/native-ui) could work as well but I haven't tried it.

#### Discord
<small><em><strong>NOTE:</strong> Modifying the Discord client's code goes against Discord's Terms of Service! By doing this your account is subject to suspension. Though I have not heard of this happening, If it happens to you don't say I didn't warn you.</em>
Okay where were we...</small>

First I installed [EnhancedDiscord](https://github.com/joe27g/EnhancedDiscord) for its CSS loading and other neat plugins.
To enable transparency (and blur on some systems/DEs) you should install [Glasscord](https://github.com/AryToNeX/Glasscord). I used it for a while but was having some issues with recent versions of the Discord client and didn't feel like fixing it (don't tell Naomi 🤫) so I opted for a similar method to the one for Atom. The package you'll want to modify is `~/.config/discord/0.0.XX/modules/discord_desktop_core/core.asar`. I won't say more beyond that so I can cover my a\$\$ 🤐. I bet you can figure it out.
I'm using the pywal variant of my [Bliss theme](https://github.com/katacarbix/discord-stuff/) which gets recompiled by the pywal script.

#### What about [Android Messages](https://github.com/katacarbix/android-messages/)<sup>[(name TBD)](https://github.com/katacarbix/android-messages/issues/6)</sup>?
It supports custom CSS, transparency, and blur/vibrancy/aero out of the box!

I use the custom theme provided in the repo but I don't actually use pywal colors (despite having created a version just for that). This is because I have it on the same workspace as [Caprine](https://github.com/sindresorhus/caprine) and, while it does support custom CSS, it's a total pain to try to figure out what selectors do what. It's just an endless cascade of React components, each with its own semi-transparent background. Thanks, Sindre 😒. Anyway the two apps look out of place being next to each other so I'm sticking with the neutral dark grey theme for now.


## Terminal environment
### [kitty](/katacarbix/dotfiles/blob/master/kitty/kitty.conf)
I like [kitty](https://sw.kovidgoyal.net/kitty/) because it's fast, rendered on the GPU, and many settings to get it to look and work how I want it to. A good terminal emulator makes working inside of it much more enjoyable. Pywal can set the colors of most terms automatically, and kitty is one of them.

My config contains only the features that I need. I tried not to get bogged down by learning every single thing that it can do and just rely on i3 for most of that.

### [fish](/katacarbix/dotfiles/blob/master/fish)
fish is nice because it leaves behind some of the typical shell paradigms carried through the decades in favor of having a much more friendly user experience.

I was hesitant to try it at first because people said it's "not POSIX-compliant". But what does that mean, really? The scripts that I had written already have a [hashbang](https://en.wikipedia.org/wiki/Shebang_(Unix)) line at the top, which should always be standard practice if you want it to be portable. Another supposed drawback is that most shell-code pasted into the terminal won't always work right away, but I found this to also be the case with zsh sometimes too.

Overall I think fish is easier to use, and if backwards-compatibility is needed it's easy to just switch to another shell temporarily.

I'm using [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) with the `bobthefish` theme.

### ranger
A TUI file manager. It's highly customizable but I found that there isn't much that I really needed to change to make it work well. There's a bit of a learning curve to it but there are plenty of helpful resources you can find.

### neofetch
A simple little fetch utility that displays info about the computer.


## [Scripts](/katacarbix/dotfiles/blob/master/scripts)
*Symlinked as ~/scripts*

All of the scripts below were either written by me or borrowed from someone else and modified for my use case. I don't want to reupload unmodified scripts, even with attribution, because that just feels like stealing to me.

**battery-notify** *by [beatle on archlinux.org](https://bbs.archlinux.org/viewtopic.php?pid=1037160#p1037160)*
Starts on login and warns me when laptop battery gets too low.

**colors** *by me*
Custom visualizations of terminal colors. I'm sure there are better implementations out there but this was fun to make.

**lock** *by me*
Runs [`i3lock-color`](https://github.com/Raymo111/i3lock-color) using colors from wal to save lines of code elsewhere. You want to make sure you have compositor blurring or something behind it, otherwise your desktop will be visible.

**polybar** *by [aid1090x](https://github.com/adi1090x/polybar-themes)*
A three-liner that restarts polybar so it can use colors from wal.

**rgbctl** *by me*
Sets the colors of physical devices with RGB in my setup. Right now it only sets the colors of the keyboard on my Razer Blade. It has the ability to set the Yeelight bulbs over my local network but I turned that off because it hurts my eyes 😵.

**vivwal** *by [wismut on vivaldi.net](https://forum.vivaldi.net/topic/34521/linux-changing-theme-via-command-line/22?_=1597433612704)*
Sets the colors of Vivaldi using `crconsole`. Vivaldi needs to be started with the command `vivaldi --remote-debugging-port=9222` for this to work.

**pywal** *by me*
Grabs a random wallpaper (or reads a path from `argv`), sets it and loads a color scheme with wal, then tells everything to update its color scheme (either directly or indirectly).

**update** *by me*
Update system-wide packages from different package managers in parallel. Uses sudo askpass so you don't need to have a terminal open.

**startup-daemons** *by me*
Background processes which add to i3 what other desktop environments have built in.

**startup-apps** *by me*
Uses i3's `append_layout` feature to restore layouts automatically upon login so I don't waste my time doing it manually. I might look into [i3-resurrect](https://github.com/JonnyHaystack/i3-resurrect) at some point if it does more than what I already have here.

### rofi
Scripts that use rofi as their UI.

**power** *by [tostiheld](https://github.com/tostiheld/dotfiles/blob/master/bin/power-menu.sh)*
Menu for shutting down, logging out, etc.

**tweet** *by me*
A wrapper around [tweet.sh](https://github.com/piroor/tweet.sh) so I can send tweets without having to open Twitter.

**wiktionary** *by me*
I started with the code for [Rofimoji](https://github.com/fdw/rofimoji) and repurposed it for looking up definitions from Wiktionary.

### Backups
I wrote three bash scripts for managing backups:
- [`backup`](/katacarbix/dotfiles/blob/master/scripts/backup) — The main script. It can start and stop backups, and it will keep running until it's done. It's basically just a wrapper for `rsync` with extra features like notifications.
- [`backupctl`](/katacarbix/dotfiles/blob/master/scripts/rofi/backupctl) — A rofi menu where you can start or stop a backup in the background and open the log file without having to do it a terminal manually.
- [`backup-status`](/katacarbix/dotfiles/blob/master/polybar/scripts/backup-status) — An indicator for polybar which shows if a backup is running, just ran, failed, or is out of date. It might need some modification to work with other status bars but I think it's a good base to start on. Here's the polybar module:
  ```ini
  [module/backup]
  type = custom/script
  exec = ~/.config/polybar/scripts/backup-status
  tail = true
  click-left = ~/scripts/rofi/backupctl
  ```
  The line `tail = true` tells it to show only the last line of output.

The [`backup`](/katacarbix/dotfiles/blob/master/backup) directory contains a config file for path variables, and a file containing patterns to exclude.

#### Why?
For years I'd been looking for a simple backup solution for Linux that also felt seamless and integrated into the desktop. Once I heard about rsync and learned how to use it I immediately loved how easy it was, but I got tired of typing the entire command each time (or scrolling through my term history for it) so I wrote these in a day to make things easier for me.

#### Shortcomings
I didn't include the ability to create multiple backups or schedule them, but I don't think it would be hard to add those features.

It's also highly tailored to my needs and setup which means you might need to translate some of the code to work with your desktop if you use different programs than me.


## Miscellanea

- [`libinput-gestures.conf`](github.com/katacarbix/dotfiles/libinput-gestures.conf) — Touchpad gestures for libinput. Config generated by [Gestures](https://gitlab.com/cunidev/gestures).
- [`.xsessionrc`](/katacarbix/dotfiles/blob/master/.xsessionrc) *(Symlinked in ~)* — A script that runs whenever an X session starts. The two things it does as of now is uses the insert key as a compose key, and turns off touchpad taps.
- [`meta/`](/katacarbix/dotfiles/blob/master/meta) — Stuff that's relevant to maintaining this repository. Not symlinked.
