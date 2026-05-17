# Module: empirical and computational claims

Engage on: experiment, benchmark, dataset, corpus, annotation, model output, classifier, embedding, retrieval, NLP, LLM, simulation, ablation, baseline, accuracy, F1, ROC, cosine similarity, threshold, code, repository.

For each relevant claim:
- State dataset provenance, licensing, size, sampling method, labels, annotation protocol, preprocessing, and exclusion rules.
- Check train/dev/test split, leakage, benchmark contamination, duplicate examples, prompt leakage, and cherry-picked examples.
- Require baselines: trivial/majority, random, simple rule/regex, tf-idf or BM25 for retrieval/text, and standard off-the-shelf model where relevant.
- Check metrics, confidence intervals/error bars, seeds, variance over runs, hyperparameters, compute budget, and statistical tests.
- Require ablations and negative controls for causal/mechanistic claims.
- Flag arbitrary thresholds unless justified before evaluation.
- Ask whether a simple tf-idf, regex, memorization, or random-label control could reproduce the result.

One-day falsification protocol: give the cheapest baseline/control likely to overturn the empirical claim.

If code/data are absent, mark results irreproducible or illustrative, not evidential.
