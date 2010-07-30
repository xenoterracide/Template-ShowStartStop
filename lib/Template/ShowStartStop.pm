use strict;
use warnings;
package Template::ShowStartStop;
BEGIN {
	# VERSION
}
use Moose;
use namespace::autoclean;
extends 'Template::Context';

sub _template_id {
	my $template = shift;

	return my $template_id
		# conditional                        # set $template to
		= ref($template) eq 'Template::Document' ? $template->name
		: ref($template) eq 'ARRAY'              ? join( ' + ', @{$template} )
		: ref($template) eq 'SCALAR'             ? '(evaluated block)'
		:                                          $template
		;
}

sub output {
	my ( $processed_template, $template_id ) = @_;

	return my $output
		= "<!-- START: process $template_id -->\n"
		. "$processed_template"
		. "<!-- STOP:  process $template_id -->\n"
		;
}

around 'process' => sub {
	my $orig = shift;
	my $self = shift;
	my ( $template ) = @_;

	my $template_id = _template_id($template);

	return my $output
		= "<!-- START: process $template_id -->\n"
		. $self->$orig(@_)
		. "<!-- STOP:  process $template_id -->\n"
		;
};
no SUPER;
1;
# ABSTRACT: Display where templates start and stop
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
