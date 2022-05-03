#!/usr/bin/env bash

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
#       NOT WELL TESTED!!
#
# I just made this in like a day and have not extensively tested it yet. You can try running it but I can't guarantee that it'll work and/or won't fuck up your computer.
#
# Requirements:
#   bash
#   git
#   pacman
#   ln (and a filesystem which can handle symbolic links)
#   sudo (and the privilege to use it)


FMT_WIDTH=$([ $COLUMNS -lt 90 ] && echo $COLUMNS || echo 90)
user=$(whoami)

echo
echo "*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo "{ katacarbix's dotfiles <3  }"
echo "*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo
echo "this script will clone my dotfiles repo and install a few things to get you started on a fresh linux installation. you should always open scripts in a text editor before running them to verify there's nothing malicious or misconfigured. make sure you're running it as your user (NOT root), sudo is installed, and you are a sudoer. it may ask you a few times for your password." | fmt -w $FMT_WIDTH
echo
if [ "$user" = "root" ]; then
	echo "don't run this script as root!!"
	echo "exiting."
	exit 1
fi
read -e -p "press ENTER to continue..."
echo
echo "what type of environment should this machine have?"
echo "[0: minimal] [1: full console] [2: basic GUI] [3: full desktop]"
read -e -p "[default: 1] > " -a MACHINE_ENV
if [[ -z $MACHINE_ENV ]]; then MACHINE_ENV=1; fi
echo "clone and symbolically link dotfiles for the selected environment? WARNING: this will overwrite any configurations and dotfiles you currently have in your home directory." | fmt -w $FMT_WIDTH
read -e -p "[Y/n] > " -a LINK_DOTS
read -e -p "install Docker? [y/N] > " -a INSTALL_DOCKER
read -e -p "install VM utilities? [y/N] > " -a INSTALL_KVM
read -e -p "install gaming programs? [y/N] > " -a INSTALL_GAMES
read -e -p "install development programs? [y/N] > " -a INSTALL_DEV


## PACKAGE LISTS ##
PACMAN_BASIC=(
	base-devel
	btrfs-progs
	clang
	cmake
	curl
	dkms
	exa
	fish
	git
	htop
	jq
	kbd
	kitty
	man-db
	micro
	ncurses
	nss-mdns
	openssh
	polkit
	python
	python-pip
	ranger
	ripgrep
	ruby
	xclip
	xorg-xauth
	zoxide
)
PACMAN_CONSOLE=(
	bat
	bluetooth
	bluez
	bluez-tools
	cowsay
	diffutils
	dog
	figlet
	findutils
	fzf
	gping
	khal
	lolcat
	lynx
	ncdu
	nmap
	nodejs
	npm
	pv
	rclone
	restic
	speedtest-cli
	thefuck
	unrar
	vdirsyncer
	xdo
	xdotool
	xsel
)
PACMAN_GUI=(
	baobab
	dunst
	firefox
	i3-gaps
	maim
	redshift
	rofi
	rofi-calc
	udisks2
	xorg-server
	xorg-xrandr
)
PACMAN_DE=(
	arandr
	feh
	prusa-slicer
	python-pywal
	qopenvpn
	sassc
	thunderbird
	transmission-qt
)
PACMAN_DOCKER=(docker docker-compose)
PACMAN_KVM=(libvirt qemu)
PACMAN_GAMES=(dolphin-emu lutris openrct2 steam)
PACMAN_DEV=(fontforge)
PACMAN_GRAPHICS=(blender fontforge imagemagick inkscape)

AUR_BASIC=(
)
AUR_CONSOLE=(
	cbonsai
	pipes-rs
	rbw
)
AUR_GUI=(
	clipster
	logiops
	nerd-fonts-fira-code
	rofi-rbw
	roficlip
	rofimoji-git
)
AUR_DE=(
	bitwarden
	compton-tryone-git
	i3lock-color
	libinput-gestures
	lightdm-mini-greeter
	openrgb
	polybar
	xidlehook
	xpadneo-dkms
)
AUR_GAMES=(discord_arch_electron itch minecraft-launcher)
AUR_DEV=(android-studio arduino-pro-ide)
AUR_GRAPHICS=(glimpse-editor processing-bin)

OMF_PKGS=(
	bass
	bobthefish
	colorman
	foreign-env
	node
	nvm
)


rudimentary_h () {
	url="$1"
	base_path="$HOME/git/"
	repo_path="$(echo $url | sed -Ee 's/^https:\/\/(.*)/\1/')"
	git clone $url "$base_path$repo_path" >/dev/null 2&>1
	echo "$base_path$repo_path"
}

install_progs () {
	if ! command -v pacman; then
		echo "you must be running a distro with pacman as its package manager (Arch, Manjaro, etc.). unfortunately it would just take too much effort for me to maintain this script for every flavor of linux. if this error is a mistake and you DO have pacman, please open an issue here: https://github.com/katacarbix/dotfiles/issues" | fmt -w $FMT_WIDTH
		exit 1
	fi


	echo "installing pacman packages..."
	# always install minimal programs
	TO_INSTALL=(${PACMAN_BASIC[@]})
	# console programs
	if [[ $MACHINE_ENV -ge 1 ]]; then TO_INSTALL=(${TO_INSTALL[@]} ${PACMAN_CONSOLE[@]}); fi
	# basic GUI
	if [[ $MACHINE_ENV -ge 2 ]]; then TO_INSTALL=(${TO_INSTALL[@]} ${PACMAN_GUI[@]}); fi
	# full desktop
	if [[ $MACHINE_ENV -eq 3 ]]; then TO_INSTALL=(${TO_INSTALL[@]} ${PACMAN_DE[@]}); fi
	# docker container engine and compose
	if [[ $INSTALL_DOCKER =~ \^[Yy] ]]; then TO_INSTALL=(${TO_INSTALL[@]} ${PACMAN_DOCKER[@]}); fi
	# running virtual machines
	if [[ $INSTALL_KVM =~ \^[Yy] ]]; then
		TO_INSTALL=(${TO_INSTALL[@]} ${PACMAN_KVM[@]})
		if [[ $MACHINE_ENV -ge 2 ]]; then TO_INSTALL=(${TO_INSTALL[@]} virt-manager); fi
	fi
	sudo pacman -Squ --noconfirm --needed ${TO_INSTALL[@]}


	echo "installing git packages..."
	# install minimal programs
	if [[ -z $(command -v yay) ]]; then
		cd $(rudimentary_h https://aur.archlinux.org/yay)
		makepkg -si --noconfirm --needed
	fi
	rudimentary_h https://github.com/zimbatm/h >/dev/null
	ln -sf $HOME/git/github.com/zimbatm/h/h $HOME/.local/bin
	# console programs
	# if [[ $MACHINE_ENV -ge 1 ]]; then

	# fi
	# basic GUI
	if [[ $MACHINE_ENV -ge 2 ]]; then
		rudimentary_h https://github.com/piroor/tweet.sh >/dev/null
		ln -s $HOME/git/github.com/piroor/tweet.sh/tweet.sh $HOME/.local/bin

		rudimentary_h https://github.com/fdw/rofi-clipster >/dev/null
		pip install $HOME/git/github.com/fdw/rofi-clipster
	fi
	# full desktop
	# if [[ $MACHINE_ENV -eq 3 ]]; then

	# fi


	echo "installing AUR packages..."
	# always install minimal programs
	TO_INSTALL=(${AUR_BASIC[@]})
	# console programs
	if [[ $MACHINE_ENV -ge 1 ]]; then TO_INSTALL=(${TO_INSTALL[@]} ${AUR_CONSOLE[@]}); fi
	# basic GUI
	if [[ $MACHINE_ENV -ge 2 ]]; then TO_INSTALL=(${TO_INSTALL[@]} ${AUR_GUI[@]}); fi
	# full desktop
	if [[ $MACHINE_ENV -eq 3 ]]; then TO_INSTALL=(${TO_INSTALL[@]} ${AUR_DE[@]}); fi
	yay -Su --noconfirm --needed ${TO_INSTALL[@]}


	if [[ $MACHINE_ENV -ge 1 && -z $(command -v fish) ]]; then
		if ! fish -c "type omf" >/dev/null; then
			echo "installing oh-my-fish..."
			curl -L https://get.oh-my.fish | fish
		fi
		echo "installing omf plugins..."
		echo "omf install ${OMF_PKGS[@]}" | fish
	fi


	if [[ $MACHINE_ENV -eq 3 ]]; then
		echo "installing desktop applications..."
		# Sublime Text 3
		curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
		echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf >/dev/null
		sudo pacman -Squ sublime-text
		echo "Sublime Text installed!"
	fi
}

link_dotfiles () {
	echo "cloning dotfiles repo..."
	DOTFILES_PATH=$(rudimentary_h https://github.com/katacarbix/dotfiles)
	git submodule update --init $DOTFILES_PATH

	echo "making symbolic links..."
	HOME_CFG=$HOME/.config
	mkdir -p $HOME_CFG

	# base config, always linked
	ln -sf $DOTFILES_PATH/afetch/afetch $HOME/.local/bin
	ln -sf $DOTFILES_PATH/backup $HOME_CFG
	ln -sf $DOTFILES_PATH/fish $HOME_CFG
	ln -sf $DOTFILES_PATH/kitty $HOME_CFG
	ln -sf $DOTFILES_PATH/micro $HOME_CFG
	ln -sf $DOTFILES_PATH/ranger $HOME_CFG
	ln -sf $DOTFILES_PATH/scripts $HOME
	ln -sf $DOTFILES_PATH/.editorconfig $HOME
	ln -sf $DOTFILES_PATH/misc/.bash_aliases $HOME
	ln -sf $DOTFILES_PATH/misc/.nanorc $HOME
	ln -sf $DOTFILES_PATH/misc/.profile $HOME

	# basic GUI
	if [[ $MACHINE_ENV -ge 2 ]]; then
		ln -sf $DOTFILES_PATH/clipster $HOME_CFG
		ln -sf $DOTFILES_PATH/dunst $HOME_CFG
		ln -sf $DOTFILES_PATH/firefox $HOME/.mozilla/firefox/*.default-release/chrome
		ln -sf $DOTFILES_PATH/i3 $HOME_CFG
		ln -sf $DOTFILES_PATH/rofi $HOME_CFG
		ln -sf $DOTFILES_PATH/misc/.xinitrc $HOME
		sudo ln -sf $DOTFILES_PATH/misc/logid.cfg /etc
		ln -sf $DOTFILES_PATH/misc/rofimoji.rc $HOME_CFG
	fi

	# full desktop
	if [[ $MACHINE_ENV -eq 3 ]]; then
		ln -sf $DOTFILES_PATH/eww $HOME_CFG
		ln -sf $DOTFILES_PATH/polybar $HOME_CFG
		ln -sf $DOTFILES_PATH/sublime-text $HOME_CFG/sublime-text-3/Packages/User
		ln -sf $DOTFILES_PATH/wal $HOME_CFG
		ln -sf $DOTFILES_PATH/misc/compton.conf $HOME_CFG
		ln -sf $DOTFILES_PATH/misc/libinput-gestures.conf $HOME_CFG
		sudo mkdir -p /etc/lightdm
		sudo ln -sf $DOTFILES_PATH/misc/lightdm-mini-greeter.conf /etc/lightdm
	fi

	echo "symlinks created!"
}

system_tweaks () {
	if [[ $INSTALL_DOCKER =~ \^[Yy] ]]; then
		echo "configuring Docker..."
		groupadd docker
		usermod -aG docker $user
		systemctl enable --now docker.service
	fi

	# Set my locale (en_US.UTF-8)
	sed -Ee 's/^# (en_US.UTF-8 UTF-8)$/\1/g' -i /etc/locale.gen
	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	locale-gen

	read -e -p "change hostname? (leave blank for no change) > " -a NEW_HOSTNAME
	if [[ $NEW_HOSTNAME ]]; then
		hostnamectl set-hostname $NEW_HOSTNAME
	fi
}

main () {
	# make sure git is installed and system is up to date
	sudo pacman -Sqyu --noconfirm --needed git

	if [[ $LINK_DOTS =~ \^[^Nn] ]]; then
		# clone the dotfiles repo and link what's needed
		link_dotfiles
	fi

	# install programs
	install_progs

	# tweak system settings as root
	export -f system_tweaks
	su root -c "bash -c system_tweaks"

	# change user's shell to fish
	sudo chsh -s $(which fish) $user

	echo "all done!"
	read -e -p "would you like to reboot now? [y/N] > " -a DO_REBOOT
	if [[ $DO_REBOOT =~ \^[Yy] ]]; then sudo shutdown -r now; fi
}

main
