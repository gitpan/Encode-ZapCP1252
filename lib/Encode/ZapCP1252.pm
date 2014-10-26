package Encode::ZapCP1252;

# $Id: ZapCP1252.pm 3695 2008-05-02 04:46:40Z david $

use strict;
require Exporter;
use vars qw($VERSION @ISA @EXPORT);

$VERSION     = '0.02';
@ISA         = qw(Exporter);
@EXPORT      = qw(zap_cp1252);

my %cp1252 = (
    # http://en.wikipedia.org/wiki/Windows-1252
    "\x80" => 'e',    # EURO SIGN
    "\x82" => ',',    # SINGLE LOW-9 QUOTATION MARK
    "\x83" => 'f',    # LATIN SMALL LETTER F WITH HOOK
    "\x84" => ',,',   # DOUBLE LOW-9 QUOTATION MARK
    "\x85" => '...',  # HORIZONTAL ELLIPSIS
    "\x86" => '+',    # DAGGER
    "\x87" => '++',   # DOUBLE DAGGER
    "\x88" => '^',    # MODIFIER LETTER CIRCUMFLEX ACCENT
    "\x89" => '%',    # PER MILLE SIGN
    "\x8a" => 'S',    # LATIN CAPITAL LETTER S WITH CARON
    "\x8b" => '<',    # SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    "\x8c" => 'OE',   # LATIN CAPITAL LIGATURE OE
    "\x8e" => 'Z',    # LATIN CAPITAL LETTER Z WITH CARON
    "\x91" => "'",    # LEFT SINGLE QUOTATION MARK
    "\x92" => "'",    # RIGHT SINGLE QUOTATION MARK
    "\x93" => '"',    # LEFT DOUBLE QUOTATION MARK
    "\x94" => '"',    # RIGHT DOUBLE QUOTATION MARK
    "\x95" => '*',    # BULLET
    "\x96" => '-',    # EN DASH
    "\x97" => '--',   # EM DASH
    "\x98" => '~',    # SMALL TILDE
    "\x99" => '(tm)', # TRADE MARK SIGN
    "\x9a" => 's',    # LATIN SMALL LETTER S WITH CARON
    "\x9b" => '>',    # SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    "\x9c" => 'oe',   # LATIN SMALL LIGATURE OE
    "\x9e" => 'z',    # LATIN SMALL LETTER Z WITH CARON
    "\x9f" => 'Y',    # LATIN CAPITAL LETTER Y WITH DIAERESIS
);

sub zap_cp1252 ($) {
    $_[0] =~ s/([\x80-\x9f])/$cp1252{$1} || $1/emxsg;
}

1;
__END__

##############################################################################

=begin comment

Fake-out Module::Build. Delete if it ever changes to support =head1 headers
other than all uppercase.

=head1 NAME

Encode::ZapCP1252 - Zap Windows Western Gremlins

=end comment

=head1 Name

Encode::ZapCP1252 - Zap Windows Western Gremlins

=head1 Synopsis

  use Encode::ZapCP152;

  zap_to_cp1252($text);

=head1 Description

Have you ever been processing a Web form submit, assuming that the incoming
text was encoded in ISO-8859-1 (Latin-1), only to end up with a bunch of junk
because someone pasted in content from Microsoft Word? Well, this is because
Microsoft uses a superset of the Latin-1 encoding called "Windows Western" or
"CP1252". So mostly things will come out right, but a few things--like curly
quotes, m-dashes, elipses, and the like--will not. The differences are
well-known; you see a nice chart at documenting the differences on Wikipedia:
L<http://en.wikipedia.org/wiki/Windows-1252>.

Of course, that won't really help you. What will help you is to quit using
Latin-1 and switch to UTF-8. Then you can just convert from CP1252 to UTF-8
without losing a thing, just like this:

  use Encode;
  $text = decode('cp1252', $text, 1);

But I know that there are those of you out there stuck with Latin-1 and who
don't want any junk charactrs from Word users, and that's where this module
comes in. It will zap those CP1252 gremlins for you, turning them into their
appropriate ASCII approximations.

=head1 Usage

This module exports a single subroutine: C<zap_cp1252()>. You use it
like this:

  zap_cp1252($text);

This subroutine performs an I<in place> conversion of the CP1252 gremlins into
appropriate ASCII approximations.

Note that because the conversion happens in place, the data to be converted
I<cannot> be a string constant; it must be a scalar variable.

=head1 Conversion Table

Here's how the characters are converted to ASCII. They're not perfect
conversions, but they should be good enough. If you want perfect, switch to
UTF-8 and be done with it!

=encoding utf8

   Hex | Char  | ASCII | UTF-8 Name
  -----+-------+-------+-------------------------------------------
  0x80 |   €   |   e   | EURO SIGN
  0x82 |   ‚   |   ,   | SINGLE LOW-9 QUOTATION MARK
  0x83 |   ƒ   |   f   | LATIN SMALL LETTER F WITH HOOK
  0x84 |   „   |   ,,  | DOUBLE LOW-9 QUOTATION MARK
  0x85 |   …   |  ...  | HORIZONTAL ELLIPSIS
  0x86 |   †   |   +   | DAGGER
  0x87 |   ‡   |   ++  | DOUBLE DAGGER
  0x88 |   ˆ   |   ^   | MODIFIER LETTER CIRCUMFLEX ACCENT
  0x89 |   ‰   |   %   | PER MILLE SIGN
  0x8a |   Š   |   S   | LATIN CAPITAL LETTER S WITH CARON
  0x8b |   ‹   |   <   | SINGLE LEFT-POINTING ANGLE QUOTATION MARK
  0x8c |   Œ   |   OE  | LATIN CAPITAL LIGATURE OE
  0x8e |   Ž   |   Z   | LATIN CAPITAL LETTER Z WITH CARON
  0x91 |   ‘   |   '   | LEFT SINGLE QUOTATION MARK
  0x92 |   ’   |   '   | RIGHT SINGLE QUOTATION MARK
  0x93 |   “   |   "   | LEFT DOUBLE QUOTATION MARK
  0x94 |   ”   |   "   | RIGHT DOUBLE QUOTATION MARK
  0x95 |   •   |   *   | BULLET
  0x96 |   –   |   -   | EN DASH
  0x97 |   —   |   --  | EM DASH
  0x98 |   ˜   |   ~   | SMALL TILDE
  0x99 |   ™   |  (tm) | TRADE MARK SIGN
  0x9a |   š   |   s   | LATIN SMALL LETTER S WITH CARON
  0x9b |   ›   |   >   | SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
  0x9c |   œ   |   oe  | LATIN SMALL LIGATURE OE
  0x9e |   ž   |   z   | LATIN SMALL LETTER Z WITH CARON
  0x9f |   Ÿ   |   Y   | LATIN CAPITAL LETTER Y WITH DIAERESIS

=head1 See Also

=over

=item L<Encode|Encode>

=item L<http://en.wikipedia.org/wiki/Windows-1252>

=back

=head1 Bugs

Please send bug reports to <bug-encode-zapcp1252@rt.cpan.org>.

=head1 Author

=begin comment

Fake-out Module::Build. Delete if it ever changes to support =head1 headers
other than all uppercase.

=head1 AUTHOR

=end comment

David Wheeler <david@kineticode.com>

=head1 Acknowledgements

My thanks to Sean Burke for sending me his original method for converting
CP1252 characters to Latin-1 enabled ASCII characters.

=head1 Copyright and License

Copyright (c) 2005 Kineticode, Inc. All Rights Reserved.

This module is free software; you can redistribute it and/or modify it under the
same terms as Perl itself.

=cut
