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

function aws-env() {
  export AWS_DEFAULT_REGION="$(aws configure get region)"
  export AWS_REGION="${AWS_DEFAULT_PROFILE}"

  # optimistically fetch values using `aws configure` cli
  id=$(aws configure get aws_access_key_id)
  secret=$(aws configure get aws_secret_access_key)
  token=""

  # if those values are empty, then try to fetch from cli cache
  if [ -z $id ]; then
    # make a call so that CLI will possibly prompt for MFA and do sts:AssumeRole
    aws sts get-caller-identity >/dev/null

    json=$(
      find $HOME/.aws/cli/cache/ -name ${AWS_DEFAULT_PROFILE}* | tail -n 1 \
        | xargs cat
    )
    id=$(echo $json | jq -r '.Credentials.AccessKeyId')
    secret=$(echo $json | jq -r '.Credentials.SecretAccessKey')
    token=$(echo $json | jq -r '.Credentials.SessionToken')
  fi

  [ $id ] && export AWS_ACCESS_KEY_ID="$id"
  [ $secret ] && export AWS_SECRET_ACCESS_KEY="$secret"
  [ $token ] && export AWS_SESSION_TOKEN="$token" || unset AWS_SESSION_TOKEN
}

function aws-unset() {
  unset $(env | grep AWS | grep -v PROFILE | cut -f 1 -d '=' | xargs)
}
