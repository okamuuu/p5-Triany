#!/usr/bin/env perl
use strict;
use warnings;
use Carp ();
use Time::HiRes ();

my $filename = 'data/testdata.txt';

open my $FILE, '<', $filename or Carp::croak "Can\'t open '$filename': $@";
my $total = 0;

my $start = [Time::HiRes::gettimeofday];

my $hash = {};

while (<$FILE>) {
   
    if($_ =~ /^s\s(\d*)\s(\d*)/) {
        print 's ', $1, ' ',$2, "\n";
        $hash->{$1} = $2;
    }
    elsif($_ =~ /^f\s(\d*)/) {
        print 'f ', $1, "\n";
        my $result = $hash->{$1} || 0;
        $total += $result;
    } 

}

my $elapsed = Time::HiRes::tv_interval($start, [Time::HiRes::gettimeofday]);
print 'total: ', $total;
print "\n";
print 'elapsed: ', $elapsed;
