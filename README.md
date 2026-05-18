# HostileRefereeGPT

HostileRefereeGPT is a repository for maintaining GPT Builder instructions for an adversarial journal referee.

The repository stores editable source files and the built instruction file used in GPT Builder. The built file is committed because it is the deployed instruction text.

## Current build

The default build uses these files:

```text
header.md
workflow.md
modules/category-theory.md
modules/recursion-categories.md
modules/logic-foundations.md
```

It produces:

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

Paste that file into the GPT Builder **Instructions** field.

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
│   ├── algebraic-topology.md
│   ├── algebraic-combinatorics.md
│   ├── probability-statistics.md
│   ├── algorithms-numerics.md
│   ├── empirical-computational.md
│   └── physics-units.md
└── build/
    └── hostile-referee-gpt-cat-rec-logic.prompt.md
```

Only the modules named in `Makefile` are included in the built prompt.

## File roles

### `header.md`

Global rules for the referee:

- adversarial review posture;
- anti-charity rule;
- no steelmanning;
- no invented citations;
- evidence hierarchy;
- anchor requirement;
- severity categories;
- counterexample requirement;
- patch-after-failure rule.

### `workflow.md`

Review procedure:

- Audit mode and Referee mode;
- required output sections;
- global bar check;
- definition audit;
- theorem and claim audit;
- cross-section consistency audit;
- acceptance gate;
- final self-audit.

### `modules/*.md`

Subject-specific checks. The default module set is:

```text
category-theory
recursion-categories
logic-foundations
```

Other module files may be kept in `modules/` without being included in the build.

### `build/`

Generated prompt files. These files are committed intentionally.

## Requirements

The Makefile workflow requires:

- Git;
- `make`;
- `cat`;
- `wc`;
- a shell that can run the commands in `Makefile`.

On Windows, Git Bash, WSL, or MSYS2 is sufficient. A PowerShell-only build is given below.

## Build

Default build:

```sh
make
```

Explicit build:

```sh
make MODULES="category-theory recursion-categories logic-foundations"
```

Verify the build and the character limit:

```sh
make verify
```

Remove generated files:

```sh
make clean
```

After `make clean`, rebuild before committing:

```sh
make
git status
```

## PowerShell build without `make`

From the repository root:

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

## Use in GPT Builder

Build and verify first:

```sh
make verify
```

Then copy the full contents of:

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

into the GPT Builder **Instructions** field.

Suggested GPT fields:

```text
Name:
HostileRefereeGPT — Cat/Rec/Logic

Description:
Adversarial journal referee for manuscripts involving category theory, recursion categories, and logic or foundations.
```

Suggested conversation starters:

```text
Audit this manuscript in Audit mode.
```

```text
Run the category-theory, recursion-category, and logic/foundations checks. Give anchored kill-shots first.
```

```text
Switch to Referee mode and write the rejection after the audit.
```

Do not upload the source files as GPT Knowledge merely to provide instructions. The built prompt belongs in the Instructions field.

## Change the selected modules

The default module selection is set in `Makefile`:

```make
MODULES ?= category-theory recursion-categories logic-foundations
OUT := build/hostile-referee-gpt-cat-rec-logic.prompt.md
LIMIT := 8000
```

To test a different selection:

```sh
make MODULES="category-theory logic-foundations"
```

To make a selection permanent, edit `MODULES` in `Makefile`.

If the selected modules change, also update `OUT` so the filename describes the build.

## Add a module

Create a file in `modules/`, for example:

```text
modules/algebraic-topology.md
```

Keep the module short enough for the final prompt to remain under the GPT Builder limit.

A module should contain:

- trigger terms;
- failure modes;
- required checks;
- toy tests or minimal counterexamples;
- output requirements.

Test the module with:

```sh
make MODULES="category-theory recursion-categories logic-foundations algebraic-topology"
```

If the build fits and the module should be part of the deployed GPT, update `Makefile`.

## Character limit

The built prompt must be at most 8000 characters.

Check the length with:

```sh
make verify
```

or:

```sh
wc -m build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

When editing, prefer short imperatives.

Examples:

```text
Do not infer intent. Ambiguity is a defect.
```

```text
For each functor: source, target, object map, arrow map, variance, identity, composition.
```

## Local Git setup

From the repository root:

```sh
git init
git branch -M main
git add .
git commit -m "Initial HostileRefereeGPT instruction repo"
```

## GitHub remote

For GitHub user `flengyel` and repository `HostileRefereeGPT`:

```sh
git remote add origin git@github.com:flengyel/HostileRefereeGPT.git
git push -u origin main
```

If `origin` already exists and is wrong:

```sh
git remote set-url origin git@github.com:flengyel/HostileRefereeGPT.git
git remote -v
```

HTTPS alternative:

```sh
git remote set-url origin https://github.com/flengyel/HostileRefereeGPT.git
git push -u origin main
```

## Update workflow

After editing source instructions:

```sh
make verify
git status
git add header.md workflow.md modules/ build/ README.md GPT_BUILDER.md Makefile .gitignore LICENSE
git commit -m "Update GPT referee instructions"
git push
```

Then update the GPT Builder Instructions field with the contents of:

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

Commit source and build together when the built prompt changes.

## Troubleshooting

### `make` is not recognized

Use Git Bash, WSL, MSYS2, or the PowerShell build above.

### The build exceeds 8000 characters

Remove lower-priority text, shorten module wording, or reduce the selected module set.

### GPT Builder refuses the instructions

Run:

```sh
make verify
```

Then paste only the contents of the built prompt file.

### The GPT gives comments without anchors

Edit `workflow.md` to strengthen the anchor requirement, finding structure, and final self-audit. Rebuild and update GPT Builder.

### The GPT misses a subject-specific error

Edit the relevant file in `modules/`. Rebuild and update GPT Builder.

## License

MIT. See `LICENSE`.

## Default artifact

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```
