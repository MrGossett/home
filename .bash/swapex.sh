export SWAPEX_PARALLELISM=100

alias dockerpex="docker run --rm -it -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_REGION=\"\$AWS_DEFAULT_REGION\" -e SWAPEX_ENVIRONMENT --workdir /app -v \$(pwd):/app --entrypoint /bin/bash swapex"

function s3vim() {
  s3url=$1
  local=`mktemp`
  aws s3 cp "$1" "$local"
  if [[ $? -ne 0 ]]; then echo "not found"; return 1; fi
  vim "$local"
  aws s3 cp "$local" "$1"
}
