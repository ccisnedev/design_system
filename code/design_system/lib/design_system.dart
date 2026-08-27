/// The laboratory in which a design language is discovered.
///
/// Components arrive here only when a real page has asked for them. See
/// `docs/adr/0002-the-design-language-is-not-named-yet.md` for why the package
/// has a generic name, and `docs/journal.md` for what each component was
/// extracted to solve.
library;

export 'src/base.dart' show baseStyles, role, typefaces;
export 'src/layout.dart' show Band, Listing, Page;
export 'src/terminal.dart' show Blank, Line, Printed, Terminal, Typed;
export 'src/tokens.dart';
