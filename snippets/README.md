# snippets

An organized, **agent-friendly** collection of code snippets.

The goal: upload snippets in a structured way so that — months later, in a fresh
chat — an AI agent (or you) can pick any snippet back up *without losing the
context* of what it is, why it exists, how to run it, and what to watch out for.

## How it works

Every snippet is a **folder**, not a loose file. The folder bundles the code
with the context that usually evaporates:

```
library/<category>/<snippet-id>/
├── metadata.yaml   # structured facts: language, tags, deps, status, source…
├── notes.md        # prose context: what it does, how to run, gotchas, links
└── <code files>    # the actual snippet (one or more files)
```

Two generated indexes let an agent load the whole catalog fast:

- `INDEX.md`     — human-readable table of every snippet
- `manifest.json` — machine-readable version of the same

## Quick start

```bash
# scaffold a new snippet folder from the template
scripts/new-snippet.sh <category> <snippet-id>

# edit the generated metadata.yaml + notes.md, drop your code in, then:
scripts/reindex.py          # rebuilds INDEX.md and manifest.json
```

## For agents

Read `AGENTS.md` (or `CLAUDE.md`) first. It is the contract for how to read,
add, and update snippets so context is never lost.

## Layout

| Path | Purpose |
|------|---------|
| `library/`   | All snippets, grouped by category |
| `templates/` | The `_template/` folder copied for each new snippet |
| `scripts/`   | `new-snippet.sh` (scaffold) and `reindex.py` (rebuild indexes) |
| `INDEX.md`   | Generated catalog (do not hand-edit) |
| `manifest.json` | Generated machine catalog (do not hand-edit) |
| `AGENTS.md` / `CLAUDE.md` | The conventions, for any AI agent |
