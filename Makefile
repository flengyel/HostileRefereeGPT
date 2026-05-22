DEFAULT_MODULES := category-theory recursion-categories
DEFAULT_OUT := build/hostile-referee-gpt-cat-rec.prompt.md
MODULES ?= $(DEFAULT_MODULES)
OUT ?= $(DEFAULT_OUT)
LIMIT := 8000
SOURCES := header.md workflow.md $(addprefix modules/,$(addsuffix .md,$(MODULES)))

.PHONY: all build verify clean audit audit-build audit-policy
all: build

build: $(SOURCES)
	@if [ "$(MODULES)" != "$(DEFAULT_MODULES)" ] && [ "$(OUT)" = "$(DEFAULT_OUT)" ]; then \
		echo "ERROR: nondefault MODULES would overwrite $(DEFAULT_OUT); set OUT=build/scratch.prompt.md"; exit 1; \
	fi
	@mkdir -p "$$(dirname "$(OUT)")"
	@tmp=$$(mktemp); \
	trap 'rm -f "$$tmp"' EXIT; \
	cat $(SOURCES) > "$$tmp"; \
	chars=$$(wc -m < "$$tmp"); \
	echo "Built $(OUT) ($$chars characters)"; \
	if [ $$chars -gt $(LIMIT) ]; then \
		echo "ERROR: GPT Builder limit exceeded: $$chars > $(LIMIT)"; exit 1; \
	fi; \
	mv "$$tmp" "$(OUT)"

verify: build audit-build audit-policy
	@echo "Verified $(OUT) under $(LIMIT) characters and passed policy audit."

audit: build audit-build audit-policy

# Build consistency and committed-output check.
audit-build:
	@tmp=$$(mktemp); \
	trap 'rm -f $$tmp' EXIT; \
	cat $(SOURCES) > $$tmp; \
	cmp -s $$tmp $(OUT) || { echo "ERROR: $(OUT) does not match selected sources"; exit 1; }; \
	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then \
		git diff --quiet -- $(OUT) || { echo "ERROR: $(OUT) changed after rebuild; commit source and build together"; exit 1; }; \
	fi

# Policy-contract checks. These verify repository design invariants, not user-prompt classification.
audit-policy: build
	@test -f scripts/build-prompt.ps1
	@grep -Fq "[IO.File]::ReadAllBytes" scripts/build-prompt.ps1
	@grep -Fq "Stream.Write" scripts/build-prompt.ps1
	@if grep -Eq 'Get-Content|Set-Content|Out-File' scripts/build-prompt.ps1; then \
		echo "ERROR: PowerShell build script must byte-concatenate; avoid Get-Content, Set-Content, and Out-File"; exit 1; \
	fi
	@grep -Fq "confidential third-party" header.md
	@grep -Eq "confidential evaluation|confidential evaluator|under confidential evaluation" header.md
	@grep -Eq "public text|publicly available|including public text" header.md
	@grep -Fq "No concealed AI assistance in peer review." $(OUT)
	@grep -Fq "Never present output as human review." $(OUT)
	@bad=$$(grep -RInE 'public preprint.*always allowed|always.*public preprint|not confidential because.*public|publicly available.*therefore.*allowed|AI assistance.*need not be disclosed' README.md GPT_BUILDER.md ETHICAL_USE.md header.md workflow.md modules build || true); \
	if [ -n "$$bad" ]; then \
		echo "ERROR: possible policy/build contradiction:"; \
		echo "$$bad"; \
		exit 1; \
	fi

clean:
	rm -rf build