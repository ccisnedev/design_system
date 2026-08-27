/// Where things sit, and how far apart.
///
/// Extracted while building skillwire's site: five sections wanted the same
/// vertical rhythm and the same measure, and five copies of that decision are
/// five chances for it to drift. The rhythm *is* the design language here — a
/// component that only holds spacing is still holding an argument.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'base.dart';
import 'tokens.dart';

/// The column everything sits in.
///
/// One width for the whole page rather than a per-section choice: a page whose
/// left edge moves as the reader scrolls is asking them to re-find it each
/// time.
class Page extends StatelessComponent {
  const Page({required this.children, super.key});

  final List<Component> children;

  @override
  Component build(BuildContext context) => div(classes: 'page', children);

  @css
  static List<StyleRule> get styles => [
    css('.page').styles(
      maxWidth: pageWidth,
      margin: Margin.symmetric(horizontal: Unit.auto),
      padding: Padding.symmetric(vertical: Space.leap, horizontal: Space.step),
    ),
  ];
}

/// A titled division of the page.
///
/// The heading is required and is an `h2`, because a section that cannot be
/// named is not a section. There is no eyebrow, no kicker and no icon: each
/// would be a second thing competing to be read first, and the reader only has
/// one first.
class Band extends StatelessComponent {
  const Band({required this.heading, required this.children, super.key});

  final String heading;
  final List<Component> children;

  @override
  Component build(BuildContext context) => section(classes: 'band', [
    h2([.text(heading)]),
    div(classes: 'band-body', children),
  ]);

  @css
  static List<StyleRule> get styles => [
    css('.band', [
      // The cut. Space above a heading is what tells a reader the previous
      // thought ended, and it does that job better than a rule does.
      css('&').styles(margin: Margin.only(top: Space.chasm)),
      css('.band-body').styles(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        gap: Gap(row: Space.step),
        margin: Margin.only(top: Space.stride),
      ),
    ]),
  ];
}

/// Source, shown as source.
///
/// Distinct from [Terminal] because a transcript and a listing make different
/// claims. A transcript says *this happened*; a listing says *write this*. The
/// same box for both would blur the two, and one of them is a promise the
/// reader will test.
class Listing extends StatelessComponent {
  const Listing({required this.caption, required this.source, super.key});

  final String caption;
  final String source;

  @override
  Component build(BuildContext context) => figure(classes: 'listing', [
    figcaption([.text(caption)]),
    pre([code([.text(source)])]),
  ]);

  @css
  static List<StyleRule> get styles => [
    css('.listing', [
      css('&').styles(
        margin: Margin.zero,
        border: Border.all(color: role('rule'), width: Unit.pixels(1)),
        radius: const BorderRadius.circular(Unit.pixels(4)),
        overflow: const Overflow.only(x: Overflow.auto),
      ),
      css('figcaption').styles(
        padding: Padding.symmetric(vertical: Space.tight, horizontal: Space.snug),
        color: role('muted'),
        fontSize: Type.micro,
        fontFamily: Type.monoStack,
        border: Border.only(
          bottom: BorderSide(color: role('rule'), width: Unit.pixels(1)),
        ),
      ),
      css('pre').styles(
        margin: Margin.zero,
        padding: Padding.all(Space.snug),
        fontSize: Type.micro,
        lineHeight: const Unit.em(1.6),
      ),
    ]),
  ];
}
