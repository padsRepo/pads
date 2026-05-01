# Book Structure

This book is organized as a modular compendium with clearly defined sections, designed to serve both as a reference manual and a learning tool. Each part serves a different audience and purpose, whether you're a developer, business analyst, or systems engineer.

## 00-front

These chapters introduce the core ideas, goals, and context.

- `00-preface.md` — Why this book exists and who it’s for.
- `00-how-to-use.md` — How to navigate and use the book effectively.
- `01-introduction.md` — Core concepts, background, and architecture.

## 10-docs

A technical deep dive into systems, tools, and libraries used in this project.

- `docs/bash-reference.md` — Key shell scripts and utilities
- `docs/python-reference.md` — Module structure and function docs
- `docs/pandoc-config.md` — Build toolchain and automation

## 11-manual

User-facing documentation formatted like Unix `man` pages.

- `manuals/bash-utils.1.md`
- `manuals/build.1.md`
- `manuals/makefile.1.md`

## 12-business

A multi-entity structure for modeling business strategy, documents, and IP.

- `business/<entity>/plan.md` — Business model and goals
- `business/<entity>/roadmap.md` — Timeline and deliverables
- `business/<entity>/contracts.md` — Legal or licensing templates

## 18-tutorials

Hands-on guides to building and deploying systems or learning tools.

- `tutorials/01-getting-started.md` — Setup and tooling
- `tutorials/02-basic-workflows.md` — Common tasks in Bash and Python
- `tutorials/03-deployment.md` — Sample deployment pipelines

## 19-blog

In-depth or standalone reports, whitepapers, or structured documentation sets.

- `manuscript/devops-handbook/index.md`
- `manuscript/automation-manual/index.md`
- `manuscript/tooling-playbook/index.md`

## 20-back

Additional materials and supporting documents.

- `appendices/metadata.yaml` — Book-level metadata for Pandoc
- `appendices/licenses.md` — Licensing for code and documentation
- `appendices/credits.md` — Acknowledgments and contributors

This modular format makes it easy to build, remix, and distribute the content as:

- A printed book (PDF)
- A documentation site (HTML)
- A CLI manual or Markdown repo

For build instructions, see `paddocs`.
