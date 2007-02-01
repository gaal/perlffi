package Superglue;

use warnings;
use strict;

use 5.008;

use Carp;

use vars qw($VERSION $AUTOLOAD);

my %LIBRARIES;

BEGIN {
    $VERSION = '0.01';

    local $@;
    eval {
        require XSLoader;
        XSLoader::load(__PACKAGE__, $VERSION);
        1;
    } or do {
        require DynaLoader;
        no strict;
        push @ISA, 'DynaLoader';
        __PACKAGE__->bootstrap($VERSION);
    };
}

sub load_library {
    my($class) = shift;
    Carp::confess("missing arguments for load_library") unless @_;
    @_ = (library => $_[0]) if @_ == 1;
    my %args = (
        default_callconv => 'cdecl',
        functions        => {},
        @_,
    );
    ($args{moniker} = $args{library}) =~ s{(?:^.*[/\\])?(.*)(?:\.so|\.dll)}{$1};

    # create the stub namespace
    my $package = "Superglue::lib::$args{moniker}";
    {
        no strict;
        *{"$package\::ISA"} = [__PACKAGE__];
    }

    return bless \%args, $package;
}

sub AUTOLOAD {
    my($self, @args) = @_;
    (my($moniker, $func) = $AUTOLOAD =~ /Superglue::lib::(.*)::(.*)/) or
        Carp::confess("Superglue::AUTOLOAD expected a library call");
    my($call_conv, $func_addr) = $self->find_func_params($func);
    my $code = sub {
        sg_dispatch($call_conv, $func_addr, @args);
    };

    {
        no strict;
        *{$AUTOLOAD} = $code;
    }
    goto &$code;
}

1; # End of Superglue

__END__

=head1 NAME

Superglue - bind to foreign libraries in three seconds flat

=head1 SYNOPSIS

Say you have some shared object (DLL) that exports functions foo and bar.

    use Superglue;

    my $lib = Superglue->load_library("mylib.so");
    $lib->foo(1, "two");

autoload -> $AUTOLOAD eq Superglue::foo
            @_ ~~ (1, "two")

sub AUTOLOAD {
    my($funcname = $AUTOLOAD) =~ s/Superglue:://;
    
    superglue_call($funcname, @_)

    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head1 AUTHOR

Anatoly Vorobey, C<< <avorobey@pobox.com> >>

Gaal Yahas, C<< <gaal at forum2.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-superglue at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Superglue>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Superglue

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Superglue>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Superglue>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Superglue>

=item * Search CPAN

L<http://search.cpan.org/dist/Superglue>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT (The "MIT" License)

Copyright 2007 Anatoly Vorobey and Gaal Yahas.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut

vim: ts=4 et sw=4 :
