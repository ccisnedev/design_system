/// A list of terms and what each one is.
///
/// The second site asked for this three times on one page — seven architectural
/// layers, eight CLI routes, and its own vocabulary — each written as a `div`
/// holding a `code` and a `span`. Three hand-built copies of one shape is the
/// clearest signal a component has been missing.
///
/// It renders a `dl`, which is what it is. The original markup was divs, and
/// nothing about a div says *this word is defined by that sentence* — to a
/// screen reader it was a stack of unrelated text. This is the semantics value
/// doing work a visual reading would not have noticed, because both render
/// identically.
///
/// Terms are set in mono because in practice every one of them is a literal —
/// a layer name, a command, a package. If a term ever wants prose, that is a
/// different component and not a flag on this one.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'base.dart';
import 'tokens.dart';

/// One term and its description.
class Row {
  const Row(this.term, this.describes);

  /// The literal being defined.
  final String term;

  /// What it is. Components rather than a string, because a description that
  /// cannot contain a link or a `code` would force the caller to choose between
  /// this component and saying what they mean.
  final List<Component> describes;
}

class Rows extends StatelessComponent {
  const Rows({required this.rows, super.key});

  final List<Row> rows;

  @override
  Component build(BuildContext context) => dl(classes: 'rows', [
    for (final row in rows) ...[
      dt([code([.text(row.term)])]),
      dd(row.describes),
    ],
  ]);

  @css
  static List<StyleRule> get styles => [
    css('.rows', [
      css('&').styles(
        display: Display.grid,
        // The terms share one column and it is as wide as the longest of them.
        // A fixed width would either clip a command or leave a gap after a
        // one-word layer name, and both are the same mistake: a measurement
        // guessed instead of derived.
        gridTemplate: const GridTemplate(
          columns: GridTracks([
            GridTrack(TrackSize.maxContent),
            GridTrack(TrackSize.fr(1)),
          ]),
        ),
        gap: Gap(row: Space.snug, column: Space.step),
        margin: Margin.zero,
      ),
      css('dt').styles(color: role('ink')),
      css('dd').styles(margin: Margin.zero, color: role('muted')),
      // Below the measure there is no room for two columns, and a term squeezed
      // to three characters wide is worse than a term on its own line.
      css.media(const MediaQuery.screen(maxWidth: Unit.rem(34)), [
        css('&').styles(
          gridTemplate: const GridTemplate(
            columns: GridTracks([GridTrack(TrackSize.fr(1))]),
          ),
          gap: Gap(row: Space.hair),
        ),
        css('dd').styles(margin: Margin.only(bottom: Space.snug)),
      ]),
    ]),
  ];
}
