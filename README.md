# HostileRefereeGPT

HostileRefereeGPT is a small instruction repo for building a custom GPT that acts as an adversarial, evidence-bound top-journal referee.

The repo is not a software package. It is a controlled way to maintain GPT Builder instructions under version control.

The current deployed GPT is focused on:

- category theory,
- recursion categories / partiality,
- logic and foundations.

The built prompt is intentionally committed in `build/` because it is the actual text pasted into GPT Builder.

## What this repo produces

The source files are modular:

```text
header.md
workflow.md
modules/category-theory.md
modules/recursion-categories.md
modules/logic-foundations.md
```

The build concatenates the selected inputs into one GPT Builder instruction payload:

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

That built file is the thing you paste into the GPT Builder **Instructions** field.

## Repository layout

```text
HostileRefereeGPT/
├── Makefile
├── README.md
├── GPT_BUILDER.md
├── LICENSE
├── .gitignore
├── header.md
├── workflow.md
├── modules/
│   ├── category-theory.md
│   ├── recursion-categories.md
│   ├── logic-foundations.md
│   ├── algebraic-topology.md              # optional, if added
│   ├── algebraic-combinatorics.md         # optional, if added
│   ├── probability-statistics.md          # optional, if added
│   ├── algorithms-numerics.md             # optional, if added
│   ├── empirical-computational.md         # optional, if added
│   └── physics-units.md                   # optional, if added
└── build/
    └── hostile-referee-gpt-cat-rec-logic.prompt.md
```

Only the first three modules are selected by the default Makefile. Optional modules may exist in `modules/`, but they are not included unless `MODULES` is changed.

## Design

The repo has three layers.

```text
1. Source instructions
   header.md, workflow.md, modules/*.md

2. Built GPT instruction payload
   build/hostile-referee-gpt-cat-rec-logic.prompt.md

3. Custom GPT
   GPT Builder Instructions field = contents of the built payload
```

The source files make editing manageable. The built file is the deployed instruction text. The custom GPT itself only needs the built text.

## File roles

### `header.md`

Global referee discipline:

- adversarial top-journal role,
- anti-charity rule,
- no steelmanning,
- no invented citations,
- evidence hierarchy,
- anchor rule,
- severity rubric,
- counterexample rule,
- patch-after-failure rule,
- recursive application rule.

### `workflow.md`

Review procedure and output scaffolding:

- Audit mode vs Referee mode,
- required output structure,
- global bar check,
- definition audit,
- theorem/claim audit,
- cross-section consistency audit,
- acceptance gate,
- final self-audit.

### `modules/*.md`

Subject-specific libraries.

Current default build:

```text
category-theory
recursion-categories
logic-foundations
```

### `build/`

Committed generated prompt files.

This repo intentionally commits `build/` because the built prompt is the operational artifact used in GPT Builder.

## Requirements

For the Makefile workflow:

- Git,
- `make`,
- a POSIX-like shell with `cat` and `wc`.

On Windows, use one of:

- Git Bash,
- WSL,
- MSYS2,
- another shell where `make`, `cat`, and `wc` are available.

PowerShell-only instructions are included below.

## Build the GPT instructions

Default build:

```sh
make
```

Equivalent explicit build:

```sh
make MODULES="category-theory recursion-categories logic-foundations"
```

Expected output:

```text
Built build/hostile-referee-gpt-cat-rec-logic.prompt.md (... characters)
```

The Makefile enforces the GPT Builder instruction limit:

```text
8000 characters
```

If the built prompt exceeds the limit, the build fails.

## Verify

Run:

```sh
make verify
```

This rebuilds the prompt, checks that the selected source files exist, and checks the character limit.

## Clean

Run:

```sh
make clean
```

This removes `build/`.

Because `build/` is committed intentionally, rebuild after cleaning:

```sh
make
git status
```

## PowerShell build without `make`

If you are on Windows and do not want to install `make`, build manually from PowerShell:

```powershell
New-Item -ItemType Directory -Force build | Out-Null

$files = @(
  "header.md",
  "workflow.md",
  "modules/category-theory.md",
  "modules/recursion-categories.md",
  "modules/logic-foundations.md"
)

$text = ($files | ForEach-Object { Get-Content $_ -Raw }) -join "`n"

Set-Content `
  -Path "build/hostile-referee-gpt-cat-rec-logic.prompt.md" `
  -Value $text `
  -NoNewline `
  -Encoding utf8

$chars = $text.Length
Write-Host "Built build/hostile-referee-gpt-cat-rec-logic.prompt.md ($chars characters)"

if ($chars -gt 8000) {
  throw "GPT Builder limit exceeded: $chars > 8000"
}
```

Then commit the rebuilt file if it changed.

## Use in GPT Builder

Build first:

```sh
make verify
```

Then open:

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

Copy the entire file and paste it into the GPT Builder **Instructions** field.

Suggested GPT configuration:

```text
Name:
HostileRefereeGPT — Cat/Rec/Logic

