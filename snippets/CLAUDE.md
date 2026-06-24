# Agent guide — snippets repo

This file is the contract for any AI agent working in this repo. Its purpose is
to **preserve context across sessions**: a snippet added today should be fully
understandable by an agent in a brand-new chat with zero prior memory.

`AGENTS.md` is a copy of this file for vendor-neutral tooling. If you edit one,
mirror the change into the other.

## The core rule

> A snippet is never just code. It is `code + metadata + notes`, bundled in one
> folder. If you add code without metadata and notes, you have lost context and
> violated the point of this repo.

## Repo model

```
library/<category>/<snippet-id>/
├── metadata.yaml   # structured, machine-parseable facts
├── notes.md        # human prose: the "why" and the "watch out"
└── <code files>    # the snippet itself
```

- `<category>` is a short lowercase slug: `embedded`, `python`, `cpp`, `ml`,
  `shell`, `web`, … Create a new one freely when nothing fits.
- `<snippet-id>` is a unique, descriptive, lowercase-kebab slug, e.g.
  `c-ring-buffer`, `pytorch-lr-finder`. It must match `id:` in `metadata.yaml`.

## When READING a snippet

1. Load `manifest.json` to find candidates fast (it indexes id, title, tags,
   language, status, description).
2. Open the snippet folder. **Read `notes.md` and `metadata.yaml` before the
   code.** They tell you the intent, how to run it, and known gotchas — the
   context you would otherwise have to reverse-engineer.

## When ADDING a snippet

1. `scripts/new-snippet.sh <category> <snippet-id>` — scaffolds the folder from
   `templates/_template/`.
2. Fill in **every** field in `metadata.yaml` (see schema below). Do not leave
   placeholder text.
3. Write `notes.md`: what it does, how to run/build it, dependencies, gotchas,
   and links to related snippets by id.
4. Add the code file(s).
5. Run `scripts/reindex.py` to regenerate `INDEX.md` and `manifest.json`.
   **Never hand-edit those two files** — they are generated.
6. Commit with a message like `add(<category>/<snippet-id>): <one-line summary>`.

## When UPDATING a snippet

- Bump `updated:` in `metadata.yaml` to today's date.
- If behavior/status changed, reflect it in `notes.md` and `status:`.
- Re-run `scripts/reindex.py`.

## metadata.yaml schema

Keep it flat (the reindex script's fallback parser expects flat keys). Lists use
`[a, b, c]` inline form.

| Field | Required | Meaning |
|-------|----------|---------|
| `id` | yes | Unique slug; must equal the folder name |
| `title` | yes | Human title, one line |
| `language` | yes | Primary language, e.g. `c`, `python`, `cpp` |
| `category` | yes | Must equal the parent folder name |
| `tags` | yes | Inline list for search, e.g. `[buffer, isr-safe]` |
| `status` | yes | One of `working`, `wip`, `broken`, `reference` |
| `description` | yes | One-sentence summary (used in indexes) |
| `source` | yes | Where it came from: `hand-written`, a URL, a paper, etc. |
| `dependencies` | yes | Inline list; `[]` if none |
| `created` | yes | `YYYY-MM-DD` |
| `updated` | yes | `YYYY-MM-DD` |

## Don'ts

- Don't drop loose code files outside a snippet folder.
- Don't hand-edit `INDEX.md` or `manifest.json`.
- Don't leave template placeholders in a committed snippet.
