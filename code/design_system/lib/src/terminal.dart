/// A terminal transcript, shown as a transcript.
///
/// Extracted while building skillwire's site, which needed to prove a claim
/// rather than repeat it. It is the first component here because it is the one
/// the honesty value demands: a page that says a tool refuses ambiguity is
/// asking to be believed, and a page that shows the refusal is not.
///
/// There is no window chrome. Three coloured circles imitate an operating
/// system this transcript did not come from, and a decoration that asserts
/// something false is the exact defect this system exists to avoid.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'base.dart';
import 'tokens.dart';

/// One line of a transcript.
sealed class Line {
  const Line();

  /// What a person typed. Rendered after a prompt mark.
  const factory Line.typed(String command) = Typed;

  /// What the program answered.
  const factory Line.printed(String output) = Printed;

  /// A held beat. Blank lines are part of how a CLI reads and dropping them
  /// misquotes it.
  const factory Line.blank() = Blank;
}

final class Typed extends Line {
  final String command;
  const Typed(this.command);
}

final class Printed extends Line {
  final String output;
  const Printed(this.output);
}

final class Blank extends Line {
  const Blank();
}

/// A transcript, with a caption saying where it came from.
///
/// [caption] is not optional. A transcript with no provenance asks the reader
/// to take the author's word for it, which is the thing this component is for
/// avoiding.
class Terminal extends StatelessComponent {
  const Terminal({required this.caption, required this.lines, super.key});

  final String caption;
  final List<Line> lines;

  @override
  Component build(BuildContext context) {
    return figure(classes: 'terminal', [
      pre([
        code([
          for (final line in lines)
            switch (line) {
              Typed(:final command) => span(classes: 'typed', [
                span(classes: 'mark', [.text('\$ ')]),
                .text('$command\n'),
              ]),
              Printed(:final output) => .text('$output\n'),
              Blank() => .text('\n'),
            },
        ]),
      ]),
      figcaption([.text(caption)]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.terminal', [
      css('&').styles(
        margin: Margin.zero,
        padding: Padding.symmetric(vertical: Space.step, horizontal: Space.step),
        radius: const BorderRadius.circular(Unit.pixels(4)),
        color: role('shell-ink'),
        backgroundColor: role('shell-surface'),
        overflow: const Overflow.only(x: Overflow.auto),
      ),
      css('pre').styles(
        margin: Margin.zero,
        fontSize: Type.micro,
        lineHeight: const Unit.em(1.7),
      ),
      // The prompt mark is not content. Selecting the transcript to run it
      // should not pick up a '$' that was never part of the command.
      css('.mark').styles(
        color: role('shell-muted'),
        userSelect: UserSelect.none,
      ),
      css('.typed').styles(fontWeight: FontWeight.w500),
      css('figcaption').styles(
        margin: Margin.only(top: Space.snug),
        color: role('shell-muted'),
        fontSize: Type.micro,
        fontFamily: Type.sansStack,
      ),
    ]),
  ];
}
