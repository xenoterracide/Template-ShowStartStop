#
# This file is part of Template-ShowStartStop
#
# This software is Copyright (c) 2010 by Caleb Cushing.
#
# This is free software, licensed under:
#
#   The Artistic License 2.0
#
use strict;
use warnings;
package MooseX::Template::Context::Role::ShowStartStop;
BEGIN {
  $MooseX::Template::Context::Role::ShowStartStop::VERSION = '0.11';
}
use Moose::Role;

override 'process' => sub {
	my $self = shift;
	my ( $template ) = @_;

	my $template_id
		# conditional                        # set $template to
		= ref($template) eq 'Template::Document' ? $template->name
		: ref($template) eq 'ARRAY'              ? join( ' + ', @{$template} )
		: ref($template) eq 'SCALAR'             ? '(evaluated block)'
		:                                          $template
		;

	my $processed_data = super();

	my $output
		= "<!-- START: process $template_id -->\n"
		. "$processed_data"
		. "<!-- STOP:  process $template_id -->\n"
		;

	return $output;
};
1;
# ABSTRACT: Role to Display where templates start and stop


__END__
=pod

=head1 NAME

MooseX::Template::Context::Role::ShowStartStop - Role to Display where templates start and stop

=head1 VERSION

version 0.11

=head1 SYNOPSIS

	with 'MooseX::Template::Context::Role::ShowStartStop';

=head1 BUGS

Please report any bugs or feature requests on
L<http://github.com/xenoterracide/Template-ShowStartStop/issues>
as I'm not fond of RT.

=head1 SUBMITTING PATCHES

Please read the SubmittingPatches file included with this Distribution. Patches
that are of sufficient quality, within the goals of the project and pass the
checklist will probably be accepted.

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0

=cut

