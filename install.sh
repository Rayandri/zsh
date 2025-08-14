#!/bin/bash
set -e

sudo apt update && sudo apt upgrade -y
sudo apt install zsh

export RUNZSH=no CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
mkdir -p "$plugins_dir"

git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugins_dir/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-completions.git "$plugins_dir/zsh-completions"
git clone https://github.com/zsh-users/zsh-history-substring-search.git "$plugins_dir/zsh-history-substring-search"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$plugins_dir/fast-syntax-highlighting"

theme_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"

sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)/' ~/.zshrc

cp ./config_p10k ~/.p10k.zsh
grep -qxF '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' ~/.zshrc || echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

chsh -s "$(which zsh)"
echo "✅ Setup complete. Restart your terminal."

