# `design_system`

A Jaspr component library, and the laboratory in which a design language is
discovered.

**It is never published.** The name is deliberately generic and belongs to an
unrelated package on pub.dev anyway; `publish_to: none` states the intent and
the taken name enforces it. The system this laboratory finds will be born as a
different package — named, and public from its first version.

## Status

Empty. The first components arrive from skillwire's site, which is the pilot.

## Use

Consumers depend on it by path, since there is nothing to depend on by version:

```yaml
dependencies:
  design_system:
    path: ../../../design_system/code/design_system
```

That requires the two repositories to be siblings on disk, and it is why a
consumer's site cannot be built in CI while this repository is private.
