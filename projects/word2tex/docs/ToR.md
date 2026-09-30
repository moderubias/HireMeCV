# Terms of Reference
## High-Fidelity Reconstruction of a Technical Thesis from DOCX to LaTeX

**Project:** `word-conv-tex`  
**Source document:** `thesis_draft.docx`  
**Primary source format:** Microsoft Word / OOXML (`.docx`)  
**Target authoring format:** semantic LaTeX  
**Primary TeX engine:** LuaLaTeX  
**Build system:** `latexmk` + GNU Make  
**Bibliography backend:** Biber  
**Primary deliverable:** publication-quality PDF  
**Project status:** portfolio-grade technical reconstruction

---

# 1. Project Objective

The objective of this project is to reconstruct the supplied technical thesis from Microsoft Word into a maintainable, semantically structured, reproducible LaTeX project while preserving the scholarly content and substantially improving the document's technical quality, consistency, typography, navigation, reproducibility, and verifiability.

This is not a mechanical DOCX-to-LaTeX export.

The finished work must demonstrate competence in:

- technical and mathematical typesetting;
- semantic document reconstruction;
- advanced LaTeX architecture;
- equation reconstruction;
- bibliography engineering;
- figure and table handling;
- cross-reference management;
- typography;
- OOXML source analysis;
- automated build tooling;
- PDF quality assurance;
- scripting;
- reproducible builds;
- source-to-output traceability;
- version-controlled publishing workflows.

The result shall be suitable for inclusion in a professional LaTeX/typesetting portfolio.

---

# 2. Core Principle

The conversion shall prioritize:

1. semantic correctness;
2. mathematical correctness;
3. source fidelity;
4. maintainability;
5. typographic quality;
6. reproducibility;
7. automated verification.

Visual similarity to the original Word document is secondary where the original formatting conflicts with good technical publishing practice.

The LaTeX source must represent the logical structure of the document rather than imitate Word formatting commands.

The following are prohibited:

- line-by-line manual visual imitation of Word;
- arbitrary `\vspace` or `\hspace` used to force page layout;
- manual equation numbers;
- manual section numbers;
- manually typed table-of-contents entries;
- hard-coded figure numbers;
- hard-coded page references;
- rasterization of mathematical expressions;
- bibliography entries stored as formatted plain text;
- absolute filesystem paths;
- silent changes to technical content;
- silent deletion of problematic source material.

---

# 3. Source Document Characteristics

The source document is a technical thesis concerning modeling, optimization, and control of energy-efficient buildings.

It contains, among other material:

- three-dimensional heat-equation modeling;
- finite element formulations;
- boundary conditions;
- weak formulations;
- state-space models;
- high-dimensional systems;
- optimal sensor placement;
- Linear Quadratic Regulator control;
- Proper Orthogonal Decomposition;
- reduced-order modeling;
- stochastic control;
- Receding Horizon Control;
- semidefinite / convex optimization concepts;
- numerous numbered equations;
- figures and simulation plots;
- cross-references;
- multi-level headings;
- bibliography entries of inconsistent quality;
- source-document inconsistencies requiring explicit treatment.

The mathematical content must therefore be treated as scientific material, not ordinary prose.

---

# 4. Editorial Policy

## 4.1 Source fidelity

No substantive scientific statement may be silently changed.

Every discrepancy discovered during reconstruction must be classified as one of:

- formatting defect;
- typographic defect;
- grammatical defect;
- bibliographic defect;
- numbering defect;
- mathematical ambiguity;
- source inconsistency;
- probable source error;
- unresolved issue.

Substantive scientific corrections are outside the scope of automatic normalization.

Where a likely scientific or mathematical error is detected:

1. preserve the source meaning in the primary reconstruction unless correction is unambiguous;
2. record the issue;
3. document any correction explicitly.

---

## 4.2 Change log

Create:

```text
docs/conversion-notes.md
```

or an equivalent project-local document containing significant deviations from the source.

Each meaningful intervention should contain:

- source location;
- original form;
- reconstructed form;
- category;
- rationale;
- confidence where applicable.

Example:

```text
Source: Chapter 3, equation reference following POD discussion
Issue: figure/equation numbering collision
Category: numbering defect
Action: normalized through semantic LaTeX counters and labels
Scientific content changed: no
```

