#!/usr/bin/env bash
# Hillbilly Jed's — one-shot GitHub publishing script.
# Run this once from Terminal: bash publish-to-github.sh

set -e

REPO_NAME="hillbilly-jeds-hot-sauce"
REPO_DESC="Website for Hillbilly Jed's Hot Sauce — hand crafted in North Carolina."

cd "$(dirname "$0")"

echo "→ Cleaning any previous git state"
# sudo may be needed if the earlier sandbox attempt left files behind
if [ -d .git ]; then
  rm -rf .git 2>/dev/null || sudo rm -rf .git
fi

echo "→ Checking for gh CLI"
if ! command -v gh &>/dev/null; then
  echo "❌ GitHub CLI (gh) not found."
  echo "   Install with:  brew install gh"
  echo "   Then authenticate with:  gh auth login"
  exit 1
fi

echo "→ Verifying gh is authenticated"
if ! gh auth status &>/dev/null; then
  echo "→ You're not logged in. Running 'gh auth login'..."
  gh auth login
fi

GH_USER="$(gh api user -q .login)"
echo "→ Authenticated as $GH_USER"

echo "→ Initializing git repo"
git init -b main
git add .
git commit -m "Initial commit: Hillbilly Jed's Hot Sauce website"

echo "→ Creating public repo '$REPO_NAME' on GitHub and pushing"
gh repo create "$REPO_NAME" \
  --public \
  --description "$REPO_DESC" \
  --source=. \
  --remote=origin \
  --push

REPO_URL="https://github.com/$GH_USER/$REPO_NAME"
PAGES_URL="https://$GH_USER.github.io/$REPO_NAME/"

echo ""
echo "✅ Repo created and pushed: $REPO_URL"
echo ""
echo "→ Enabling GitHub Pages (free hosting)"
gh api --silent -X POST "repos/$GH_USER/$REPO_NAME/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null && \
  echo "✅ GitHub Pages enabled. Your site will be live at:" && \
  echo "   $PAGES_URL" && \
  echo "   (give it 1-2 minutes to build the first time)" || \
  echo "ℹ️  Pages API couldn't auto-enable — do it manually:"
  echo "   Open $REPO_URL/settings/pages and set 'Deploy from a branch' → main → / (root)"

echo ""
echo "Done! 🌶️"
