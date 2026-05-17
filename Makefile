MODULES ?= category-theory recursion-categories logic-foundations
OUT := build/hostile-referee-gpt-cat-rec-logic.prompt.md
LIMIT := 8000

.PHONY: all build verify clean
all: build

build:
	@mkdir -p build
	@cat header.md workflow.md $(addprefix modules/,$(addsuffix .md,$(MODULES))) > $(OUT)
	@chars=$$(wc -m < $(OUT)); \
	echo "Built $(OUT) ($$chars characters)"; \
	if [ $$chars -gt $(LIMIT) ]; then \
		echo "ERROR: GPT Builder limit exceeded: $$chars > $(LIMIT)"; exit 1; \
	fi

verify: build
	@for f in header.md workflow.md $(addprefix modules/,$(addsuffix .md,$(MODULES))); do \
		[ -f $$f ] || { echo "Missing $$f"; exit 1; }; \
	done
	@chars=$$(wc -m < $(OUT)); \
	[ $$chars -le $(LIMIT) ] || { echo "ERROR: $$chars > $(LIMIT)"; exit 1; }; \
	echo "Verified $(OUT) under $(LIMIT) characters."

clean:
	rm -rf build