---

# 5. Applicable Publishing Standards

The document shall use the following standards as design constraints where applicable.

## 5.1 Thesis structure

Use the principles of:

- ISO 7144 — presentation of theses and similar documents;
- ISO 2145 — numbering of divisions and subdivisions in written documents.

The exact visual appearance does not need to imitate a particular university template unless explicitly required.

The structure must nevertheless follow professional scholarly-document conventions.

---

## 5.2 Bibliographic normalization

Bibliographic records shall be normalized according to the principles of ISO 690.

Internally, bibliography data must be represented semantically in BibLaTeX/Biber-compatible `.bib` records.

Presentation style may use a numeric engineering/scientific citation scheme.

---

## 5.3 Archival output

A release build should target archival-quality PDF where technically feasible.

Preferred archival target:

```text
PDF/A-2u
```

If strict PDF/A conformance is not yet achieved, the build must not falsely claim compliance.

Validation status shall be explicitly reported.

---

# 6. Repository Architecture

Expected high-level organization:

```text
projects/word-conv-tex/
├── .latexmkrc
├── main.tex
├── thesis_draft.docx
├── ToR.md
├── assets/
├── sections/
├── build_files/
└── output/

shared/
├── assets/
├── bibliography/
├── classes/
├── styles/
└── scripts/
```

The project must maintain a strict separation between:

```text
source
build artifacts
release artifacts
shared reusable infrastructure
```

---

# 7. LaTeX Source Architecture

`main.tex` must remain an orchestration layer rather than contain the complete thesis.

Preferred organization:

```text
main.tex

sections/
├── frontmatter/
│   ├── abstract.tex
│   └── ...
├── chapter01.tex
├── chapter02.tex
├── chapter03.tex
├── chapter04.tex
├── chapter05.tex
├── conclusion.tex
└── appendices/
```

A large monolithic source file should be avoided.

---

# 8. Semantic Markup Requirements

LaTeX source must express document semantics.

Use proper structural commands:

```latex
\chapter
\section
\subsection
\paragraph
```

Use appropriate environments for:

```latex
equation
align
gather
cases
matrix
figure
table
enumerate
itemize
description
```

Do not use arbitrary formatting constructs where a semantic environment exists.

---

# 9. Mathematical Reconstruction

Mathematical reconstruction is a critical acceptance area.

Every equation shall be reconstructed as native LaTeX mathematics.

The following are prohibited:

- screenshots of formulas;
- pasted equation images;
- equations rendered as plain Unicode text where structured mathematics is appropriate;
- manually entered equation numbers.

---

## 9.1 Equation numbering

Equation numbering must use LaTeX counters.

Example:

```latex
\begin{equation}
    ...
    \label{eq:heat-equation}
\end{equation}
```

References must use semantic cross-references:

```latex
\cref{eq:heat-equation}
```

or equivalent.

No text such as:

```text
see equation (2.9)
```

may depend on manually typed numbering.

---

## 9.2 Mathematical notation

Notation shall be normalized consistently for:

- vectors;
- matrices;
- scalar quantities;
- differential operators;
- domains;
- boundaries;
- norms;
- expectations;
- probability;
- transpose operators;
- state vectors;
- control vectors;
- disturbances;
- physical units.

Examples of distinctions that must remain semantically visible:

```latex
x
\mathbf{x}
A
\mathbf{A}
\Omega
\partial\Omega
\nabla
\operatorname{diag}
\mathbb{E}
```

---

## 9.3 Operators

Named mathematical operators shall not be manually italicized.

Use proper operator declarations where necessary.

Examples:

```latex
\operatorname{diag}
\operatorname{rank}
\operatorname{span}
```

---

# 10. Physical Quantities and Units

Physical quantities and units shall use consistent scientific typography.

Preferred implementation:

```latex
siunitx
```

Avoid ad-hoc forms such as:

```text
40 F
70F
10min
```

where the intended unit is known.

Units, numbers, spacing, and symbols shall be represented consistently.

Source ambiguities must be documented rather than guessed.

---

# 11. Figures

All figures embedded in the DOCX must be independently inspected.

