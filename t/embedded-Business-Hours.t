#!/usr/bin/perl -w

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

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 378 lib/Business/Hours.pm

use_ok  (Business::Hours);
my $hours = Business::Hours->new();
my $time;

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
my $starttime;

# pick a date that's during business hours
$starttime = 0;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($starttime);
while ($wday == 0  || $wday == 6) {
    $starttime += ( 24 * 60 * 60);
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($starttime);
}
while ( $hour < 9 || $hour >= 18 ) {
    $starttime += ( 4 * 60);
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($starttime);
}

$time = $hours->first_after( $starttime );
is($time, ( $starttime ));

# pick a date that's not during business hours
$starttime = 0;
($xsec,$xmin,$xhour,$xmday,$xmon,$xyear,$xwday,$xyday,$xisdst) = localtime($starttime);
while ( $xwday != 0 ) {
    $starttime += ( 24 * 60 * 60);
    ($xsec,$xmin,$xhour,$xmday,$xmon,$xyear,$xwday,$xyday,$xisdst) = localtime($starttime);
}

$time = $hours->first_after( $starttime );
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($time);
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
#line 452 lib/Business/Hours.pm

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

