# primary prompt: dashed separator, directory and vcs info
PS1="\$(virtualenv_prompt_info)%{$reset_color%}${FG[006]}%~\$(git_prompt_info)\$(hg_prompt_info) ${FG[013]}%(!.#.»)%{$reset_color%} "
PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: return code, virtualenv and context (user@host)
RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi
RPS1+=" ${FG[007]}%n@%m%{$reset_color%}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[004]}(${FG[002]}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[003]}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${FG[004]})%{$reset_color%}"

# hg settings
ZSH_THEME_HG_PROMPT_PREFIX=" ${FG[004]}(${FG[002]}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="${FG[003]}*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="${FG[004]})%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" ${FG[004]}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"