# Roadmap

There are no versions here. This repository is a laboratory, and its output is
an argument — an ADR naming the design language, and a second package that
implements it. The phases below are stages of an investigation, not releases.

## Phase 1 — The pilot

Build `skillwire`'s site with Jaspr, taking every component from this package.

skillwire is the right first subject precisely because **it has no site yet**.
There is nothing to preserve, nothing to port and no existing look to be
influenced by. macss and inquiry already have sites, and rebuilding one of those
first would smuggle its current decisions in as defaults.

- [x] Jaspr app in `skillwire/code/site`, depending on this package by path
- [x] Components extracted here as the page needs them — never before
      (`Page`, `Band`, `Terminal`, `Listing`)
- [x] Journal entry each time a component is extracted, saying what asked for it
- [x] The site deployed at `skillwire.ccisne.dev`. The `path:` dependency has
      no sibling checkout on a runner, so the workflow clones both repositories
      under a common parent — and this repository was made public so that clone
      needs no credential.

## Phase 2 — The second subject

Rebuild inquiry's site from the same package.

A design language is only demonstrated by the second use. The first site
produces components; the second reveals which of them were general and which
were that page in disguise.

- [ ] Every component that needed a special case for site two, listed
- [ ] Every component that survived unchanged, listed

## Phase 3 — The argument

Write the design language down, from the journal rather than from intention.

- [ ] ADR: what this system holds, and what it refuses
- [ ] ADR: the name, argued from the one above
- [ ] Tokens stated explicitly — scale, rhythm, colour roles, motion

## Phase 4 — Birth

The named package, public from its first version.

- [ ] New repository, or this one renamed
- [ ] `design_system` deleted
- [ ] macss, inquiry and skillwire sites all on the published package
- [ ] Consumer sites depend on a version rather than a path, so a change here
      redeploys them without a manual trigger

## Not in scope

- **A CLI.** Nothing is copied, so nothing can drift, so there is nothing to
  reconcile. If that ever stops being true, it is an ADR, not a task.
- **Being general-purpose.** This serves the sites of one author. A component
  that exists for a hypothetical consumer is a guess, and guesses are what the
  journal is meant to keep out.
