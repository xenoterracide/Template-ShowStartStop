use strict;
use warnings;

package Template::ShowStartStop;
use parent qw( Template::Context );

my $super = __PACKAGE__->can('SUPER::process') or die;

sub process {
	my $self = shift;
	my $what = shift; # what template are we working with

	my $template
		# conditional                        # set $template to
		= ref($what) eq 'Template::Document' ? $what->name
		: ref($what) eq 'ARRAY'              ? join( ' + ', @{$what} )
		: ref($what) eq 'SCALAR'             ? '(evaluated block)'
		:                                      $what
		;

	my $processed_data = $super->($self, $what, @_);

	my $output
		= "<!-- START: process $template -->\n"
		. "$processed_data"
		. "<!-- STOP:  process $template -->\n"
		;

	return $output;
};

1;
# ABSTRACT: Display where template's start and stop
=head1 SYNOPSIS

	use Template::ShowStartStop;

	my $tt = Template->new({
		CONTEXT => Template::ShowStartStop->new
	});

=head1 DESCRIPTION

Template::ShowStartStop provides inline comments throughout your code where
each template stops and starts.  It's an overridden version of L<Template::Context>
that wraps the C<process()> method.

Using Template::ShowStartStop is simple.
Now when you process templates, HTML comments will get embedded in your
output, which you can easily grep for.  The nesting level is also shown.

	<!-- START: process wrapper.tt -->
	<!DOCTYPE html>
	<html>
	<head>
	<!-- START: process head.tt -->
	...
	<!-- STOP:  process head.tt -->
	</head>
	...
	</html>
	<!-- STOP:  process wrapper.tt -->

=head1 BUGS

Please report any bugs or feature requests on 
L<http://github.com/xenoterracide/Template-ShowStartStop/issues>
as I'm not fond of RT.

=head1 SUBMITTING PATCHES

Please read the SubmittingPatches file included with this Distribution. Patches
that are of sufficient quality, within the goals of the project and pass the
checklist will probably be accepted.

=head1 ACKNOWLEDGEMENTS

Thanks to
Andy Lester,
Randal Schwartz,
Bill Moseley,
and to Gavin Estey for the original Template::Timer code that this is based on.

=cut
