# Architecture

## Shape

One package, and the documents that explain why it looks the way it does.

```
code/
  design_system/    the Jaspr component library — never published
docs/
  adr/              decisions, argued and dated
  journal.md        observations that are not yet decisions
```

The `infra` / `db` / `api` / `app` layering that `macss project create` offers
was declined and the directories deleted. This project has no data layer, no
service layer and no deployment surface; it produces a library that other
projects import. `macss project check` confirms the repository still conforms —
the starter layers are an offer, not the canon.

## What the package is

A **component library**, in the sense that Material and Cupertino are component
libraries: a set of components plus the design language they express. Not a
template distributor, and not a CLI.

That distinction was reached by elimination. A distributor copies files into a
consumer, which creates a second copy that can drift, which is what would have
justified a `sync` / `check` surface with plan and apply. With Jaspr the
consumer *imports* the components — there is no copy, so there is no drift, so
there is nothing to reconcile and no command to write.

## Dependency direction

```
consumer's site  →  design_system  →  jaspr
```

Never the reverse. The library knows nothing about any particular site, which is
the constraint that keeps it a library instead of a shared implementation of one
page.

## How consumers depend on it

By `path:`, because there is no published version to depend on:

```yaml
dependencies:
  design_system:
    path: ../../../design_system/code/design_system
```

Two consequences follow, and both are accepted for now:

- The repositories must be siblings on disk.
- A consumer's site cannot be built in CI while this repository is private,
  because the runner has no sibling checkout. Sites are built locally until the
  system is named, published and public.

## Testing

`jaspr_test` renders components and asserts on the produced markup. The
assertions worth making are the ones about **semantics** — that a control is a
`button`, that headings descend without skipping a level, that an interactive
element carries an accessible name — because those are the claims the design
language makes, and a screenshot cannot check them.

Visual correctness is not tested. It is judged, in the pilot, by looking.
