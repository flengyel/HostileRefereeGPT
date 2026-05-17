# HostileRefereeGPT

A small source repo for building GPT Builder instructions for an adversarial mathematics referee. It uses modular inputs but produces one ready-to-paste GPT instruction file.

Current build: category theory + recursion categories/partiality + logic/foundations.

## Layout

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
│   └── logic-foundations.md
└── build/
    └── hostile-referee-gpt-cat-rec-logic.prompt.md
```

## Build

```sh
make
```

or explicitly:

```sh
make MODULES="category-theory recursion-categories logic-foundations"
```

The Makefile concatenates:

```text
header.md + workflow.md + selected modules
```

and enforces the GPT Builder 8000-character limit.

## Use in GPT Builder

Paste the contents of:

```text
build/hostile-referee-gpt-cat-rec-logic.prompt.md
```

into the GPT Builder Instructions field.

The built file is committed intentionally. It is the actual GPT instruction payload.
