/// The base stylesheet: what every page gets before a single component renders.
///
/// It is small on purpose. A reset that opinionates every element decides
/// things the page has not asked about yet, and the point of this laboratory is
/// to find out what the page actually asks for.
library;

import 'package:jaspr/dom.dart';

import 'tokens.dart';

/// Google Fonts for the two voices. Two weights of each and no italics: an
/// unused weight is bytes the reader pays for and never sees.
final typefaces = css.import(
  'https://fonts.googleapis.com/css2'
  '?family=IBM+Plex+Mono:wght@400;500'
  '&family=IBM+Plex+Sans:wght@400;600'
  '&display=swap',
);

/// Colour as CSS custom properties, so the dark scheme redefines *roles* rather
/// than restating every rule. Nothing below this function names a hex value.
List<StyleRule> _palette() => [
  css(':root').styles(raw: {
    '--paper': Ink.paper.value,
    '--ink': Ink.ink.value,
    '--muted': Ink.muted.value,
    '--rule': Ink.rule.value,
    '--seal': Ink.seal.value,
    '--shell-surface': Ink.shellSurface.value,
    '--shell-ink': Ink.shellInk.value,
    '--shell-muted': Ink.shellMuted.value,
    'color-scheme': 'light dark',
  }),
  css.media(const MediaQuery.all(prefersColorScheme: ColorScheme.dark), [
    css(':root').styles(raw: {
      '--paper': InkDark.paper.value,
      '--ink': InkDark.ink.value,
      '--muted': InkDark.muted.value,
      '--rule': InkDark.rule.value,
      '--seal': InkDark.seal.value,
      '--shell-surface': InkDark.shellSurface.value,
      '--shell-ink': InkDark.shellInk.value,
      '--shell-muted': InkDark.shellMuted.value,
    }),
  ]),
];

/// A colour role, for use anywhere a [Color] is expected.
Color role(String name) => Color.variable('--$name');

/// The whole base sheet.
List<StyleRule> baseStyles() => [
  typefaces,
  ..._palette(),

  css('*, *::before, *::after').styles(boxSizing: BoxSizing.borderBox),

  css('html').styles(raw: {'-webkit-text-size-adjust': '100%'}),

  css('body').styles(
    margin: Margin.zero,
    color: role('ink'),
    fontFamily: Type.sansStack,
    fontSize: Type.body,
    lineHeight: const Unit.em(1.65),
    backgroundColor: role('paper'),
    raw: {'-webkit-font-smoothing': 'antialiased'},
  ),

  // Headings are set tighter than body, because a line of display type at body
  // leading looks like an accident.
  css('h1, h2, h3').styles(
    margin: Margin.zero,
    fontWeight: FontWeight.w600,
    lineHeight: const Unit.em(1.15),
    letterSpacing: const Unit.em(-0.02),
  ),
  css('h1').styles(fontSize: Type.display),
  css('h2').styles(fontSize: Type.title),
  css('h3').styles(fontSize: Type.lead),

  css('p').styles(margin: Margin.zero, maxWidth: measure),

  css('a').styles(
    color: role('seal'),
    textDecoration: const TextDecoration(
      line: TextDecorationLine.underline,
      thickness: TextDecorationThickness.fromFont,
    ),
    raw: {'text-underline-offset': '0.18em'},
  ),

  css('code, pre, kbd').styles(
    fontFamily: Type.monoStack,
    fontSize: const Unit.em(0.9),
  ),

  // Every table on this site carries data a reader may need to compare across
  // rows, so the rules are horizontal only: a vertical rule invites reading
  // down a column that means nothing on its own.
  css('table').styles(
    width: 100.percent,
    fontSize: Type.micro,
    raw: {'border-collapse': 'collapse'},
  ),
  css('th, td').styles(
    padding: Padding.symmetric(vertical: Space.tight, horizontal: Space.snug),
    textAlign: TextAlign.left,
    border: Border.only(bottom: BorderSide(color: role('rule'), width: Unit.pixels(1))),
  ),
  css('th').styles(
    color: role('muted'),
    fontSize: Type.micro,
    fontWeight: FontWeight.w500,
    textTransform: TextTransform.upperCase,
    letterSpacing: const Unit.em(0.08),
  ),
];