Where possible:

- extract original embedded assets from the OOXML package;
- retain original resolution;
- preserve vector graphics where available;
- avoid screenshots;
- avoid unnecessary recompression;
- remove Word-specific wrappers.

---

## 11.1 Figure structure

Each figure must use:

```latex
\begin{figure}
    ...
    \caption{...}
    \label{fig:...}
\end{figure}
```

Every figure referenced from prose must use semantic references.

---

## 11.2 Figure quality

Verify:

- readability at 100% zoom;
- readable axis labels;
- readable legends;
- no accidental cropping;
- no stretching;
- correct aspect ratio;
- consistent caption formatting;
- consistent placement policy.

---

## 11.3 Figure numbering

All figure numbering must be generated automatically.

Inconsistencies in the source numbering shall be corrected structurally and recorded where material.

---

# 12. Tables

Every source table shall be reconstructed as an actual LaTeX table.

Preferred tools where appropriate:

```text
booktabs
tabularx
array
siunitx
longtable
```

Avoid:

- vertical rule abuse;
- screenshots of tables;
- manually aligned spaces;
- embedded Word-table images.

Tables spanning pages must use an appropriate multi-page mechanism.

---

# 13. Bibliography Engineering

The Word bibliography must be reconstructed into semantic BibLaTeX records.

Target location:

```text
shared/bibliography/
```

or a project-specific bibliography if entries are not reusable.

---

## 13.1 Required normalization

For every bibliographic item:

- identify document type;
- normalize author names;
- normalize capitalization;
- normalize title;
- normalize publication venue;
- normalize year;
- normalize volume / issue where available;
- normalize pages;
- normalize publisher;
- preserve ISBN where relevant;
- add DOI where confidently identified;
- normalize URLs;
- record access dates where appropriate.

---

## 13.2 Duplicate detection

Potential duplicate records must be detected and resolved.

Duplicate references must not survive merely because they have different source numbering.

Scientific citation semantics must nevertheless remain unchanged.

---

## 13.3 Weak source references

Entries consisting only of material such as:

```text
comsol.com
mcquade.pdf
raw URLs
```

must be investigated.

If sufficient bibliographic metadata cannot be recovered, retain the reference honestly and mark the deficiency in the conversion notes.

Do not fabricate metadata.

---

# 14. Cross-References

All internal references must be semantic.

Use labels such as:

```text
chap:
sec:
subsec:
eq:
fig:
tab:
alg:
app:
```

Examples:

```latex
\label{chap:model-reduction}
\label{sec:finite-element}
\label{eq:weak-form}
\label{fig:temperature-40min}
```

Hard-coded references are prohibited.

---

# 15. Contents and Document Navigation

The final document shall automatically generate appropriate navigational structures.

At minimum:

- table of contents;
- list of figures;
- list of tables where applicable;
- PDF bookmarks.

Bookmarks must reflect the actual document hierarchy.

No duplicate or malformed bookmark entries are acceptable.

---

# 16. Hyperlinks

Use a controlled hyperlink configuration.

Requirements:

- internal references must be clickable;
- DOI links must be clickable where present;
- URL references must be clickable;
- PDF outline navigation must work;
- visual hyperlink styling must remain appropriate for a formal thesis.

Printed output shall not depend on visible hyperlink colors.

---

# 17. Typography

Typography must be internally coherent.

The project shall define explicit choices for:

- body font;
- mathematical font;
- monospaced font where needed;
- heading hierarchy;
- paragraph spacing;
- indentation;
- line spacing;
- caption typography;
- footnotes;
- page geometry;
- header/footer behavior.

Font selection must support all symbols used by the thesis.

---

# 18. Microtypography

Use microtypographic improvements where compatible with the selected engine and fonts.

Expected:

```latex
microtype
```

or equivalent functionality.

The final PDF shall avoid obvious:

- bad spacing;
- protruding lines;
- excessive rivers;
- badly stretched paragraphs;
- poor line breaking.

---

# 19. Page Geometry

The project shall use a consistent professional thesis page geometry.

The geometry must be declared explicitly rather than inherited accidentally from defaults.

The release document must use a consistent page size.

Preferred:

```text
A4
```

unless another source requirement is established.

