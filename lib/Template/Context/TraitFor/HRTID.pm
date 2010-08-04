use strict;
use warnings;
package Template::Context::TraitFor::HRTID;
BEGIN {
	# VERSION
}
use Moose::Role;

sub get_hrtid {
	my $template = shift;

	return my $template_id
		# conditional                        # set $template to
		= ref($template) eq 'Template::Document' ? $template->name
		: ref($template) eq 'ARRAY'              ? join( ' + ', @{$template} )
		: ref($template) eq 'SCALAR'             ? '(evaluated block)'
		:                                          $template
		;
}
1;
# ABSTRACT: creates Human Readable Template IDentifiers
