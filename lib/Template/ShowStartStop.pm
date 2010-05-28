use strict;
use warnings;

package Template::ShowStartStop;
BEGIN {
  $Template::ShowStartStop::VERSION = '0.08';
}
use parent qw( Template::Context );

my $super = __PACKAGE__->can('SUPER::process') or die;

my $wrapped = sub {
	my $self = shift;
	my $what = shift; # what template are we working with

	my $template # get the template filename
		# conditional           # set $template to
		= ref($what) eq 'ARRAY'  ? join( ' + ', @{$what} )
		: ref($what) eq 'SCALAR' ? '(evaluated block)'
		: ref($what) eq 'HASH'   ? $what->name
		:                          $what
		;

	my $processed_data = $super->($self, $what, @_);

	my $output
		= "<!-- START: process $template -->\n"
		. "$processed_data"
		. "<!-- STOP:  process $template -->\n"
		;

	return $output;
};

*{process} = $wrapped;

1;


=pod

=head1 NAME

Template::ShowStartStop - Display where template's start and stop

=head1 VERSION

version 0.08

=head1 SYNOPSIS

	use Template::ShowStartStop;

	my $tt = Template->new({
		CONTEXT => Template::ShowStartStop->new
	});

=head1 DESCRIPTION

Template::ShowStartStop provides inline comments througout your code where
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

=head1 ACKNOWLEDGEMENTS

Thanks to
Andy Lester,
Randal Schwartz,
Bill Moseley,
and to Gavin Estey for the original Template::Timer code that this is based on.

=head1 AUTHOR

  Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0

=cut


__END__
# ABSTRACT: Display where template's start and stop
