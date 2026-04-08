#!/usr/bin/env bash

#sudo apt update
#sudo apt install ruby-full build-essential zlib1g-dev bundler

set -euo pipefail

cd "$(dirname "$0")"

if ! command -v ruby >/dev/null 2>&1; then
  cat <<'EOF'
Ruby is not installed in WSL.

Install it with:
  sudo apt update
  sudo apt install ruby-full build-essential zlib1g-dev
EOF
  exit 1
fi

if ! command -v bundle >/dev/null 2>&1; then
  cat <<'EOF'
Bundler is not installed in WSL.

Install it with:
  sudo apt update
  sudo apt install bundler
EOF
  exit 1
fi

if ! bundle check >/dev/null 2>&1; then
  echo "Installing Ruby gems for the site..."
  bundle install
fi

exec bundle exec jekyll serve \
  --livereload \
  --host localhost \
  --port 4000 \
  --config _config.yml,_config.dev.yml \
  --force_polling
