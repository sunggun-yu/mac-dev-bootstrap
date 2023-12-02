# ANSIBLE MANAGED FILE - envp

function envp_prompt_info() {
  if [[ -n $ENVP_PROFILE ]]; then
    echo "%{$fg[green]%}  $ENVP_PROFILE%{$reset_color%} "
  fi
}
