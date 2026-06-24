# Agent guide — snippets repo

This is a vendor-neutral copy of `CLAUDE.md`. The two files must stay in sync —
if you edit one, mirror the change into the other.

See **[CLAUDE.md](./CLAUDE.md)** for the full contract: the core rule, repo
model, how to read/add/update snippets, and the `metadata.yaml` schema.

Summary of the one rule that matters most:

> A snippet is never just code. It is `code + metadata + notes`, bundled in one
> folder under `library/<category>/<snippet-id>/`. Always read `notes.md` and
> `metadata.yaml` before the code, and always run `scripts/reindex.py` after
> adding or changing a snippet.
