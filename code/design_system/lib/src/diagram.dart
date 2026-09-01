/// A drawing, on its own ground.
///
/// The second site brought a mermaid sequence diagram exported to SVG, and with
/// it a constraint worth stating plainly: **an SVG loaded through `img` is a
/// sealed document.** It cannot read the page's custom properties, so it cannot
/// inherit this system's palette the way every other element does. It arrives
/// with whatever colours it was authored in — here a dark-theme export, pale
/// lavender and near-black, which on a dark page is a bright slab and in dark
/// mode is barely legible.
///
/// So this component does not pretend the drawing inherits. It gives it a
/// **light ground in both schemes**, the way a printed figure keeps its paper
/// when the book around it changes. The alternative — inlining the SVG so its
/// fills can be driven by variables — means re-authoring every diagram in this
/// system's palette, which is a real answer and a much larger one.
///
/// Recorded in the journal as an open question rather than settled here: a
/// design system that plates its diagrams has decided they are quotations, and
/// a design system that re-authors them has decided they are part of its own
/// voice. Those are different systems.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'base.dart';
import 'tokens.dart';

class Diagram extends StatelessComponent {
  const Diagram({
    required this.src,
    required this.alt,
    this.caption,
    super.key,
  });

  final String src;

  /// Required, and not nullable. A diagram carries the argument of the section
  /// it sits in; a reader who cannot see it is owed that argument in words, not
  /// an empty attribute.
  final String alt;

  final String? caption;

  @override
  Component build(BuildContext context) => figure(classes: 'diagram', [
    img(src: src, alt: alt),
    if (caption case final c?) figcaption([.text(c)]),
  ]);

  @css
  static List<StyleRule> get styles => [
    css('.diagram', [
      css('&').styles(
        padding: Padding.all(Space.step),
        margin: Margin.zero,
        border: Border.all(color: role('rule'), width: Unit.pixels(1)),
        radius: const BorderRadius.circular(Unit.pixels(4)),
        // Not `role('paper')`. The ground is deliberately fixed rather than
        // themed: the drawing on it is not themed either, and a plate that
        // followed the scheme would put a light drawing on a dark plate.
        backgroundColor: Ink.paper,
      ),
      css('img').styles(
        display: Display.block,
        width: 100.percent,
        height: Unit.auto,
      ),
      css('figcaption').styles(
        margin: Margin.only(top: Space.snug),
        color: role('muted'),
        fontSize: Type.micro,
      ),
    ]),
  ];
}
