# design_system

> Created with [MACSS](https://macss.ccisne.dev) — Modular Architecture for Comprehensive Software Solutions.

**A laboratory, not a product.** It exists to discover a design language by
building with one, and its name is deliberately generic because naming the
system is the *outcome* of this work rather than its premise.

See [ADR 0002](docs/adr/0002-the-design-language-is-not-named-yet.md) for the
argument, and [the journal](docs/journal.md) for what has been observed.

## The hypothesis under test

> haiku clarity, katana precision, code that reveals its purpose

Honesty, semantics, aesthetics, specificity, zen minimalism, beauty. What has to
be found is what each of those *does* to an interface.

## Structure

```
code/
  design_system/    the Jaspr component library — never published
docs/
  adr/              decisions, argued and dated
  journal.md        observations that are not yet decisions
  architecture.md   the shape, and why it has no CLI
  roadmap.md        the stages of the investigation
```

## Status

Phase 1. The library is empty; the first components arrive from skillwire's
site, which is the pilot.

## Nothing here is published

`code/design_system` carries `publish_to: none` and has no version, because a
version number is a promise to someone downstream and there is nobody
downstream. The system this laboratory finds will be a different package —
named, and public from its first release.