---

# 20. Widows, Orphans, and Page-Break Quality

The final document shall be visually inspected for:

- widows;
- orphans;
- isolated headings;
- equations separated from explanatory text;
- captions separated from figures;
- excessive blank areas;
- inappropriate float placement.

Automated layout shall be preferred over local manual spacing hacks.

---

# 21. Source Anomalies

The source contains structural and editorial inconsistencies.

Examples may include:

- chapter/section numbering inconsistencies;
- figure-number collisions;
- manuscript fragments;
- incomplete prose;
- placeholder text;
- duplicated bibliography records;
- malformed bibliography numbering;
- inconsistent terminology;
- inconsistent capitalization;
- inconsistent equation references.

These shall not be hidden.

They shall be either:

1. normalized without changing scientific meaning; or
2. documented as unresolved source issues.

---

# 22. TODO and Manuscript Artifacts

Editorial remnants such as explicit author TODOs must be detected.

They may not silently disappear.

Each such artifact must be either:

- intentionally preserved;
- resolved through an explicitly documented editorial decision;
- flagged in `conversion-notes.md`.

---

# 23. Build System

The project must build through a documented command.

Required interface:

```bash
make word
```

or an equivalently clear project target.

The build shall use:

```text
latexmk
```

rather than a manually scripted sequence of repeated TeX invocations.

---

# 24. Build Directory Isolation

All transient compilation artifacts must be confined to:

```text
build_files/
```

Examples include:

```text
.aux
.bcf
.bbl
.blg
.fdb_latexmk
.fls
.log
.out
.run.xml
.synctex.gz
.toc
.lof
.lot
```

Transient files shall not pollute the source directory.

---

# 25. Release Directory

`output/` shall contain only intentional deliverables.

It must not be used as an auxiliary build directory.

Minimum release artifact:

```text
output/converted-thesis.pdf
```

Recommended additional release artifacts:

```text
output/converted-thesis.pdf.sha256
output/validation-report.txt
output/build-report.json
```

---

# 26. Build Reproducibility

The document must compile from a clean checkout without requiring manual file movement or undocumented local state.

The build must not depend on:

- absolute paths;
- editor-specific state;
- temporary personal files;
- files outside the repository;
- undocumented fonts;
- manual bibliography compilation;
- manual copying of figures.

---

# 27. `latexmk` Configuration

Project-specific build behavior shall be declared in:

```text
.latexmkrc
```

This file shall configure at minimum:

- output directory;
- auxiliary directory;
- selected TeX engine;
- search paths where needed.

NVim configuration must not be the sole source of build behavior.

The project must compile correctly outside NVim.

---

# 28. Editor Independence

The following must produce equivalent results:

```bash
make word
```

and compilation initiated through VimTeX/latexmk.

Neovim is a development environment, not a build dependency.

---

# 29. Automated Validation

The repository shall contain an automated validator:

```text
shared/scripts/validate_pdf.py
```

The validation command shall be exposed through Make:

```bash
make validate-word
```

A failed validation must result in a non-zero exit status.

---

# 30. Mandatory PDF Validation

Automated validation shall check at minimum:

- PDF exists;
- PDF is non-empty;
- PDF parser accepts the document;
- page count is non-zero;
- expected page size;
- all fonts embedded;
- no Type 3 fonts;
- no undefined references;
- no undefined citations;
- no fatal TeX errors;
- no emergency stops;
- no missing files;
- no corrupted PDF structure.

---

# 31. LaTeX Log Validation

The build shall fail on critical log conditions including:

```text
LaTeX Error
Undefined control sequence
Emergency stop
Fatal error
Reference ... undefined
Citation ... undefined
There were undefined references
```

The validator should distinguish:

```text
ERROR
WARNING
INFO
```

rather than treating all log output identically.

---

# 32. Overfull Box Policy

Overfull boxes shall be detected automatically.

Target:

```text
0 significant overfull boxes
```

A configurable tolerance may be used for sub-point numerical noise.

Significant overfull boxes must fail the release-validation stage.

---

# 33. Underfull Box Policy

Underfull boxes shall be reported.

They do not necessarily fail the build automatically, but severe cases must be reviewed manually.

---

# 34. Font Validation

