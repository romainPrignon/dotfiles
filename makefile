.PHONY: vscode

# Default Debian version for Docker build
version ?= trixie

install: ## install all packages, runtimes,...
	sudo -u romainprignon bash ./scripts/install.sh 2>&1 | tee ./logs/install.log

configure: ## configure dotfiles
	sudo -u romainprignon bash ./scripts/configure.sh 2>&1 | tee ./logs/configure.log

desktop: ## install gnome desktop
	sudo -u romainprignon bash ./scripts/desktop.sh 2>&1 | tee ./logs/desktop.log

configure-desktop: ## configure desktop
	sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf

login-background: ## set login background image
	sudo apt update
	sudo apt install -y libglib2.0-dev-bin
	# Method 1: Try using GDM Settings via flatpak (user must install manually if preferred)
	# flatpak install flathub io.github.realmazharhussain.GdmSettings
	# Method 2: CSS-based approach
	sudo cp /usr/share/gnome-shell/theme/gdm3.css /usr/share/gnome-shell/theme/gdm3.css.backup || true
	@echo "To set login background, edit /usr/share/gnome-shell/theme/gdm3.css"
	@echo "Add under #lockDialogGroup: background-image: url('/path/to/image.jpg');"
	@echo "Then run: sudo systemctl restart gdm3"

update-desktop:
	sudo apt --only-upgrade install \
		brave-browser \
		code \
		code-insider \
		dbgate \
		ghostty \
		micro \
		rambox \
		virtualbox-6.1 \
		vlc

completions:
	# bash completions
	gh completion -s bash > gh
	sudo mv gh /etc/bash_completion.d/gh
	npm completion > npm
	sudo mv npm /etc/bash_completion.d/npm
	deno completions bash > deno
	sudo mv deno /etc/bash_completion.d/deno
	kubectl completion bash > kubectl
	sudo mv kubectl /etc/bash_completion.d/kubectl
	poetry completions bash > poetry
	sudo mv poetry /etc/bash_completion.d/poetry
	# zsh completions
	gh completion -s zsh > _gh
	sudo mv _gh /usr/local/share/zsh/site-functions/_gh
	deno completions zsh > _deno
	sudo mv _deno /usr/local/share/zsh/site-functions/_deno
	kubectl completion zsh > _kubectl
	sudo mv _kubectl /usr/local/share/zsh/site-functions/_kubectl
	poetry completions zsh > _poetry
	sudo mv _poetry /usr/local/share/zsh/site-functions/_poetry



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
		git-open \
		git-split-diffs \
		gitmoji-cli \
		hotel \
		http-server \
		pkgcount \
		pnpm \
		thanks \
		ts-node \
		ts-node-dev \
		types-checker \
		typescript \
		zx

pip: ## install python global deps
	pip install \
		ansible \
		git-machete \
		shell-gpt \
		zxpy

krew:
	kubectl krew install ctx
	kubectl krew install ns

### Runtime installations (via mise) ###
# Default versions can be configured via environment variables or .mise.toml
# Example: NODE_VERSION=20.0.0 make install-node

NODE_VERSION ?= lts
NODE_VERSION_LATEST ?= latest
PYTHON_VERSION ?= 3.12
PYTHON_VERSION_2 ?= 3.8
GO_VERSION ?= latest
RUST_VERSION ?= latest
DENO_VERSION ?= latest
JAVA_VERSION ?= openjdk-17
POETRY_VERSION ?= latest
PACKER_VERSION ?= latest
TERRAFORM_VERSION ?= latest
GH_VERSION ?= latest
KUBECTL_VERSION ?= latest
BROOT_VERSION ?= latest
PHP_VERSION ?= 8.1
DOCKER_VERSION ?= latest

install-node: ## install Node.js runtime via mise (NODE_VERSION=lts by default)
	mise use -g node@$(NODE_VERSION)
	mise use -g node@$(NODE_VERSION_LATEST)

install-deno: ## install Deno runtime via mise (DENO_VERSION=latest by default)
	mise use -g deno@$(DENO_VERSION)

install-go: ## install Go runtime via mise (GO_VERSION=latest by default)
	mise use -g go@$(GO_VERSION)

install-python: ## install Python runtime via mise (PYTHON_VERSION=3.12 by default)
	mise use -g python@$(PYTHON_VERSION)
	mise use -g python@$(PYTHON_VERSION_2)

install-poetry: ## install Poetry via mise (POETRY_VERSION=latest by default)
	mise use -g poetry@$(POETRY_VERSION)
	poetry config virtualenvs.in-project true

install-rust: ## install Rust via mise (RUST_VERSION=latest by default)
	mise use -g rust@$(RUST_VERSION)

install-java: ## install Java via mise (JAVA_VERSION=openjdk-17 by default)
	mise use -g java@$(JAVA_VERSION)

install-packer: ## install Packer via mise (PACKER_VERSION=latest by default)
	mise use -g packer@$(PACKER_VERSION)

install-terraform: ## install Terraform via mise (TERRAFORM_VERSION=latest by default)
	mise use -g terraform@$(TERRAFORM_VERSION)

install-gh: ## install GitHub CLI via mise (GH_VERSION=latest by default)
	mise use -g github-cli@$(GH_VERSION)

install-kubectl: ## install kubectl via mise (KUBECTL_VERSION=latest by default)
	mise use -g kubectl@$(KUBECTL_VERSION)

install-broot: ## install broot via mise (BROOT_VERSION=latest by default)
	mise use -g broot@$(BROOT_VERSION)

install-php: ## install PHP via mise (PHP_VERSION=8.1 by default)
	mise use -g php@$(PHP_VERSION)
	# Install composer via mise too
	mise use -g composer@latest

install-docker: ## install Docker via mise (DOCKER_VERSION=latest by default)
	mise use -g docker@$(DOCKER_VERSION)

install-all-runtimes: install-node install-deno install-go install-python install-poetry install-rust install-java install-packer install-terraform install-gh install-kubectl install-broot install-php install-docker ## install all runtimes

# dedicated target so it can work with starter-machines
snap:
	snap install multipass

vscode: ## install vscode ext
	bash ./scripts/install-vscode-ext.sh

swap: ## create swap file if not already done ex: make swap size=8G
	sudo fallocate -l ${size} /swapfile
	sudo chmod 600 /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

### next is for contribuing

test-qa: ## run integration tests (designed to run inside Docker container)
	bash ./scripts/test-qa.sh

build: ## build Docker image - make build version=trixie (default: trixie)
	docker build -t romainprignon/dotfiles:${version} --build-arg version=${version} .

qa: ## run QA in Docker - make qa version=trixie (default: trixie)
	docker run --rm -it romainprignon/dotfiles:${version}
