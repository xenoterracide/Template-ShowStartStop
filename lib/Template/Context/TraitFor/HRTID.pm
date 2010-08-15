use strict;
use warnings;
package Template::Context::TraitFor::HRTID;
BEGIN {
	# VERSION
}
use Moose::Role;

sub get_hrtid {
	my $self = shift;
	my $template = shift;

	return my $template_id
		# conditional                        # set $template to
		= ref($template) eq 'Template::Document' ? $template->name
		: ref($template) eq 'ARRAY'              ? join( ' + ', @{$template} )
		: ref($template) eq 'SCALAR'             ? '(evaluated block)'
		:                                          $template
		;
}

around 'process' => sub {
	my $orig = shift;
	my $self = shift;
	my ( $template ) = @_;

	$self->{template_id} = $self->get_hrtid( $template );

	$self->$orig(@_)
};

1;
# ABSTRACT: creates Human Readable Template IDentifiers

=head1 SYNOPSIS

	with 'Template::Context::TraitFor::HRTID';

	my $template_id = get_hrtid( $templateref );

=head1 DESCRIPTION

=head1 METHODS

=over

=item get_hrtid

this method takes a reference to a template and returns a Human Readable
Template Identifier which is usually a file name, but might be a block name or
even just evaluated text.

=back
