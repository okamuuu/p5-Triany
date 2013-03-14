#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Data::Dumper;
use Test::More;

BEGIN { use_ok 'Triany::Low' }
   
subtest 'setup_list' => sub {

    my $x = Triany::Low->root_triany();
    my $y = Triany::Low->allocate_triany();
    my $z = Triany::Low->allocate_triany();

    Triany::Low->set_a($x, 31);
    Triany::Low->set_b($x, 41);
    Triany::Low->set_c($x, $y);

    Triany::Low->set_a($y, 59);
    Triany::Low->set_b($y, 26);
    Triany::Low->set_c($y, $z);

    Triany::Low->set_a($z, 53);
    Triany::Low->set_b($z, 58);
    Triany::Low->set_c($z,  0);
    
    my $t = Triany::Low->root_triany();
   
    my @results = ();
    while ( $t != 0 ) {
        push @results, Triany::Low->get_a($t);
        push @results, Triany::Low->get_b($t);
        $t = Triany::Low->get_c($t);
    }

    is_deeply(\@results, [31,41,59,26,53,58]);
};

done_testing();
