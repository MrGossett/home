complete -C aws_completer aws

function aws-env() {
  export AWS_DEFAULT_REGION="$(aws configure get region)"
  export AWS_REGION="${AWS_DEFAULT_REGION}"

  # optimistically fetch values using `aws configure` cli
  id=$(aws configure get aws_access_key_id)
  secret=$(aws configure get aws_secret_access_key)
  token=""

  # if those values are empty, then try to fetch from cli cache
  if [ -z $id ]; then
    # make a call so that CLI will possibly prompt for MFA and do sts:AssumeRole
    arn=$(aws sts get-caller-identity --query 'Arn' --output text)
    json=$(
      find $HOME/.aws/cli/cache/ -name '*.json' -exec grep "$arn" {} \;
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
  unset $(env | grep AWS | egrep -v '(PROFILE|REGION)' | cut -f 1 -d '=' | xargs)
}

function aws-profile() {
  aws-unset
  export AWS_PROFILE=$1 AWS_DEFAULT_PROFILE=$1
}

export AWS_SDK_LOAD_CONFIG=true
