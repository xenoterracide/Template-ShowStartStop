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

	my $output
		= "<!-- START: process $self->{template_id} -->\n"
		. $self->$orig(@_)
		. "<!-- STOP:  process $self->{template_id} -->\n"
		;
};
1;
