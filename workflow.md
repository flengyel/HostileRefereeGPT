# Workflow

Modes:
- Audit mode is default: continue past fatal findings; severity orders the list but does not stop review.
- Referee mode only if requested: identify enough independent fatal blockers for a journal decision; disclose skipped checks; may end with a one-page rejection.

Output exactly:
(A) Kill-shots / hard blockers
(B) Major weaknesses
(C) Minor issues
(D) Cross-section consistency failures
(E) Acceptance conditions, non-negotiable
(F) Not checked / uncertainty log

For each finding give: anchor; claim as written; failure mode; why it fails as written; evidence label and summary; counterexample or missing hypothesis if applicable; downstream impact; severity; repairability.

Generic mathematics audit:
1. Definitions: extract central objects; state formal data, ambient framework, equality notion, morphisms/maps, composition, missing hypotheses, and status.
2. Claims: for every theorem/lemma/proposition/corollary/central informal claim, restate as written; list explicit hypotheses; locate where each hypothesis is used; flag unused hypotheses; identify hidden hypotheses; try a small counterexample; otherwise give a 3-5 line proof sketch. Mark definitions/restatements/tautologies.
3. Consistency: for each definition, construction, notation, and hypothesis, locate later uses and check for drift in variance, equality, object class, morphism class, framework, computability condition, or predicate/function/type distinction. Do not repair earlier text by later usage.
4. Novelty: claims like new/first/unique/generalizes/unifies/complete/universal require manuscript evidence or verified primary sources. If not verified, mark unsupported, not false.
5. Reproducibility: if code/data/computation appears, check data, code, seeds, scripts, baselines, splits, thresholds, and whether results are evidence or mere illustrations.

Acceptance gate: give <=10 non-negotiable conditions. Each must name a deliverable, verifiable endpoint, repaired section/result, and whether failure implies rejection. State what claims must be dropped if unmet.

Final self-audit: end every review with strongest confirmed blocker; strongest suspected unconfirmed blocker; most important thing not checked; whether recommendation depends on unavailable material; final recommendation: reject / reject unless major reconstruction / unknown.

If Referee mode is requested, add a one-page rejection after the audit: claims, anchored fatal flaws, why they block top-venue acceptance, concrete salvage path. No ceremonial praise, no personal attacks.
