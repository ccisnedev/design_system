/// The top of a page: what this is, in one line, before anything else.
///
/// Extracted on the second site rather than the first. skillwire's was written
/// bespoke, and macss then wanted the same three things in the same order — a
/// name, one line saying what it is, and whatever that particular project has
/// to add. One page wanting a shape is a page; two wanting it is a component.
///
/// [children] is deliberately open. What follows the tagline is where the two
/// sites genuinely differ — skillwire states what ships, macss states what the
/// methodology is for — and a component that tried to name those slots would be
/// describing two pages rather than a shape.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'base.dart';
import 'tokens.dart';

class Masthead extends StatelessComponent {
  const Masthead({
    required this.name,
    required this.tagline,
    this.children = const [],
    super.key,
  });

  /// The `h1`. One per page, and this is it.
  final String name;

  /// One line. If it needs two sentences it is not a tagline, and the second
  /// belongs in [children] where it can be read as prose.
  final String tagline;

  final List<Component> children;

  @override
  Component build(BuildContext context) => header(classes: 'masthead', [
    h1([.text(name)]),
    p(classes: 'tagline', [.text(tagline)]),
    ...children,
  ]);

  @css
  static List<StyleRule> get styles => [
    css('.masthead', [
      css('.tagline').styles(
        margin: Margin.only(top: Space.step),
        color: role('ink'),
        fontSize: Type.lead,
      ),
      css('p:not(.tagline)').styles(margin: Margin.only(top: Space.step)),
    ]),
  ];
}
