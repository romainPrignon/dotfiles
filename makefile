install: ## install all packages, runtimes,...
	sudo bash ./install.sh 2>&1 | tee ~/install.log	

bootstrap: ## bootstrap dotfiles
	./bootstrap.sh

dconf-dump: ## save dconf settings
	dconf dump /org/gnome/nautilus/ > dconf/nautilus.dconf
	dconf dump /org/gnome/power-manager/ > dconf/power-manager.dconf
	dconf dump /org/gnome/settings-daemon/ > dconf/settings-daemon.dconf
	dconf dump /org/gnome/shell/ > dconf/shell.dconf
	dconf dump /org/gnome/terminal/ > dconf/terminal.dconf
	dconf dump /org/gnome/desktop/ > dconf/desktop.dconf

dconf-load: ## restore dconf
	dconf load /org/gnome/nautilus/ < dconf/nautilus.dconf
	dconf load /org/gnome/power-manager/ < dconf/power-manager.dconf
	dconf load /org/gnome/settings-daemon/ < dconf/settings-daemon.dconf
	dconf load /org/gnome/shell/ < dconf/shell.dconf
	dconf load /org/gnome/terminal/ < dconf/terminal.dconf
	dconf load /org/gnome/desktop/ < dconf/desktop.dconf

composer: ## install composer global deps
	composer global update

npm: ## install npm global deps
	npm install -g \
		babel-cli \
		eslint \
		http-server \
		npm-check \
		now \
		nsp \
		pkgcount \
		stylelint \
		thanks \
		ttystudio \
		types-checker