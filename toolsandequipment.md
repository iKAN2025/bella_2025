---
layout: post
title: Tools and Equipment Tangibles
description: Creating a shell script that installed required dependencies for tools and equipment, performed version checks, ran server locally, and opened repository in vscode whilst creating an virtual environment (required for Python 3.12.5, recommended by teacher) with an alias. 
courses: {csa: {week: 0}}
comments: true
type: issues
permalink: /tooltangible
---


In light of a recent live review, I decided to be more creative with my tools and equipment issue to properly demonstrate if I knew the required code or not.

My first idea was to make a shell script, in `setup_script.sh`.  Here is the shell script.

```bash


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
# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Open VS Code in the project directory
echo "Opening VS Code in the project directory..."
code .

# Install bundle and run the local server
echo "Installing bundle and running the local server..."
bundle install
bundle exec jekyll serve --incremental

code . 



```

I personalized the setup script.sh echo statements to make it feel more personal, although, anyone can use this if they want. They just need to configure their alias accordingly. Running `/.setup_script.sh/ ` is  a lot of work, so I decided to use an old alias that I had and specified the path of the script in my `/.zsrch` file. In this case, setup_script.sh is in the `bella_2025` repo under the `nighthawk` directory.

The old alias was Teacher's idea to create a virtual environment. This is because we're using a more updated python version, Python 3.12.5.

You can run the script yourself on this machine, or, if you want, take a look at the issue I created [Here](https://github.com/iKAN2025/bella_2025/issues/2) for tangible screenshots. Good luck testing out your own script! 


Here's what's in the issue, just in case:

# Alias
<img width="419" alt="Screenshot 2024-09-01 at 2 00 28 PM" src="https://github.com/user-attachments/assets/98d6ef9a-4a67-4f11-9baa-32d159e7745b">

# Creating Script/Personalizing it
<img width="599" alt="Screenshot 2024-09-01 at 2 01 18 PM" src="https://github.com/user-attachments/assets/d5fdeffb-0b68-4254-93fc-df0ae33aec62">

# Version Checks, opening Vs Code
<img width="583" alt="Screenshot 2024-09-01 at 2 02 31 PM" src="https://github.com/user-attachments/assets/b22dd5dc-b48d-4a8c-94ec-0031b1eb84ef">

<img width="547" alt="Screenshot 2024-09-01 at 2 03 00 PM" src="https://github.com/user-attachments/assets/efd71a76-f26f-48e3-a99f-12d875426b62">