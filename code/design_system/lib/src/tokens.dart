/// The design tokens: the hypothesis of ADR 0002, stated as code so that a real
/// page can contradict it.
///
/// Every value here is provisional and every one has a reason. A token whose
/// reason cannot be given does not belong — that is the katana half of the
/// motto, where a curve exists because it does work and the beauty is a
/// consequence rather than an intention.
library;

import 'package:jaspr/dom.dart';

// ─── Colour ─────────────────────────────────────────────────────────────────

/// Ink on paper, and one seal.
///
/// The palette is deliberately almost monochrome. A single saturated colour
/// appears, rarely, and always to mark something — the way a *hanko* is the one
/// red on an ink drawing. A second accent would make the first one decoration.
abstract final class Ink {
  /// Body text. Not pure black: pure black on a lit screen reads as a hole.
  static const paper = Color('#FBFAF7');
  static const ink = Color('#17181B');

  /// Secondary text. Must stay legible on [paper] — it carries real content
  /// (captions, provenance), never filler.
  static const muted = Color('#6E7178');

  /// Hairlines. A rule separates; it never decorates, so it is the faintest
  /// mark the palette allows.
  static const rule = Color('#E4E2DB');

  /// The seal. Links, and the single mark that says "this is the point".
  static const seal = Color('#B03A20');

  /// The terminal is shown as a terminal. Rendering a transcript on paper would
  /// be prettier and would misrepresent where the words come from.
  static const shellSurface = Color('#17181B');
  static const shellInk = Color('#DEDBD3');
  static const shellMuted = Color('#82868E');
}

/// The same roles after dark. Roles, not colours: nothing downstream names a
/// hex value, so the two schemes cannot drift apart in meaning.
abstract final class InkDark {
  static const paper = Color('#111214');
  static const ink = Color('#E9E7E1');
  static const muted = Color('#8C9098');
  static const rule = Color('#26282C');
  static const seal = Color('#D9583A');
  // Measurably lighter than [paper], not slightly. In light mode the terminal
  // marks itself by inverting; after dark that move is unavailable, so the
  // separation has to be carried by luminance alone or the box stops reading as
  // a box. #191A1E against #111214 did not, which the pilot showed at once.
  static const shellSurface = Color('#1F2228');
  static const shellInk = Color('#DEDBD3');
  static const shellMuted = Color('#82868E');
}

// ─── Type ───────────────────────────────────────────────────────────────────

/// One family, two voices. IBM Plex was drawn as a system — sans and mono share
/// their skeleton — so pairing them is a decision already made coherently by
/// someone else, which is cheaper than making it badly here.
abstract final class Type {
  static const sans = FontFamily('IBM Plex Sans');
  static const mono = FontFamily('IBM Plex Mono');

  static const sansStack = FontFamily.list([sans, FontFamilies.sansSerif]);
  static const monoStack = FontFamily.list([mono, FontFamilies.monospace]);

  /// Five sizes, and no sixth.
  ///
  /// A haiku is not "short" — it is 5-7-5, a fixed form that forces choice. A
  /// scale with an escape hatch stops being a scale, so when a sixth size is
  /// wanted the answer is that the design is wrong, not that the scale is
  /// short.
  static const micro = Unit.rem(0.78);
  static const body = Unit.rem(1.0);
  static const lead = Unit.rem(1.25);
  static const title = Unit.rem(1.9);
  static const display = Unit.rem(3.1);
}

// ─── Rhythm ─────────────────────────────────────────────────────────────────

/// Spacing, in one series.
///
/// Seven steps, each roughly 1.5× the last. Space is how a page breathes and it
/// is the *kireji* — the cut — of the form: where the rhythm stops is a
/// decision, so it is made from a fixed set rather than by feel each time.
abstract final class Space {
  static const hair = Unit.rem(0.25);
  static const tight = Unit.rem(0.5);
  static const snug = Unit.rem(0.85);
  static const step = Unit.rem(1.4);
  static const stride = Unit.rem(2.3);
  static const leap = Unit.rem(3.8);
  static const chasm = Unit.rem(6.2);
}

/// The measure. Prose stops being readable somewhere near 75 characters, and
/// this is that, not a fashion.
const measure = Unit.rem(38);

/// The page's own width, wider than [measure] because tables and transcripts
/// are not prose and are unreadable when wrapped to it.
const pageWidth = Unit.rem(58);
