# ADR 0002: The design language is not named yet, and the laboratory is called `design_system`

**Status:** Accepted
**Date:** 2026-08-27

## Context

This repository began from a smaller question — the project sites at
`macss.ccisne.dev` and `inquiry.ccisne.dev` do not look professional, and each
one restates the other's CSS. The first shape considered was a template
distributor with a CLI that could check for drift.

That shape dissolved once the transport was settled. With Jaspr, a site imports
components rather than copying files, so there is no copy, no drift, and nothing
for a CLI to reconcile. What remained was a component library.

And a component library, once it decides what a heading weighs and where the
rhythm breaks, **is a design system** — the same category as Material or
Cupertino, differing in scope and not in kind. It encodes a position about how
an interface should behave, and every consumer inherits that position whether or
not it was ever stated.

That is the decision this ADR defers. The name and the design language are not
two decisions; the name is the design language compressed into a word, which is
why picking the name first inverts the work.

### Why the name cannot be chosen to unblock

Three reasons, in descending order of force.

**pub.dev is permanent.** A published version cannot be withdrawn, only
retracted. A name chosen today to get moving is a name kept for the life of the
project.

**This project names by argument, and there is no argument yet.** ADR 0003 in
`skillwire` rejected four descriptive candidates before choosing a word from a
coherent vocabulary; ADR 0004 exists because one word had been made to name
three different things. Naming here has always been the conclusion of a written
case. No such case exists for this system, because the system has not been
built.

**A design language is found, not declared.** It appears in what one reaches for
repeatedly, and reaching happens in real work. Declared first, it produces a
manifesto with nothing under it.

### What is already known

The deferral is not a blank search. The hypothesis is written and has been
applied for years:

> haiku clarity, katana precision, code that reveals its purpose

with the values it serves: honesty, semantics, aesthetics, specificity, zen
minimalism, beauty.

Both halves of that motto are **formal** rather than merely evocative, which is
what makes them transferable. A haiku is not "short": it is 5-7-5, a *kigo* that
anchors it in a season, a *kireji* that cuts — a scale, an anchor and a
deliberate break. A katana is not "sharp": it is a geometry in which every curve
has a functional reason, and reads as beauty by consequence of correctness.

So the laboratory tests a stated hypothesis against a real interface. It does not
look for one.

## Decision

**The laboratory is `design_system`, and it is never published.**

- `publish_to: none` in the pubspec, so no accidental release.
- No `version` field, because a version number is a promise to someone
  downstream and there is nobody downstream.
- Consumers depend on it by `path:`.

**The system it finds will be a different package** — named, versioned, and
public from its first release. This one is scaffolding, and scaffolding is meant
to come down.

### Why a name with no personality

A provisional name that is *good* becomes the real name by habit. Called
`lattice` for three months, it would be `lattice` because it was familiar, not
because a case had been made. `design_system` cannot be grown fond of, which is
the property wanted.

It is also already taken on pub.dev — an unrelated Flutter package at 1.0.2 — so
publishing under it is impossible regardless of intent. The disposability is
structural rather than remembered.

## Consequences

**The laboratory needs a journal, not only ADRs.** An ADR records a decision
already taken. What this work produces first is observation that is not yet a
decision: a component asked to exist, a rule was broken and the break was right,
a shape recurred. `docs/journal.md` holds those, dated, and ADRs are written
*from* it once an observation repeats often enough to be a rule. Without it, in
some months there are components and no evidence for why any of them look as
they do.

**A consumer's site cannot be built in CI while this repository is private.** A
`path:` dependency needs a sibling checkout that GitHub Actions will not have.
The resolution when it bites is to make this repository public, not to add
deploy keys — but it does not bite yet, since skillwire has no site.

> **2026-08-31 — it bit, and the stated resolution was taken.** skillwire's site
> was built and needed deploying. `GITHUB_TOKEN` is scoped to the repository
> running the job, so reading this one meant a fine-grained PAT. This repository
> was made **public** instead.
>
> Nothing in the argument above required privacy — the case is entirely about
> not naming before the work is done, and a public repository names nothing.
> What privacy bought was that half-finished work stayed unseen; what it cost
> was a credential that expires on a date nobody writes down, and a deploy that
> would then fail silently. The first is a preference and the second is a defect
> waiting, so the trade was not close.
>
> `publish_to: none` is untouched and the package is still never released. A
> public repository and a published package are different things, and only the
> second would fix a name.

**Nothing here is precious.** A file in this repository may be deleted without a
migration, because nothing depends on it that cannot be rebuilt.
