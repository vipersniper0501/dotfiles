#if [ "$TMUX" = "" ]; then tmux; fi


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

#if [ ! -d ~/.oh-my-zsh ]; then
#    echo "oh-my-zsh is not installed. Installing now"
#    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#fi

# if [ ! -d ~/.powerlevel10k/ ]; then
    # echo "powerlevel10k is not installed. Installing now"
    # #git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
# fi

# source ~/.powerlevel10k/powerlevel10k.zsh-theme

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="/home/viper/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias python="python3.9"
alias dotfile_config="git --git-dir=$HOME/.dot_cfg/.git --work-tree=$HOME/.dot_cfg"
alias ll="ls -la --color=auto"
alias ls="ls --color=auto"


HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory


if [ -d /home/$USER/.my_bin ]; then
    alias nvim="~/.my_bin/nvim.appimage"
    if [ -d /home/$USER/.my_bin/go ]; then 
        export PATH=$PATH:/home/$USER/.my_bin/go/bin
    fi
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export VISUAL=nvim
export EDITOR="$VISUAL"

export GPG_TTY=$TTY


export PATH=$PATH:/home/$USER/.local/bin

# Change the path to your mingw bin files if different
# The check is reduntant however makes it so there is no error if adding this .zshrc
# to your system.
if [ -d /mnt/c/dev/MinGW/ ]; then
    export PATH=$PATH:/mnt/c/dev/MinGW/bin
fi

if [ -d /home/$USER/.cargo/bin/ ]; then
    export PATH=$PATH:/home/$USER/.cargo/bin
fi

# Note that ".ghidra_bin" is a custom name I gave to the ghidra folder 
# containing the ghidraRun file.
if [ -d /home/$USER/.ghidra_bin ]; then
    export PATH=$PATH:/home/$USER/.ghidra_bin
fi

if [ -d /usr/local/cuda-12.3/bin ]; then
    export PATH=$PATH:/usr/local/cuda-12.3/bin
fi

if [ -d /mnt/c/Program\ Files/Microsoft\ Visual\ Studio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin ]; then
    export PATH=$PATH:/mnt/c/Program\ Files/Microsoft\ Visual\ Studio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin 
fi

if [ -d /usr/local/go ]; then
    export PATH=$PATH:/usr/local/go/bin
fi


# If you are using GWSL and not using Windows 11 and not using WSL Version 2 for your 
# linux distrobution, then uncomment the following two lines to enable the use of
# GWSL for running linux gui applications.

# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
# export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL

export NVM_DIR="/home/viper/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# export GIT_SSH_COMMAND="ssh -i ~/.ssh/mab7470"

export CHROME_BIN=/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe

# Load Angular CLI autocompletion.
#source <(ng completion script)


eval "$(starship init zsh)"
