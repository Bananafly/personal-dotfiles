---
name: anki-card
description: Create Anki flashcards from concepts explained in the conversation and export them as an importable file. Use when the user wants to save something they just learned as a flashcard, says "make an Anki card", "add to my deck", or accepts an offer to capture a topic for spaced repetition.
version: 1.0.0
tags: [anki, flashcards, learning, spaced-repetition]
---

# Anki Card Creation

## When to Use

When the user wants to turn a concept from the conversation into Anki flashcard(s). Usually triggered by accepting the "Want an Anki card for this?" offer (see the anki-offer rule), or an explicit request.

## Card design principles

- **One concept per card.** Atomic. If a topic has several distinct ideas, make several cards.
- **Front = a question or prompt**, not a title. Prefer "What is X? / Why does X? / Give the syntax for X" over a bare noun.
- **Back = enough to actually re-learn from**, not a one-liner. A crisp definition, then the *why* / a concrete example / a common gotcha. The user prefers detail over terseness.
- Use **concrete code examples** on the back when the concept is code-related. Where the user knows an analogous language (e.g. TypeScript/React), include a parallel example in it — it anchors the idea.
- Call out **common bugs / gotchas / "not what you'd expect"** points explicitly; those make the best cards.
- Skip cards for opinions, strategy, or ephemeral command output.

## Workflow

### 1. Draft and confirm

Show the proposed card(s) as plain front/back text in the chat first. Let the user adjust depth, examples, or split/merge before generating the file. Don't generate the file until they're happy.

### 2. Generate the import file with a script

Write the cards via a small Python script (not by hand) so HTML and quotes escape correctly. Use `$CLAUDE_JOB_DIR/tmp` for the script if in a background job, else a temp dir. Output the deck file to a stable path like `~/ml-anki-cards.txt` (ask or reuse if one exists).

Requirements for the file:
- First two lines are Anki directives: `#separator:tab` then `#html:true`.
- One row per card, two tab-separated fields: front, back.
- Use `csv.writer(..., delimiter="\t", quoting=csv.QUOTE_MINIMAL)` so multi-line HTML fields are quoted correctly.
- In the back HTML: `<br>` for line breaks, `<b>`/`<i>` for emphasis, `<code>` for inline code, `<pre><code>...</code></pre>` for code blocks, `<table border="1" cellpadding="4">` for tables. Escape `<`, `>`, `&` inside code as `&lt; &gt; &amp;` where they'd otherwise be parsed as tags.

Skeleton:

```python
import csv
rows = [[front1, back1], [front2, back2]]
with open(out_path, "w", newline="") as f:
    f.write("#separator:tab\n#html:true\n")
    w = csv.writer(f, delimiter="\t", quoting=csv.QUOTE_MINIMAL)
    for r in rows:
        w.writerow(r)
```

### 3. Verify before handing off

Re-parse the file (skipping `#` lines) with `csv.reader(delimiter="\t")` and assert: correct row count, every row has exactly 2 fields. This catches escaping bugs that would silently merge or split cards on import.

### 4. Tell the user how to import

- Anki → **File → Import** → select the file.
- Type: **Basic** (front/back). Deck: the user's target deck (default they've mentioned: "Machine Learning").
- Field separator: **Tab** (auto-detected from the directive).
- **Allow HTML in fields: on** (auto-set by `#html:true` — have them confirm, else tags render raw).
- Note that HTML tables may look cramped on mobile; offer to reissue as a plain list if so.

## Notes

- Anki must be installed (`brew install --cask anki`). The workflow only produces an import file; the user imports manually.
- If appending to an existing deck file, preserve the two directive lines at top and just add rows.
