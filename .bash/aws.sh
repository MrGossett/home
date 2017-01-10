complete -C aws_completer aws

function aws-profile() {
  profiles=$(cat ~/.aws/config | grep '\[' | tr -d '[]' | cut -f 2 -d ' ')
  if [[ -z "$1" || "$profiles" != *"$1"* ]]; then
    echo -n "Available profiles:"
    echo $profiles | perl -pe "s/( |^)/\n  /g"
    unset AWS_DEFAULT_PROFILE AWS_PROFILE AWS_EB_PROFILE
  else
    export AWS_DEFAULT_PROFILE="$1"
    export AWS_PROFILE="$1"
    export AWS_EB_PROFILE="$1"
  fi
}

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

function aws-private-dns() {
  [ -z $1 ] && echo "usage: $0 <name-filter>" && return 1
  aws ec2 describe-instances \
    --filters Name=tag:Name,Values=$1 \
    --query "Reservations[].Instances[0].PrivateDnsName" \
    --output text
}
function aws-get-hosts() {
  [ -z $1 ] && echo "usage: $0 <name-filter> <prefix>" && return 1
  [ -z $2 ] && echo "usage: $0 <name-filter> <prefix>" && return 1

  # make sure known_hosts exists
  touch ~/.ssh/known_hosts

  # get a list of instance IDs
  instances=$(
    aws ec2 describe-instances \
      --filters Name=tag:Name,Values=$1 \
      --query 'Reservations[].Instances[].{ID: InstanceId}' \
      --output text
  )

  # make a copy of the current known_hosts
  cp ~/.ssh/{known,old}_hosts

  # for each instance, find the lines in console output showing the host's
  # ssh key. prepend each line with 'jump.hybris*' and add the lines to
  # known_hosts
  for i in $instances; do
    aws ec2 get-console-output --instance-id "$i" --query 'Output' --output text |\
      sed "/BEGIN SSH HOST KEY KEYS/,/END SSH HOST KEY KEYS/!d; /^---/d; s/^/$2* /" \
      >> ~/.ssh/known_hosts
  done

  # sort known_hosts in-place
  sort -u -o ~/.ssh/known_hosts ~/.ssh/known_hosts

  # show what changed
  diff -B ~/.ssh/{old,known}_hosts
}