Description:
Adversarial, evidence-bound top-journal referee for mathematics manuscripts, focused on category theory, recursion categories/partiality, and logic/foundations.
```

Suggested conversation starters:

```text
Act as a hostile top-journal referee. Audit this manuscript in Audit mode.
```

```text
Run the category-theory, recursion-category, and logic/foundations checks on this paper. Give anchored kill-shots first.
```

```text
Switch to Referee mode and compose a one-page rejection after the audit.
```

The source files do not need to be uploaded as GPT Knowledge. The built prompt belongs in the Instructions field.

## Changing selected modules

The Makefile currently uses:

```make
MODULES ?= category-theory recursion-categories logic-foundations
OUT := build/hostile-referee-gpt-cat-rec-logic.prompt.md
LIMIT := 8000
```

To test a different selection temporarily:

```sh
make MODULES="category-theory logic-foundations"
```

To make a different selection permanent, edit `MODULES` in `Makefile`.

If you permanently change the selected modules, also consider changing `OUT` so the filename remains honest. For example:

```make
OUT := build/hostile-referee-gpt-cat-logic.prompt.md
```

Keep the built prompt under 8000 characters.

## Adding a new module

Create a new file in `modules/`, for example:

```text
modules/algebraic-topology.md
```

Keep it compact. The GPT Builder instruction field is the limiting resource.

A good module should include:

- trigger terms,
- failure modes,
- required checks,
- toy tests or minimal counterexamples,
- output requirements.

Then include it temporarily:

```sh
make MODULES="category-theory recursion-categories logic-foundations algebraic-topology"
```

If it fits and should be permanent, update `Makefile`.

## Character budget discipline

The built prompt must be at most 8000 characters.

When adding text, prefer compact imperatives over long explanations.

Bad:

```text
The referee should carefully consider whether the author may have intended a different meaning.
```

Good:

```text
Do not infer intent. Ambiguity is a defect.
```

Bad:

```text
When a functor is mentioned, the model should make sure that the construction is actually functorial.
```

Good:

```text
For each functor: source, target, object map, arrow map, variance, identity, composition.
```

## Local Git setup

From inside the repo:

```sh
git init
git branch -M main
git add .
git commit -m "Initial HostileRefereeGPT instruction repo"
```

## GitHub remote

For the GitHub user `flengyel` and repo `HostileRefereeGPT`:

```sh
git remote add origin git@github.com:flengyel/HostileRefereeGPT.git
git push -u origin main
```

If the remote already exists but is wrong:

```sh
git remote set-url origin git@github.com:flengyel/HostileRefereeGPT.git
git remote -v
```

HTTPS alternative:

```sh
git remote set-url origin https://github.com/flengyel/HostileRefereeGPT.git
git push -u origin main
```

## Normal update workflow

After editing source instructions:

```sh
make verify
git status
git add header.md workflow.md modules/ build/ README.md GPT_BUILDER.md Makefile .gitignore LICENSE
git commit -m "Update GPT referee instructions"
git push
```

Then paste the updated contents of:

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

back into the GPT Builder Instructions field.

## Recommended commit habits

Commit source and build together.

Good:

```text
Update recursion-category checks
```

with changes to:

```text
modules/recursion-categories.md
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

Avoid committing source changes without rebuilding the prompt, unless the source file is not part of the selected build.

## Troubleshooting

### `make` is not recognized

Use Git Bash, WSL, MSYS2, or the PowerShell manual build above.

### Build exceeds 8000 characters

Remove lower-priority checks, compress wording, or change the selected modules.

Run:

```sh
wc -m build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

### GPT Builder refuses the instructions

Check the character count:

```sh
make verify
```

Then paste only the contents of the built prompt file, not the whole repo.

### The GPT is too soft

Strengthen `header.md`, especially:

- anti-charity,
- no steelmanning,
- ambiguity is a defect,
- patch only after failure is shown.

Then rebuild and repaste.

### The GPT misses a domain-specific error

Add or sharpen the relevant module.

For example:

```text
modules/recursion-categories.md
```

for partiality, extensionality, Rice/Rice-Shapiro, and recursion-category issues.

### The GPT gives generic comments instead of anchored findings

Strengthen `workflow.md`, especially:

- anchor rule,
- required finding structure,
- kill-shots first,
- counterexample or missing hypothesis,
- final self-audit.

Then rebuild and repaste.

## License

MIT. See `LICENSE`.

## Current status

Default built GPT:

```text
HostileRefereeGPT — Cat/Rec/Logic
```

Default selected modules:

```text
category-theory recursion-categories logic-foundations
```

Built instruction payload:

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

Maximum instruction size:

```text
8000 characters
```
