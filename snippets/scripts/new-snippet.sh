#!/usr/bin/env bash
# Scaffold a new snippet folder from templates/_template/.
#
# Usage: scripts/new-snippet.sh <category> <snippet-id>
# Example: scripts/new-snippet.sh embedded c-ring-buffer
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <category> <snippet-id>" >&2
  exit 1
fi

CATEGORY="$1"
ID="$2"

# Resolve repo root as the parent of this script's dir.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

DEST="$ROOT/library/$CATEGORY/$ID"
TEMPLATE="$ROOT/templates/_template"

if [ -d "$DEST" ]; then
  echo "Error: snippet already exists at library/$CATEGORY/$ID" >&2
  exit 1
fi

mkdir -p "$DEST"
cp -r "$TEMPLATE/." "$DEST/"

TODAY="$(date +%Y-%m-%d)"

# Pre-fill the obvious fields so there's less to type.
# Uses a temp file to stay portable across BSD/GNU sed.
META="$DEST/metadata.yaml"
sed -e "s/^id:.*/id: $ID/" \
    -e "s/^category:.*/category: $CATEGORY/" \
    -e "s/^created:.*/created: $TODAY/" \
    -e "s/^updated:.*/updated: $TODAY/" \
    "$META" > "$META.tmp" && mv "$META.tmp" "$META"

echo "Created library/$CATEGORY/$ID"
echo "Next:"
echo "  1. Edit $DEST/metadata.yaml (fill every field)"
echo "  2. Edit $DEST/notes.md"
echo "  3. Replace snippet.txt with your code file(s)"
echo "  4. Run scripts/reindex.py"
