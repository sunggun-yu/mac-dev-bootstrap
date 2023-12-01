# ANSIBLE MANAGED FILE - envp

function envp_prompt_info() {
  if [[ -n $ENVP_PROFILE ]]; then
    echo "🍱 $ENVP_PROFILE "
  fi
}
