#!/bin/bash
# ============================================
# Universal GitHub Push Script
# Works for any project folder
# Usage: bash git-push.sh "commit message" [repo-name]
# ============================================

# --- CONFIG ---
GITHUB_USER="Mpietjebell"
GITHUB_TOKEN="${GITHUB_TOKEN:-YOUR_TOKEN_HERE}"
EMAIL="mpietjebelapps@gmail.com"
NAME="Mpietjebell"

# --- ARGS ---
COMMIT_MSG="${1:-deploy}"
REPO_NAME="${2:-$(basename $(pwd))}"

# --- GIT SETUP ---
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"

# --- INIT IF NEEDED ---
if [ ! -d ".git" ]; then
  echo ">> No git repo found. Initializing..."
  git init -b main
fi

# --- ENSURE MAIN BRANCH ---
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
if [ "$CURRENT_BRANCH" != "main" ] && [ -n "$CURRENT_BRANCH" ]; then
  git branch -M main
fi

# --- SET REMOTE ---
REMOTE_URL="https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git"

if git remote get-url origin &>/dev/null; then
  git remote set-url origin "$REMOTE_URL"
  echo ">> Remote updated to: github.com/${GITHUB_USER}/${REPO_NAME}"
else
  git remote add origin "$REMOTE_URL"
  echo ">> Remote added: github.com/${GITHUB_USER}/${REPO_NAME}"
fi

# --- CHECK IF REPO EXISTS ON GITHUB ---
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  "https://api.github.com/repos/${GITHUB_USER}/${REPO_NAME}")

if [ "$HTTP_CODE" = "404" ]; then
  echo ">> Repo not found on GitHub. Creating '${REPO_NAME}'..."
  curl -s -H "Authorization: token ${GITHUB_TOKEN}" \
    -d "{\"name\":\"${REPO_NAME}\",\"private\":false}" \
    "https://api.github.com/user/repos" > /dev/null
  echo ">> Repo created!"
elif [ "$HTTP_CODE" = "200" ]; then
  echo ">> Repo exists on GitHub."
else
  echo ">> Warning: GitHub API returned $HTTP_CODE. Continuing anyway..."
fi

# --- STAGE, COMMIT, PUSH ---
git add .
git commit -m "$COMMIT_MSG"

# Try pushing to main, fall back to setting upstream
if ! git push origin main 2>/dev/null; then
  echo ">> Setting upstream and pushing..."
  git push -u origin main
fi

echo ""
echo "============================================"
echo "  Pushed to: github.com/${GITHUB_USER}/${REPO_NAME}"
echo "  Branch:    main"
echo "  Message:   ${COMMIT_MSG}"
echo "============================================"
