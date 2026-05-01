# Documentation Roadmap

This roadmap outlines the full lifecycle of planning, building, styling, and publishing a structured compendium of documentation

---

## Planning

**Goal:** Define the purpose, scope, and content baseline for the compendium.

**Tasks**

- [x] Define purpose and intended audience
- [x] List documents to include
- [x] Establish naming, versioning, and license guidelines
- [x] Inventory current documentation assets
- [x] Set success criteria for the project

## Structure Design

**Goal:** Build the content architecture and template system.

**Tasks**

- [x] Design folder layout (e.g., `docs/`, `covers/`, `assets/`, `compiled/`)
- [x] Draft Pandoc `template.html` and `template.pdf`
- [x] Create standard YAML metadata structure for each file
- [x] Define section ordering and TOC hierarchy
- [x] Embed custom logic for cover pages and chapter TOCs

## Document Writing

**Goal:** Create, revise, and organize source Markdown content.

**Tasks**

- [x] Draft core chapters (intro, primary guides)
- [x] Refactor older documents for clarity and format
- [x] Write or append metadata headers for each document
- [x] Add code blocks, callouts, tables, and citations where needed
- [x] Use consistent style and tone throughout
- [ ] Peer review or edit documents for technical and language quality

## Compilation

**Goal:** Convert Markdown into polished PDF, HTML, and other formats.

**Tasks**

- [x] Write Pandoc commands (CLI or Makefile)
- [x] Add per-document cover pages
- [ ] Generate document-level and master TOCs
- [ ] Validate links, image references, and footnotes
- [x] Compile multiple formats (PDF, HTML, optionally EPUB)

## Styling & Themes

**Goal:** Apply cohesive styling and interactive features.

**Tasks**

- [x] Apply EniacDark theme or other custom CSS
- [ ] Integrate Mermaid.js for live diagrams
- [x] Ensure code syntax highlighting (e.g., with Fira Code)
- [ ] Embed fonts and responsive layout rules
- [ ] Test PDF output styling for consistency
- [ ] Optimize mobile rendering of HTML version

## Publishing

**Goal:** Distribute the final compendium and make it accessible.

**Tasks**

- [ ] Organize output directory (e.g., `compiled/v1.0/`)
- [ ] Upload HTML version to GitHub Pages or internal server
- [ ] Distribute PDF via internal/external channels
- [ ] Write and include changelog or release notes
- [ ] Announce release and usage instructions
- [ ] Plan next version (v1.1+) based on feedback
