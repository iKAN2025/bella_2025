#!/bin/bash

# Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found, installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Update and upgrade Homebrew
echo "Updating and upgrading Homebrew..."
brew update
brew upgrade

# Install essential tools
echo "Installing essential tools..."
brew install xz rbenv python jupyter

# Install Ruby and set it as global version
echo "Installing Ruby and setting it up..."
rbenv install 3.1.4
rbenv global 3.1.4

# Configure rbenv to initialize in the shell
echo 'if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi' >> ~/.zshrc

# Setup GEM_HOME and PATH for Ruby Gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc

# Install Jekyll and Bundler gems
echo "Installing Jekyll and Bundler..."
gem install jekyll bundler

# Create symbolic links for Jupyter on Apple Silicon or Intel
echo "Setting up symbolic links for Jupyter..."
if [ "$(uname -m)" = "arm64" ]; then
    ln -s /opt/homebrew/share/jupyter/nbconvert ~/Library/Jupyter
    ln -s /opt/homebrew/bin/python3 /opt/homebrew/bin/python
    ln -s /opt/homebrew/bin/pip3 /opt/homebrew/bin/pip
else
    sudo ln -s /usr/local/bin/python3 /usr/local/bin/python
    sudo ln -s /usr/local/bin/pip3 /usr/local/bin/pip
fi

# Install Python libraries for Jupyter Notebook conversion
echo "Installing Python libraries for Jupyter Notebook. This is going to take a while."
pip install nbconvert nbformat pyyaml

# Version Checks
echo "Performing version checks..."
ruby -v
python --version
jupyter --version
echo "This was broken last time..hehe.."
mdless --version
echo "Jupyer Kernels" 
jupyter kernelspec list

# Setup GitHub and project directory
echo "Setting up GitHub project directory..."
cd ~/nighthawk/bella_2025

echo "Creating virtual environment to ensure compatibility wuth Python 3.12.6"
# Create virtual environment
python3 -m venv venv
source venv/bin/activate


echo "Ready to open VS Code? Bye bye :)"
code . 


