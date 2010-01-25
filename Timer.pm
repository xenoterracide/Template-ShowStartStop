package Template::Timer;

use warnings;
use strict;

=head1 NAME

Template::Timer - Rudimentary profiling for Template Toolkit

=head1 VERSION

Version 0.04

=cut

our $VERSION = '0.04';

=head1 SYNOPSIS

Template::Timer provides inline timings of the template processing
througout your code.  It's an overridden version of L<Template::Context>
that wraps the C<process()> and C<include()> methods.

Using Template::Timer is simple.

    my %config = ( # Whatever your config is
        INCLUDE_PATH    => "/my/template/path",
        COMPILE_EXT     => ".ttc",
        COMPILE_DIR     => "/tmp/tt",
    );

    if ( $development_mode ) {
        $config{ CONTEXT } = Template::Timer->new( %config );
    }

    my $template = Template->new( \%config );

Now when you process templates, HTML comments will get embedded in your
output, which you can easily grep for.

    <!-- TIMER START: process mainmenu/mainmenu.ttml -->
    <!-- TIMER START: include mainmenu/cssindex.tt -->
    <!-- TIMER START: process mainmenu/cssindex.tt -->
    <!-- TIMER END: process mainmenu/cssindex.tt (0.017279 seconds) -->
    <!-- TIMER END: include mainmenu/cssindex.tt (0.017401 seconds) -->

    ....

    <!-- TIMER END: process mainmenu/footer.tt (0.003016 seconds) -->
    <!-- TIMER END: include mainmenu/footer.tt (0.003104 seconds) -->
    <!-- TIMER END: process mainmenu/mainmenu.ttml (0.400409 seconds) -->

Note that since INCLUDE is a wrapper around PROCESS, calls to INCLUDEs
will be doubled up, and slightly longer than the PROCESS call.

=cut

use base qw( Template::Context );
use Time::HiRes (); # Save as much space as we can

foreach my $sub ( qw( process include ) ) {
    no strict;
    my $super = __PACKAGE__->can("SUPER::$sub") or die;
    *$sub = sub {
        my $self     = shift;
        my $template = ref $_[0] eq 'ARRAY'
                            ? join( ' + ', @{$_[0]} )
                            : ref $_[0] ? $_[0]->name : $_[0];
        my $start    = [Time::HiRes::gettimeofday];
        my $data     = $super->($self, @_);
        my $elapsed  = Time::HiRes::tv_interval($start);
        return <<"END"
<!-- TIMER START: $sub $template -->
$data
<!-- TIMER END: $sub $template ($elapsed seconds) -->
END
    }; # sub
} # for


=head1 AUTHOR

Andy Lester, C<< <andy at petdance.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-template-timer at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

=head1 ACKNOWLEDGEMENTS

Thanks to
Randal Schwartz,
Bill Moseley,
and to Gavin Estey for the original code.

=head1 COPYRIGHT & LICENSE

Copyright 2005 Andy Lester, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Template::Timer
