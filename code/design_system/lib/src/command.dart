/// A line meant to be run, with a way to take it.
///
/// Distinct from [Listing], which is source you read and adapt. This is a
/// single line you execute unchanged, and the reader's next act is to get it
/// into a shell. The page exists so that act happens, so the component helps it
/// happen.
///
/// ## Why the script is six lines of JavaScript
///
/// Dart reaches the clipboard: a `@client` island compiles and works. It costs
/// 136 KB of `dart2js` output, which is eight times the page it would sit on
/// and does not shrink — 136 KB is the floor, not this component's weight.
/// These lines cost 230 bytes.
///
/// The usual objection to hand-written JavaScript is that the behaviour ends up
/// in a file each consumer must remember to include, and the copy that nobody
/// edits is the copy that drifts. `script(content:)` removes that: the script
/// ships inside the component, and a consumer imports one thing.
///
/// The trade is real and named: this JavaScript has no types and no test. Six
/// lines are read at a glance; sixty are not. A third interactive component
/// reopens the decision, and migrating to a Dart island then changes this file
/// and nothing else.
///
/// ## The button is hidden until the script runs
///
/// A copy button that does nothing is a control that lies, and a page that says
/// what it can back is the whole argument here. With scripting off the button
/// never appears and the command is still there to select. When the clipboard
/// refuses — an insecure context, a permission — the button says so instead of
/// reporting a copy that did not happen.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'base.dart';
import 'tokens.dart';

class Command extends StatelessComponent {
  const Command({required this.command, this.caption, super.key});

  /// One line, run unchanged. Several lines are a [Listing].
  final String command;

  /// What shell this is for, when a page offers more than one.
  final String? caption;

  /// Bound once per page. Repeats of this component re-render the same script,
  /// so it guards itself rather than relying on there being exactly one.
  static const _script = '''
if (!window.__copy) {
  window.__copy = 1;
  addEventListener('DOMContentLoaded', () => {
    for (const b of document.querySelectorAll('button[data-copy]')) b.hidden = false;
  });
  addEventListener('click', e => {
    const b = e.target.closest('button[data-copy]');
    if (!b) return;
    navigator.clipboard.writeText(b.dataset.copy).then(
      () => { b.textContent = 'Copied'; },
      () => { b.textContent = 'Select and copy'; },
    );
  });
}
''';

  @override
  Component build(BuildContext context) => Component.fragment([
    figure(classes: 'command', [
      if (caption case final c?) figcaption([.text(c)]),
      div(classes: 'command-line', [
        code([.text(command)]),
        button(
          classes: 'copy',
          attributes: {'data-copy': command, 'hidden': ''},
          [.text('Copy')],
        ),
      ]),
    ]),
    script(content: _script),
  ]);

  @css
  static List<StyleRule> get styles => [
    css('.command', [
      css('&').styles(
        margin: Margin.zero,
        border: Border.all(color: role('rule'), width: Unit.pixels(1)),
        radius: const BorderRadius.circular(Unit.pixels(4)),
      ),
      css('figcaption').styles(
        padding: Padding.symmetric(vertical: Space.tight, horizontal: Space.snug),
        border: Border.only(
          bottom: BorderSide(color: role('rule'), width: Unit.pixels(1)),
        ),
        color: role('muted'),
        fontFamily: Type.monoStack,
        fontSize: Type.micro,
      ),
      css('.command-line').styles(
        display: Display.flex,
        padding: Padding.all(Space.snug),
        justifyContent: JustifyContent.spaceBetween,
        alignItems: AlignItems.center,
        gap: Gap(column: Space.step),
      ),
      css('code').styles(
        overflow: const Overflow.only(x: Overflow.auto),
        fontSize: Type.micro,
      ),
      css('.copy').styles(
        padding: Padding.symmetric(vertical: Space.hair, horizontal: Space.tight),
        border: Border.all(color: role('rule'), width: Unit.pixels(1)),
        radius: const BorderRadius.circular(Unit.pixels(3)),
        cursor: Cursor.pointer,
        color: role('muted'),
        fontFamily: Type.sansStack,
        fontSize: Type.micro,
        backgroundColor: Colors.transparent,
      ),
      css('.copy:hover').styles(color: role('ink')),
    ]),
  ];
}
