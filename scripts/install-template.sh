#!/usr/bin/env bash
# Interactive installer for the agy / cc agent-role templates from
# CTJ425/agy_agent_lab.
#
# Recommended usage (works from any directory, no clone needed):
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/CTJ425/agy_agent_lab/main/scripts/install-template.sh)"
#
# Also works piped directly: curl -fsSL <raw-url> | bash
# (prompts read from /dev/tty so they work either way).
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/CTJ425/agy_agent_lab/main"

prompt() {
  # prompt <question> <default> -> echoes answer (or default if empty/no tty)
  local question="$1" default="$2" answer=""
  read -r -p "$question" answer < /dev/tty || true
  echo "${answer:-$default}"
}

echo "選擇要安裝的範本："
echo "  1) agy  (Antigravity CLI: .antigravity/ + GEMINI.md)"
echo "  2) cc   (Claude Code:    .claude/agents/ + CLAUDE.md)"
choice=$(prompt "輸入 1 或 2: " "")

case "$choice" in
  1) kind="agy" ;;
  2) kind="cc" ;;
  *)
    echo "無效選項：$choice" >&2
    exit 1
    ;;
esac

default_dir="$(pwd)"
target=$(prompt "目標資料夾路徑 [$default_dir]: " "$default_dir")
target="${target/#\~/$HOME}"

if [ "$kind" = "agy" ]; then
  agents_dir="$target/.antigravity"
  root_name="GEMINI.md"
  files=(critic-architect lead-architect logic-reviewer senior-coder testing-reviewer workflow)
else
  agents_dir="$target/.claude/agents"
  root_name="CLAUDE.md"
  files=(critic-architect lead-architect logic-reviewer senior-coder testing-reviewer)
fi

mkdir -p "$agents_dir"

installed=()
skipped=()

fetch() {
  local url="$1" dest="$2"
  if [ -e "$dest" ]; then
    local ans
    ans=$(prompt "$dest 已存在，覆蓋嗎？[y/N]: " "N")
    case "$ans" in
      y|Y) ;;
      *)
        skipped+=("$dest")
        return
        ;;
    esac
  fi
  curl -fsSL "$url" -o "$dest"
  installed+=("$dest")
}

for f in "${files[@]}"; do
  fetch "$REPO_RAW/templates/$kind/$f.md.example" "$agents_dir/$f.md"
done

fetch "$REPO_RAW/templates/$kind/$root_name.example" "$target/$root_name"

echo
echo "=== 安裝結果（$kind → $target） ==="
if [ "${#installed[@]}" -gt 0 ]; then
  echo "已寫入："
  printf '  %s\n' "${installed[@]}"
fi
if [ "${#skipped[@]}" -gt 0 ]; then
  echo "已略過（檔案已存在）："
  printf '  %s\n' "${skipped[@]}"
fi
