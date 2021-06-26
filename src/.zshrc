# ░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀
# ░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█
# ░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀
#
# FILE: ~/.zshrc

# Some basics {{{

HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=1000000
setopt autocd extendedglob nomatch 
unsetopt beep
fpath+=$HOME/.zfunc


zstyle :compinstall filename '/home/axolotl/.zshrc'
autoload -Uz compinit && compinit
autoload -U promptinit && promptinit
# }}}

# $PATH {{{
# Check if $HOME/.local/bin is already part of the PATH variable
if [ ! $(echo $PATH | grep "$HOME/.local/bin") ] && [ -d ~/.local/bin ] ; then
  export PATH=$PATH:~/.local/bin
fi
if [ ! $(echo $PATH | grep "$HOME/.emacs.d/bin") ] && [ -d ~/.emacs.d/bin ] ; then
  export PATH=$PATH:~/.emacs.d/bin
fi
if [ ! $(echo $PATH | grep "$HOME/.cargo/bin") ] && [ -d ~/.cargo/bin ] ; then
  export PATH=$PATH:~/.cargo/bin
fi
# }}}

# Initializations {{{
# Init starship
eval "$(starship init zsh)"

# Init sheldon
eval "$(sheldon source)"
# export ZSH

# }}}

# Plugins Config {{{
# zsh-you-should-use
export YSU_MESSAGE_POSITION="before"
export YSU_MODE=ALL
export YSU_MESSAGE_FORMAT=$(tput bold)"$(tput setaf 1)You stoopid forgot that there is an $(tput setaf 3)%alias_type$(tput setaf 9) for $(tput setaf 3)%command$(tput setaf 9). It is $(tput setaf 3)%alias$(tput setaf 9)$(tput sgr0)"

# zsh auto ls functions
auto-ls-custom_function() {
  if [ ! -d .git ]; then
    exa --icons --group-directories-first --long
  else
    onefetch
    git status
    exa --icons --group-directories-first --long --all --git
  fi
}

AUTO_LS_COMMANDS=(custom_function)
# }}}

# Functions {{{

noice() {
  if command -v toilet > /dev/null; then
    for arg in $@; do
      toilet -f pagga "$arg"
    done
  else
    echo Toilet not installed!
  fi
}

dots() {
  if command -v toilet > /dev/null; then
    toilet -f pagga "Dotfiles"
    echo
    echo "File:"
    echo "By: @ExtinctAxolotl"
  fi
}

mackse() {
  mackup list | grep "$@"

}

gogh () {
  bash -c  "$(wget -qO- https://git.io/vQgMr)" 
}

docx2md() {
  if command -v pandoc &> /dev/null; then
    pandoc --from=docx --to=gfm $1 --output=$2
  else
    echo -e "Pandoc is not installed!\nPlease install it with your package manager! :D"
  fi
}
# }}}

# Variables {{{
# Editors
export EDITOR=nvim
export SUDO_EDITOR=nvim

# the manpager
export PAGER="nvim -c MANPAGER -"
export MANPAGER=$PAGER
# }}}

# Aliases {{{
# Config
alias zshconf="$EDITOR ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias alaconf="$EDITOR ~/.config/alacritty/alacritty.yml"
# alias oboxconf="$EDITOR ~/.config/openbox/rc.xml"
alias starconf="$EDITOR ~/.config/starship.toml"
alias vconf="$EDITOR ~/.config/nvim/init.vim"
! [ -f $HOME/.config/nvim/init.vim ] && [ -f $HOME/.config/nvim/init.lua ] && alias vconf="$EDITOR $HOME/.config/nvim/init.lua"
alias mackconf="$EDITOR ~/.mackup.cfg"
alias kittyconf="$EDITOR ~/.config/kitty/kitty.conf"
alias herbstconf="$EDITOR ~/.config/herbstluftwm/autostart"

# ls
alias ls="exa --icons --group-directories-first --long --git"
alias lT="exa --icons --group-directories-first --tree --git"
alias ll="exa --icons --group-directories-first --long --all --git"
alias la="exa --icons --group-directories-first --long --all --git"

# nvim
alias v="nvim"
alias vv="vim"

# mkdir cp etc
alias md="mkdir -p"
alias cp="cp -r"

# alias rm="echo 'Use something else!'"

# theF*ck
alias f="fuck"
# needed for thef*ck
eval $(thefuck --alias)

# python
alias py3="python3"

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# paru
alias pain="paru -S"
alias pase="paru -Ss"
alias painfo="paru -Si"
alias pare="paru -R"
alias parem="paru -Rns"
# }}}

# Startup {{{
# SSH Agent
# eval $(keychain --eval id_ed25519 -q)

# Random fetcher
[ -f $HOME/.dotfiles/bin/random_fetcher.sh ] && bash $HOME/.dotfiles/bin/random_fetcher.sh
# }}}

# Completion {{{
#compdef _gh gh
# zsh completion for gh                                   -*- shell-script -*- {{{

__gh_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_gh()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local lastParam lastChar flagPrefix requestComp out directive compCount comp lastComp
    local -a completions

    __gh_debug "\n========= starting completion logic =========="
    __gh_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __gh_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __gh_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., gh -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __gh_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __gh_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __gh_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __gh_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __gh_debug "No directive found.  Setting do default"
        directive=0
    fi

    __gh_debug "directive: ${directive}"
    __gh_debug "completions: ${out}"
    __gh_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __gh_debug "Completion received error. Ignoring completions."
        return
    fi

    compCount=0
    while IFS='\n' read -r comp; do
        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab=$(printf '\t')
            comp=${comp//$tab/:}

            ((compCount++))
            __gh_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __gh_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subDir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __gh_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __gh_debug "Listing directories in ."
        fi

        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
    elif [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ] && [ ${compCount} -eq 1 ]; then
        __gh_debug "Activating nospace."
        # We can use compadd here as there is no description when
        # there is only one completion.
        compadd -S '' "${lastComp}"
    elif [ ${compCount} -eq 0 ]; then
        if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
            __gh_debug "deactivating file completion"
        else
            # Perform file completion
            __gh_debug "activating file completion"
            _arguments '*:filename:_files'" ${flagPrefix}"
        fi
    else
        _describe "completions" completions $(echo $flagPrefix)
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_gh" ]; then
	_gh
fi
# }}}
#}}}
# Vim keybindings
bindkey -v

# vim:foldmethod=marker

