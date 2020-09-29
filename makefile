.PHONY: vscode

install: ## install all packages, runtimes,...
	sudo -u romainprignon bash ./scripts/install.sh 2>&1 | tee ~/install.log

configure: ## configure dotfiles
	sudo -u romainprignon bash ./scripts/configure.sh

desktop: ## install gnome desktop
	sudo -u romainprignon bash ./scripts/desktop.sh

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
		depcheck \
		gitmoji-cli \
		hotel \
		http-server \
		now \
		pkgcount \
		thanks \
		ts-node \
		types-checker \
		typescript

vscode: ## install vscode ext
	bash ./scripts/install-vscode-ext.sh
