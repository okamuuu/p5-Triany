#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Data::Dumper;
use Test::More;

BEGIN { use_ok 'Triany::Low' }
   
subtest 'setup_list' => sub {

    my $lowTriany = Triany::Low->new();

    my $x = $lowTriany->root_triany();
    my $y = $lowTriany->allocate_triany();
    my $z = $lowTriany->allocate_triany();

    $lowTriany->set_a($x, 31);
    $lowTriany->set_b($x, 41);
    $lowTriany->set_c($x, $y);

    $lowTriany->set_a($y, 59);
    $lowTriany->set_b($y, 26);
    $lowTriany->set_c($y, $z);

    $lowTriany->set_a($z, 53);
    $lowTriany->set_b($z, 58);
    $lowTriany->set_c($z,  0);
    
    my $t = $lowTriany->root_triany();
   
    my @results = ();
    while ( $t != 0 ) {
        push @results, $lowTriany->get_a($t);
        push @results, $lowTriany->get_b($t);
        $t = $lowTriany->get_c($t);
    }

    is_deeply(\@results, [31,41,59,26,53,58]);
};

done_testing();