Every font in the final PDF must be embedded.

Target:

```text
embedded fonts: 100%
Type 3 fonts: 0
```

The validation report must identify violating font names if this condition fails.

---

# 35. PDF Structural Validation

Where installed, use an independent PDF checker such as:

```text
qpdf --check
```

A structurally invalid PDF cannot pass validation.

---

# 36. Archival Validation

If the release is declared PDF/A compliant, conformance must be checked with an independent validator such as veraPDF.

A document may only be labelled:

```text
PDF/A-2u compliant
```

after automated validation succeeds.

Claiming unverified conformance is prohibited.

---

# 37. Metadata

The release PDF shall contain meaningful metadata.

At minimum:

- title;
- subject;
- keywords where justified;
- document language.

Author metadata shall reflect the actual source document and must not imply authorship by the person performing the conversion.

The converter must not claim authorship of the thesis.

Portfolio attribution must distinguish:

```text
Original scholarly content: original thesis author(s)
LaTeX reconstruction/typesetting: portfolio author
```

---

# 38. Accessibility

The document should support:

- Unicode text extraction;
- meaningful bookmarks;
- logical reading order where practicable;
- text-searchable content;
- actual text rather than rasterized formulas.

Accessibility improvements shall not compromise scientific correctness.

Full PDF/UA compliance may be treated as an advanced release target and must only be claimed after independent validation.

---

# 39. Text Extraction Quality

The release PDF must allow meaningful text extraction.

Tests shall confirm that:

- ordinary prose can be copied;
- mathematical symbols are not systematically corrupted;
- ligatures do not destroy searchability;
- Unicode mapping exists where expected.

---

# 40. Searchability

Important technical terms must remain searchable in the generated PDF.

Examples include:

```text
Proper Orthogonal Decomposition
Linear Quadratic Regulator
Finite Element Method
Receding Horizon Control
Semidefinite Programming
```

---

# 41. Source-to-Output Traceability

The reconstruction should make it possible to determine where major source components ended up.

Recommended artifact:

```text
docs/source-map.md
```

Example:

```text
Word heading "Stochastic Linear Quadratic Control..."
    -> sections/chapter05.tex

Word Figure 3.2
    -> assets/figures/step-response-setpoints.*
    -> \label{fig:step-response-setpoints}
```

This is especially valuable for complex conversions.

---

# 42. Asset Naming Convention

Extracted assets must receive meaningful stable names.

Avoid names such as:

```text
image1.png
image2.png
image17.jpeg
```

Prefer:

```text
room-fem-mesh.png
temperature-after-20min.png
pod-full-order-40min.png
lqr-control-input.png
```

Where the original asset identity is uncertain, record the mapping.

---

# 43. Code Quality

LaTeX source shall follow consistent formatting.

Requirements:

- consistent indentation;
- one convention for labels;
- one convention for filenames;
- one convention for macros;
- minimal duplication;
- no dead macros;
- no commented-out abandoned implementations in release code;
- no unexplained magic dimensions.

---

# 44. Macro Design

Frequently repeated semantic constructs may use custom macros.

Macros should represent meaning rather than save arbitrary keystrokes.

Good:

```latex
\newcommand{\statevec}{\mathbf{x}}
```

Potentially bad:

```latex
\newcommand{\x}{...large arbitrary formatting sequence...}
```

Avoid unnecessary abstraction.

---

# 45. Package Discipline

Every package must have a reason to exist.

The project should avoid:

- redundant packages;
- obsolete packages where modern replacements exist;
- package conflicts;
- loading large packages for one trivial command.

Package purpose should remain understandable from the project architecture.

---

# 46. Warnings Policy

The final release build should aim for:

```text
LaTeX errors:                  0
undefined references:          0
undefined citations:           0
missing files:                 0
significant overfull boxes:    0
non-embedded fonts:            0
Type 3 fonts:                  0
PDF structural errors:         0
```

Non-critical warnings must be reviewed rather than ignored automatically.

---

# 47. Clean Build Test

The following sequence must succeed:

```bash
make clean-word
make word
make validate-word
```

The resulting PDF must not depend on stale auxiliary files.

---

# 48. Idempotence

