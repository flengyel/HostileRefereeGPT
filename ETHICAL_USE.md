# Ethical use statement

This repository provides prompts and tooling for adversarial self-audit of mathematical writing. Its purpose is to help authors find errors, ambiguities, missing hypotheses, unsupported generalizations, and exposition failures in their own work before submission or public circulation.

This document says what the tool is for, how it should not be used, and why. The repository's `README.md` gives the short version.

## Permitted use

The following uses are permitted:

- auditing one's own manuscript before submission, including under hostile-referee posture;
- auditing one's own response to a referee report or evaluation received through an authorized process, without uploading confidential third-party text unless permitted;
- auditing public preprints for one's own study or teaching, provided the use is not connected to a confidential referee, editorial, committee, or evaluator role;
- methodological commentary on the tool itself, including running the tool on its own output;
- teaching how to read a mathematical paper critically.

Reading or auditing a public preprint for one's own purposes is distinct from evaluating it under a confidential assignment from a journal, conference, funder, institution, or committee. The first is permitted; the second falls under the prohibited category even if the text is also publicly available. The prohibition here is not based on the confidentiality of the text, which is public, but on the evaluator role: a confidential assignment carries obligations of personal judgment and disclosure that undisclosed delegation to this tool would evade.

## Prohibited use

The tool must not be used to generate or substantially draft a report, evaluation, or recommendation for confidential third-party material received under any expectation of confidentiality.

In particular, the tool must not be used to:

- upload or analyze confidential third-party material received as a referee, editor, committee member, program-committee member, grant reviewer, hiring reviewer, tenure reviewer, admissions reviewer, prize-committee member, or other evaluator without explicit authorization under the applicable policy;
- prepare or submit a report, evaluation, or recommendation for confidential third-party material while concealing AI assistance;
- replace the evaluator's own expert judgment in any confidential review or evaluation;
- evade journal, publisher, society, institutional, funding-body, or committee policies on confidentiality, disclosure, or AI use.

The built prompt includes a refusal rule: if the user indicates that the material under audit is confidential third-party material received through a referee, editorial, committee, or evaluator role, the tool refuses to produce audit or review output and explains the confidentiality issue. The refusal is part of the tool's design. Removing or weakening the refusal rule is contrary to the intended use of this project.

## Rationale

Peer review and similar evaluations depend on a limited-use exchange: authors, applicants, and candidates submit material for assessment by designated evaluators, not for redistribution, outsourcing, or undisclosed machine processing. Generative AI systems may expose submitted material to third parties, fabricate criticisms or citations, misstate technical arguments, and obscure who is responsible for the evaluation. Editing the output does not cure unauthorized use; undisclosed AI assistance can violate the conditions under which the material was submitted.

Several publishers and societies have published policies on AI use in peer review. The London Mathematical Society's AI policy addresses the use of AI tools in the review of submitted manuscripts. Nature Portfolio's AI policy addresses reviewer use of generative-AI tools and disclosure of AI-supported evaluation. Elsevier's journal policy addresses confidentiality of submitted manuscripts and reviewer use of generative AI. Taylor & Francis's AI policy addresses reviewer use of AI tools for review reports. These policies are not uniform across all venues, may change over time, and may not cover every relevant case. The responsibility to check the applicable policy rests with the user.

References, accessed 2026-05-19:

- London Mathematical Society, AI policy: [https://www.lms.ac.uk/publications/policies/AI](https://www.lms.ac.uk/publications/policies/AI)
- Nature Portfolio, AI editorial policies: [https://www.nature.com/nature-portfolio/editorial-policies/ai](https://www.nature.com/nature-portfolio/editorial-policies/ai)
- Elsevier, generative AI policies for journals: [https://www.elsevier.com/about/policies-and-standards/generative-ai-policies-for-journals](https://www.elsevier.com/about/policies-and-standards/generative-ai-policies-for-journals)
- Taylor & Francis, AI policy: [https://taylorandfrancis.com/our-policies/ai-policy/](https://taylorandfrancis.com/our-policies/ai-policy/)

## Edge cases

Some venues may, now or in the future, authorize AI-assisted review under specific protocols with disclosure, confidentiality safeguards, and approved infrastructure. This document does not claim that such use is universally impossible. It says that this public tool is not built for that role.

This project's position is that any authorized peer-review or confidential-evaluation use requires explicit permission from the relevant editor, venue, or policy authority; compliance with all confidentiality and disclosure rules; independent verification of every substantive claim; and disclosure of AI assistance. Some venues authorize narrow, declared uses (such as post-review language assistance) through standing policy without a separate permission step; this project is deliberately stricter than the most permissive such policies.

## License relationship

The code and instructions in this repository are released under the MIT License. The MIT License is permissive and does not impose use restrictions. This document does not modify the license. It states how the project is meant to be used and what uses the maintainer rejects.

## Responsibility

The MIT License's no-warranty and no-liability clauses apply to this repository. Users are responsible for complying with applicable confidentiality, disclosure, and research-integrity obligations. The README, this document, and the prompt-level refusal rule state the intended use of the project; they are not a substitute for the policies that apply in a particular venue or institution.
