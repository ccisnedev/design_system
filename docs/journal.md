# Journal

The laboratory notebook. ADRs record decisions already taken; this records what
is not yet a decision — a component that asked to exist, a rule broken with good
reason, a shape that keeps recurring.

**Write an entry when something is noticed, not when it is concluded.** An
observation that appears three times is a candidate for an ADR. One that never
repeats was a circumstance, and knowing that is also worth having recorded.

Newest first. Every entry dated.

---

## 2026-08-27 — First pilot: skillwire's site

Four components were extracted, each because the page asked and not before:
`Page`, `Band`, `Terminal`, `Listing`. What each one taught:

**`Terminal` came first, and honesty is why.** The page claims the tool refuses
to guess. A page that *shows* the refusal is not asking to be believed, so the
transcript is the argument rather than an illustration of it. Two consequences
followed on their own: the caption is a required parameter, because a transcript
with no provenance is back to taking the author's word; and the component has no
window chrome, because three coloured circles imitate an operating system the
transcript did not come from — decoration that asserts something false is the
exact defect the system exists to avoid.

**`Listing` had to be separate from `Terminal`, and the reason is semantic.**
The two look almost identical and make different claims: a transcript says *this
happened*, a listing says *write this*. One box for both would blur a record into
a promise. This is the first time the "semantics" value produced a component
split that a purely visual reading would have merged — worth watching for again.

**A dark-mode token can satisfy its definition and still fail its job.**
`--shell-surface` was set to `#191A1E` against a `#111214` page, which is a
correct dark surface by every rule stated and read as no box at all on screen.
In light mode the terminal marks itself by inverting; after dark that move is
gone, so the separation has to be carried by luminance. Raised to `#1F2228`.

*The rule this suggests, not yet an ADR:* a role token is only defined once its
relationship to the roles around it is defined. Naming the colour is not enough.

**`.aside` was declared identically by three different sections.** Three
components emitting the same global rule is a component asking to exist. Not
extracted yet — the roadmap says the second site is what proves generality, and
one page repeating itself three times is weaker evidence than two pages agreeing.
Recorded so it is not forgotten.

**The page ships no JavaScript.** No `@client` component anywhere, so the built
`index.html` contains zero `<script>` tags and is 14 KB. Jaspr still emits a
`build/jaspr/packages/` tree of 678 KB that nothing references — a
`build_web_compilers` artifact with no entrypoint to serve. Worth excluding at
deploy time, and worth remembering as evidence that "built with a framework" and
"ships a framework" are separable.

**A screenshot showed a large empty region that does not exist.** Measuring the
document instead — every element's top and height — showed a continuous page with
no gap larger than the intended `6.2rem` between bands. Second time this exact
false alarm has happened. *Measure the DOM; do not read layout off an image.*

## 2026-08-27 — The hypothesis, before any code

Stated so it can be contradicted later by evidence rather than by memory.

> haiku clarity, katana precision, code that reveals its purpose

Values: honesty, semantics, aesthetics, specificity, zen minimalism, beauty.

What has to be discovered is what each of these *does* to an interface. Some
first readings, all of them provisional:

- **Honesty** — do not render a state that cannot be backed. No progress bar
  that does not track progress. No skeleton screen implying content that may not
  arrive.
- **Semantics** — the element is chosen for what it means, not for how it
  renders. Styling follows from meaning; there is no `<div>` doing a button's
  job.
- **Specificity** — nothing implicit. No default that was never chosen. This is
  already the rule in `skillwire` (no default host, no default scope) and it has
  an interface equivalent worth finding.
- **Haiku form** — 5-7-5 is a scale, the *kigo* an anchor, the *kireji* a
  deliberate break. A type scale, a constant, and a rule about where rhythm is
  allowed to stop.
- **Katana** — every curve has a functional reason and the beauty is a
  consequence. A component whose visual decision cannot be given a reason is not
  finished.

None of this is settled. It is the starting position, written down so that the
first real site can disagree with it.

## 2026-08-27 — The laboratory exists

Scaffolded with `macss project create --lang en`, then the four starter layers
(`code/{infra,db,api,app}`) were deleted. `macss project check` still reports
conformance, which is what the canon promises: the layers are an offer, not a
requirement.

Two things surfaced while doing it, both recorded because they are evidence
about the tools rather than about the design language:

- **`dart pub publish --dry-run` does not exercise `publish_to: none`.** It
  resolved against pub.dev and validated the archive as if publishing were
  intended. The guard may still fire on a real publish; that was not tested,
  because testing it means attempting one. The name being taken by an unrelated
  package is the guarantee that actually holds.
- **macss 0.12.0 stamps a dead URL.** The generated `README.md` links to
  `macss.dev`, which does not resolve. The fix is on `main` (commit `3e55b17`)
  but landed after the `v0.12.0` tag, so every project created with the
  currently installed CLI carries the dead link.