Two consecutive clean builds from the same source revision should produce semantically equivalent documents.

Where byte-for-byte reproducibility is feasible, it should be pursued.

Differences caused only by timestamps or metadata should be identified.

---

# 49. Release Command

Recommended target:

```bash
make release-word
```

Expected pipeline:

```text
clean
  ↓
build
  ↓
bibliography
  ↓
rebuild until stable
  ↓
validate TeX log
  ↓
validate PDF
  ↓
validate fonts
  ↓
validate archival status
  ↓
generate checksums
  ↓
emit release artifacts
```

The pipeline must stop immediately on a mandatory validation failure.

---

# 50. Validation Report

A successful release should generate a human-readable report similar to:

```text
PDF Quality Report
────────────────────────────────────────
Document          converted-thesis.pdf
Build             PASS
Pages             XX
Page size         A4
PDF version       X.X
Fonts             XX
Fonts embedded    XX/XX
Type 3 fonts      0
Undefined refs    0
Undefined cites   0
LaTeX errors      0
Overfull boxes    0
PDF integrity     PASS
PDF/A             PASS / NOT CLAIMED
────────────────────────────────────────
RESULT             PASS
```

---

# 51. Machine-Readable Validation

Recommended additional output:

```text
output/build-report.json
```

Example structure:

```json
{
  "status": "pass",
  "pages": 0,
  "undefined_references": 0,
  "undefined_citations": 0,
  "overfull_boxes": 0,
  "type3_fonts": 0,
  "fonts_embedded": true,
  "pdf_integrity": true
}
```

This enables later CI integration.

---

# 52. Version Control Hygiene

Generated transient build files shall not be committed.

The repository must include an appropriate `.gitignore`.

Source files, configuration, scripts, documentation, and intentional release artifacts may be committed according to repository policy.

---

# 53. Continuous Integration

An advanced acceptance target is an automated CI workflow that:

1. checks out the repository;
2. installs the required TeX environment;
3. builds the project;
4. runs validation;
5. fails on QA violations;
6. optionally publishes the validated PDF as a build artifact.

The local build must remain authoritative and independently usable.

CI must not compensate for a broken local workflow.

---

# 54. Documentation

The project README shall explain:

- project purpose;
- source document provenance;
- conversion scope;
- toolchain;
- build command;
- validation command;
- directory structure;
- major engineering decisions;
- limitations;
- attribution.

A reviewer should be able to build the document without asking the author for undocumented instructions.

---

# 55. Portfolio Presentation

The portfolio description shall not merely state:

> Converted a Word document to LaTeX.

Preferred framing:

> Reconstructed a technically complex engineering thesis from DOCX/OOXML into a semantic LuaLaTeX publishing project, including native mathematical reconstruction, normalized bibliography, automated cross-references, reusable document infrastructure, isolated build artifacts, and automated PDF/font/log validation.

The repository itself must substantiate this claim.

---

# 56. Evidence of Work

The final project should expose evidence of engineering work without requiring a reviewer to inspect every commit.

Recommended evidence:

```text
README.md
ToR.md
docs/conversion-notes.md
docs/source-map.md
shared/scripts/validate_pdf.py
.latexmkrc
Makefile
semantic .tex sources
normalized .bib database
final validated PDF
```

Optional:

```text
docs/before-after.md
```

with a small number of representative source/output comparisons.

---

# 57. Before/After Demonstration

Select several representative difficult cases for portfolio presentation.

Candidates:

1. multi-line PDE / weak-form equation;
2. boundary-condition system;
3. state-space equation;
4. POD derivation;
5. figure with scientific caption;
6. malformed bibliography entry;
7. cross-reference inconsistency;
8. multi-level section hierarchy.

For each example document:

```text
Original DOCX representation
Problem
Reconstruction strategy
Result
```

Avoid filling the repository with decorative screenshots.

---

# 58. Performance

The project does not require extreme build-performance optimization.

Nevertheless:

- avoid unnecessary full-project rebuilds;
- keep build configuration deterministic;
- allow individual project builds;
- avoid shell pipelines that silently swallow errors.

---

# 59. Security and Portability

Scripts must:

- avoid destructive operations outside project directories;
- quote filesystem paths safely;
- avoid assumptions about the user's home directory;
- fail clearly when required external tools are missing.

