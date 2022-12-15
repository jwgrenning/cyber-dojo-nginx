
# - - - - - - - - - - - - - - - - - - - - - - - -
echo_versioner_env_vars()
{
  docker run --rm cyberdojo/versioner
  echo CYBER_DOJO_NGINX_SHA="$(git_commit_sha)"
  echo CYBER_DOJO_NGINX_TAG="$(git_commit_tag)"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
git_commit_sha()
{
  echo "$(cd "$(root_dir)" && git rev-parse HEAD)"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
git_commit_tag()
{
  local -r sha="$(git_commit_sha)"
  echo "${sha:0:7}"
}
