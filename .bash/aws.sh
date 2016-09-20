complete -C aws_completer aws

function aws-profile() {
  profiles=$(cat ~/.aws/credentials | grep '\[' | tr -d '[]')
  if [[ -z "$1" || "$profiles" != *"$1"* ]]; then
    echo -n "Available profiles:"
    echo $profiles | perl -pe "s/( |^)/\n  /g"
    unset AWS_DEFAULT_PROFILE AWS_EB_PROFILE
  else
    export AWS_DEFAULT_PROFILE="$1"
    export AWS_EB_PROFILE="$1"
  fi
}

