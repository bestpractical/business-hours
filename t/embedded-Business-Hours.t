#!perl -w

use Test::More 'no_plan';

package Catch;

sub TIEHANDLE {
    my($class) = shift;
    return bless {}, $class;
}

sub PRINT  {
    my($self) = shift;
    $main::_STDOUT_ .= join '', @_;
}

sub READ {}
sub READLINE {}
sub GETC {}

package main;

local $SIG{__WARN__} = sub { $_STDERR_ .= join '', @_ };
tie *STDOUT, 'Catch' or die $!;


{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 189 lib/Business/Hours.pm

use_ok  (Business::Hours);
my $hours = Business::Hours->new();
is(ref($hours), 'Business::Hours');
# how many business hours were there in the first week.
my $hours_span = $hours->for_timespan(Start => '0', End => ( (86400 * 7)));
is(ref($hours_span), 'Set::IntSpan');

# Are there 45 working hours

is(cardinality $hours_span, (45 * 60 * 60));





    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

