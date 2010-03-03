package Template::ShowStartStop;

use warnings;
use strict;

=head1 NAME

Template::ShowStartStop - Display where template's start and stop

=head1 VERSION

Version 0.04

=cut

our $VERSION = '0.04';

=head1 SYNOPSIS

Template::ShowStartStop provides inline comments througout your code where
each template stops and starts.  It's an overridden version of L<Template::Context>
that wraps the C<process()> method.

Using Template::ShowStartStop is simple.

	use Template::ShowStartStop;

	my %config = ( # Whatever your config is
		INCLUDE_PATH	=> '/my/template/path',
		COMPILE_EXT	 => '.ttc',
		COMPILE_DIR	 => '/tmp/tt',
	);

	if ( $development_mode ) {
		$config{ CONTEXT } = Template::ShowStartStop->new( %config );
	}

	my $template = Template->new( \%config );

Now when you process templates, HTML comments will get embedded in your
output, which you can easily grep for.  The nesting level is also shown.

	<!-- START: include mainmenu/cssindex.tt -->
	<!-- STOP:  include mainmenu/cssindex.tt -->

	....

	<!-- STOP:  include mainmenu/footer.tt -->

=cut

use parent qw( Template::Context );

foreach my $sub ( qw( process ) ) {
	no strict 'refs';

	my $super = __PACKAGE__->can("SUPER::$sub") or die;

	*{$sub} = sub {
		my $self = shift;
		my $what = shift;

		my $template;

		if ( ref($what) eq 'ARRAY' ) {
			$template = join( ' + ', @{$what} );
		} elsif ( ref($what) ) {
			$template = $what->name;
		} else {
			$template = $what;
		}

		my $processed_data = $super->($self, $what, @_);

		my $output
			= "<!-- START: $sub $template -->\n"
			. "$processed_data"
			. "<!-- STOP:  $sub $template -->\n"
			;

		return $output;
	};
}

=head1 AUTHOR

Caleb Cushing, C<< <xenoterracide@gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-template-showstartstop at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

=head1 ACKNOWLEDGEMENTS

Thanks to
Andy Lester,
Randal Schwartz,
Bill Moseley,
and to Gavin Estey for the original Template::Timer code that this is based on.

=head1 COPYRIGHT & LICENSE

This library is free software; you can redistribute it and/or modify
it under the terms of either the GNU Public License v3, or the Artistic
License 2.0.

	* http://www.gnu.org/copyleft/gpl.html

	* http://www.opensource.org/licenses/artistic-license-2.0.php

=cut

1; # End of Template::ShowStartStop
