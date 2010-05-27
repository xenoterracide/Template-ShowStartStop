use strict;
use warnings;

package Template::ShowStartStop;
use parent qw( Template::Context );

my $sub = qw(process);

my $super = __PACKAGE__->can("SUPER::$sub") or die;

my $wrapped = sub {
	my $self = shift;
	my $what = shift; # what template are we working with

	my $template # get the template filename
		# conditional           # set $template to
		= ref($what) eq 'ARRAY' ? join( ' + ', @{$what} )
		: ref($what)            ? $what->name
		:                         $what
		;

	my $processed_data = $super->($self, $what, @_);

	my $output
		= "<!-- START: $sub $template -->\n"
		. "$processed_data"
		. "<!-- STOP:  $sub $template -->\n"
		;

	return $output;
};

{ no strict 'refs'; *{$sub} = $wrapped; }

1;
__END__
# ABSTRACT: Display where template's start and stop
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

=cut

# notes from an IRC conversation on how to improve this module
[Tuesday 02 March 2010] [04:26:51 pm] <tm604>   xenoterracide: you can get rid
of foreach, since you only wrap one method, also drop my $super = ...;, remove
'no strict', change '*{$sub} = sub {' for 'my $wrappedSub = sub {', use 'my
$processed_data = $self->SUPER::process(...)', and at the end put { no strict
'refs'; *{'process'} = $wrappedSub; }.
[Tuesday 02 March 2010] [04:32:10 pm] <xenoterracide>   tm604 would I still
need the foreach if I was still wrapping include?
[Tuesday 02 March 2010] [04:32:31 pm] <tm604>   xenoterracide: Not really,
because it's needless complexity for something that's just subclassing one or
two methods.
[Tuesday 02 March 2010] [04:32:49 pm] <xenoterracide>   k
[Tuesday 02 March 2010] [04:35:08 pm] <tm604>   xenoterracide: Just put the
common code in a single sub, and have it call include or process as
appropriate.
