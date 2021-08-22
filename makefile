.PHONY: vscode

install: ## install all packages, runtimes,...
	sudo -u romainprignon bash ./scripts/install.sh 2>&1 | tee ./logs/install.log

configure: ## configure dotfiles
	sudo -u romainprignon bash ./scripts/configure.sh 2>&1 | tee ./logs/configure.log

desktop: ## install gnome desktop
	sudo -u romainprignon bash ./scripts/desktop.sh 2>&1 | tee ./logs/desktop.log

configure-desktop: ## configure gnome desktop
	gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
	sudo ./scripts/change-gdm-background.sh ./img/screensaver.jpg
	sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf

configure-partner: ## link partner config file ex: make configure-partner partner=frello
	ln -sf ~/Gdrive/root/home/romainprignon/workspace/partners/.gitconfig ~/workspace/partners/.gitconfig
	ln -sf ~/Gdrive/root/home/romainprignon/.rc/${partner}.rc ~/.rc/${partner}.rc
	ln -sf ~/Gdrive/root/home/romainprignon/.ssh/${partner} ~/.ssh/${partner}

ngrok:
	ln -sf ~/Gdrive/root/home/romainprignon/.ngrok2 ~/.ngrok2

dconf-dump: ## save dconf settings
	dconf dump /org/gnome/nautilus/ > dconf/nautilus.dconf
	dconf dump /org/gnome/settings-daemon/ > dconf/settings-daemon.dconf
	dconf dump /org/gnome/shell/ > dconf/shell.dconf
	dconf dump /org/gnome/terminal/ > dconf/terminal.dconf
	dconf dump /org/gnome/desktop/ > dconf/desktop.dconf

dconf-load: ## restore dconf
	dconf load /org/gnome/nautilus/ < dconf/nautilus.dconf
	dconf load /org/gnome/settings-daemon/ < dconf/settings-daemon.dconf
	dconf load /org/gnome/shell/ < dconf/shell.dconf
	dconf load /org/gnome/terminal/ < dconf/terminal.dconf
	dconf load /org/gnome/desktop/ < dconf/desktop.dconf

composer: ## install composer global deps
	composer global update

npm: ## install npm global deps
	npm install -g \
		@babel/node \
		cdktf-cli \
		depcheck \
		git-split-diffs \
		gitmoji-cli \
		hotel \
		http-server \
		pkgcount \
		thanks \
		ts-node \
		types-checker \
		typescript

vscode: ## install vscode ext
	bash ./scripts/install-vscode-ext.sh

swap: ## create swap file if not already done ex: make swap size=8G
	sudo fallocate -l ${size} /swapfile
	sudo chmod 600 /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
