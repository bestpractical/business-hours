#!/usr/bin/perl -w

use Test::More 'no_plan';

package Catch;

sub TIEHANDLE {
    my($class, $var) = @_;
    return bless { var => $var }, $class;
}

sub PRINT  {
    my($self) = shift;
    ${'main::'.$self->{var}} .= join '', @_;
}

sub OPEN  {}    # XXX Hackery in case the user redirects
sub CLOSE {}    # XXX STDERR/STDOUT.  This is not the behavior we want.

sub READ {}
sub READLINE {}
sub GETC {}

my $Original_File = 'lib/Business/Hours.pm';

package main;

# pre-5.8.0's warns aren't caught by a tied STDERR.
$SIG{__WARN__} = sub { $main::_STDERR_ .= join '', @_; };
tie *STDOUT, 'Catch', '_STDOUT_' or die $!;
tie *STDERR, 'Catch', '_STDERR_' or die $!;

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

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 378 lib/Business/Hours.pm

use_ok  (Business::Hours);
my $hours = Business::Hours->new();
my $time;

# pick a date that's during business hours
# Thu Jan 01 15:00:00 1970
$time = $hours->first_after( 20 * 60 * 60);
is($time, (20 * 60 * 60));

# pick a date that's not during business hours
my ($xsec,$xmin,$xhour,$xmday,$xmon,$xyear,$xwday,$xyday,$xisdst) = localtime(0);
$time = $hours->first_after( 0 );
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($time);
is($wday, $xwday+1);
is($hour, 9);
is($min, 0);
is($sec, 0);


    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 433 lib/Business/Hours.pm

use_ok  (Business::Hours);
my $hours = Business::Hours->new();

my ($start, $time, $span);
# pick a date that's during business hours
$start = (20 * 60 * 60);
$time = $hours->add_seconds( $start, 30 * 60);
$span = $hours->for_timespan(Start => $start, End => $time);

# the first second is a business second, too
is(cardinality $span, (30 * 60)+1);

# pick a date that's not during business hours
$start = 0;
$time = $hours->add_seconds( $start, 30 * 60);
$span = $hours->for_timespan(Start => $start, End => $time);

# the first second is a business second, too
is(cardinality $span, (30 * 60)+1);


    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

