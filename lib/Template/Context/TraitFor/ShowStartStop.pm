use strict;
use warnings;
package Template::Context::TraitFor::ShowStartStop;
BEGIN {
	# VERSION
}
use Moose::Role;

around 'process' => sub {
	my $orig = shift;
	my $self = shift;

	my $tid = $self->can('pop_tid') ? $self->pop_tid : '';

	my $output
		= "<!-- START: process $tid -->\n"
		. $self->$orig(@_)
		. "<!-- STOP:  process $tid -->\n"
		;
};
1;
# ABSTRACT: Trait that show's the start and stop of a template
