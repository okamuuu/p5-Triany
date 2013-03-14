package Triany::Low;
use strict;
use warnings;

my @Memory = ([],[0, 0, 0]);

sub root_triany { return 1; }

sub allocate_triany {

    my $id = $#Memory + 1;

    $Memory[$id] = [0, 0, 0];

    return $id;
}

sub set_a {
    my ($class, $id, $value) = @_;

    if ( $Memory[$id] ) {
        $Memory[$id][0] = $value;
    }
}

sub set_b {
    my ($class, $id, $value) = @_;

    if ( $Memory[$id] ) {
        $Memory[$id][1] = $value;
    }
}

sub set_c {
    my ($class, $id, $value) = @_;

    if ( $Memory[$id] ) {
        $Memory[$id][2] = $value;
    }
}

sub get_a { 
    my ($class, $id) = @_;

    if ( $Memory[$id] ) {
        return $Memory[$id][0];
    }
}

sub get_b { 
    my ($class, $id) = @_;

    if ( $Memory[$id] ) {
        return $Memory[$id][1];
    }
}

sub get_c { 
    my ($class, $id) = @_;

    if ( $Memory[$id] ) {
        return $Memory[$id][2];
    }
}

1;