No validator or build command may recursively delete an uncontrolled path.

---

# 60. Error Handling

Build and validation scripts must fail loudly.

Bad:

```text
command fails
pipeline continues
old PDF remains in output/
release appears successful
```

Required:

```text
command fails
release target exits non-zero
invalid output is not presented as a successful release
```

---

# 61. Release Artifact Integrity

The release pipeline should generate a SHA-256 checksum.

Example:

```text
converted-thesis.pdf
converted-thesis.pdf.sha256
```

This demonstrates that the released artifact is explicitly defined and verifiable.

---

# 62. Definition of Done

The project is complete only when all mandatory requirements below are satisfied.

## Source

- [ ] Complete thesis content reconstructed.
- [ ] No meaningful section silently omitted.
- [ ] Mathematical expressions reconstructed as native LaTeX.
- [ ] Figures extracted and mapped.
- [ ] Tables reconstructed.
- [ ] Bibliography converted to semantic records.
- [ ] Source anomalies documented.

## Structure

- [ ] Semantic section hierarchy.
- [ ] Automatic table of contents.
- [ ] Automatic list of figures.
- [ ] Automatic list of tables where applicable.
- [ ] Automatic equation numbering.
- [ ] Automatic figure numbering.
- [ ] Automatic table numbering.
- [ ] Semantic cross-references.

## Mathematics

- [ ] Mathematical notation reviewed manually.
- [ ] Equation references resolve.
- [ ] No raster equations.
- [ ] No manually typed equation numbers.

## Bibliography

- [ ] All cited records resolve.
- [ ] No undefined citations.
- [ ] Duplicate records investigated.
- [ ] Bibliographic inconsistencies documented.
- [ ] No invented metadata.

## Typography

- [ ] Consistent fonts.
- [ ] Consistent page geometry.
- [ ] Consistent captions.
- [ ] Consistent heading hierarchy.
- [ ] Significant widows/orphans reviewed.
- [ ] No significant overfull boxes.

## Build

- [ ] Clean build works.
- [ ] Build files isolated.
- [ ] Project builds outside NVim.
- [ ] `make word` succeeds.
- [ ] `make validate-word` succeeds.
- [ ] `make clean-word` succeeds.

## PDF QA

- [ ] Valid PDF structure.
- [ ] Non-zero pages.
- [ ] Correct page size.
- [ ] 100% fonts embedded.
- [ ] Zero Type 3 fonts.
- [ ] Zero undefined references.
- [ ] Zero undefined citations.
- [ ] Zero fatal LaTeX errors.
- [ ] Zero significant overfull boxes.

## Documentation

- [ ] README complete.
- [ ] ToR complete.
- [ ] Conversion notes complete.
- [ ] Source mapping documented.
- [ ] Build instructions tested.
- [ ] Attribution explicit.

## Release

- [ ] Final PDF generated through build pipeline.
- [ ] Validation report generated.
- [ ] Checksum generated.
- [ ] No stale artifact presented as a new release.
- [ ] Declared standards are actually validated.

---

# 63. Advanced Completion Criteria

The following are desirable portfolio differentiators but must not be falsely claimed if unfinished:

- [ ] independently validated PDF/A-2u output;
- [ ] tagged accessible PDF;
- [ ] machine-readable JSON QA report;
- [ ] CI build and validation;
- [ ] reproducible release build;
- [ ] automated bibliography sanity checking;
- [ ] automated duplicate-reference detection;
- [ ] source-to-output mapping;
- [ ] representative before/after case study.

---

# 64. Final Quality Bar

The final deliverable should satisfy the following review scenario:

A technically competent reviewer should be able to:

1. clone the repository;
2. inspect its organization;
3. understand the publishing architecture;
4. run one documented build command;
5. reproduce the PDF;
6. run one documented validation command;
7. inspect a machine- and human-readable QA result;
8. inspect mathematically complex LaTeX source;
9. inspect bibliography reconstruction;
10. inspect evidence of difficult conversion decisions;
11. distinguish original scholarly authorship from reconstruction work;
12. conclude from the repository itself that the work involved substantially more engineering than an automated DOCX export.

