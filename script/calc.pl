#!/usr/bin/env perl
use strict;
use warnings;
use Carp ();
use Time::HiRes ();
use lib 'lib';
use Triany::Dictionary;

my $filename = 'data/testdata.txt';

open my $FILE, '<', $filename or Carp::croak "Can\'t open '$filename': $@";

my $triany = Triany::Dictionary->new();

my $total = 0;

my $start = [Time::HiRes::gettimeofday];

while (<$FILE>) {
   
    if($_ =~ /^s\s(\d*)\s(\d*)/) {
        print 's ', $1, ' ',$2, "\n";
        $triany->set_entry($1, $2);
    }
    elsif($_ =~ /^f\s(\d*)/) {
        print 'f ', $1, "\n";
        my $result = $triany->find_entry($1);
        $total += $result;
    } 

}

my $elapsed = Time::HiRes::tv_interval($start, [Time::HiRes::gettimeofday]);
print 'total: ', $total, "\n";
print 'elapsed: ', $elapsed, "\n";

