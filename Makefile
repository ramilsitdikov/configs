FILES = ./files

install_configs:
	@echo "install homebrew ..."
	zsh -c "/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	zsh -c "brew bundle --file $(FILES)/Brewfile"
	zsh -c "brew update"
	zsh -c "brew upgrade"

	@echo "copy configs ..."
	zsh -c "cp $(FILES)/zshrc ~/.zshrc"
	zsh -c "cp $(FILES)/themes/ys_custom.zsh-theme ~/.oh-my-zsh/ys_custom.zsh-theme"
	zsh -c "cp $(FILES)/gitconfig ~/.gitconfig"
	zsh -c "cp $(FILES)/gitignore ~/.gitignore"
	zsh -c "cp -Rf $(FILES)/sublime/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/"
	zsh -c "cp $(FILES)/railsrc ~/.railsrc"
	zsh -c "cp $(FILES)/rubocop.yml ~/.rubocop.yml"
	zsh -c "cp -Rf $(FILES)/ssh/* ~/.ssh"
	zsh -c "cp -Rf $(FILES)/docker/* /Users/Shared/.docker"

	@echo "copy dumps ..."
	zsh -c "cp -Rf $(FILES)/dumps/* ~/Downloads/dumps"

	@echo "copy docs ..."
	zsh -c "cp -Rf $(FILES)/Documents/* ~/Documents"

backup_configs: backup_zsh backup_ssh backup_documents backup_dumps backup_docker backup_brew backup_workspace

backup_zsh:
	@echo "\nbackup_zsh ..."
	cat ~/.zshrc > $(FILES)/zshrc
	cat ~/.oh-my-zsh/themes/ys_custom.zsh-theme > $(FILES)/ys_custom
	@echo "\nbackup_git ..."
	cat ~/.gitconfig > $(FILES)/gitconfig
	cat ~/.gitignore > $(FILES)/gitignore
	@echo "\nbackup_sublime ..."
	zsh -c "rm -rf $(FILES)/sublime"
	zsh -c "mkdir $(FILES)/sublime"
	zsh -c "cp -Rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/* $(FILES)/sublime"
	@echo "\nbackup_rails ..."
	cat ~/.railsrc > $(FILES)/railsrc
	cat ~/.rubocop.yml > $(FILES)/rubocop.yml

backup_ssh:
	@echo "\nbackup_ssh ..."
	zsh -c "cp -Rf ~/.ssh/* $(FILES)/ssh"

backup_documents:
	@echo "\nbackup_documents ..."
	zsh -c "rm -rf $(FILES)/Documents"
	zsh -c "mkdir $(FILES)/Documents"
	zsh -c "cp -Rf ~/Documents/* $(FILES)/Documents"

backup_dumps:
	@echo "\nbackup_dumps ..."
	zsh -c "rm -rf $(FILES)/dumps"
	zsh -c "mkdir $(FILES)/dumps"
	zsh -c "cp -Rf ~/Downloads/dumps/* $(FILES)/dumps"

backup_docker:
	@echo "\nbackup_docker ..."
	zsh -c "rm -rf $(FILES)/docker"
	zsh -c "mkdir $(FILES)/docker"
	zsh -c "cp -Rf /Users/Shared/.docker/* $(FILES)/docker"

backup_brew:
	@echo "\nbackup_brew ..."
	zsh -c "rm Brewfile"
	zsh -c "brew bundle dump"
	zsh -c "mv Brewfile $(FILES)"

backup_workspace:
	@echo "\nbackup_workspace ..."
	zsh -c " time tar -czvf workspace.tar.gz --exclude='*node_modules/' --exclude='*.log' --exclude='*tmp/' ~/workspace"
