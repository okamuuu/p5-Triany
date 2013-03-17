package Triany::Low;
use strict;
use warnings;

my @Memory = ([],[0, 0, 0]);

sub new {
    my ($class, %args) = @_;
 
    # id: $self->[0]
    bless [1, [0, 0, 0]], $class;
}

sub root_triany { return 1; }

sub allocate_triany {
    my $self = shift;

    my $new_id = ++$self->[0];

    $self->[$new_id] = [0, 0, 0];

    return $new_id;
}

sub _set { 
    my ($self, $id, $value, $index) = @_;

    if ( $self->[$id] ) {
        $self->[$id]->[$index] = $value;
    }
}

sub set_a {
    my ($self, $id, $value) = @_;

    if ( $self->[$id] ) {
        $self->[$id]->[0] = $value;
    }
}

sub set_b {
    my ($self, $id, $value) = @_;

    if ( $self->[$id] ) {
        $self->[$id]->[1] = $value;
    }
}

sub set_c {
    my ($self, $id, $value) = @_;

    if ( $self->[$id] ) {
        $self->[$id]->[2] = $value;
    }
}

sub get_a { 
    my ($self, $id) = @_;

    if ( $self->[$id] ) {
        return $self->[$id]->[0];
    }
}

sub get_b { 
    my ($self, $id) = @_;

    if ( $self->[$id] ) {
        return $self->[$id]->[1];
    }
}

sub get_c { 
    my ($self, $id) = @_;

    if ( $self->[$id] ) {
        return $self->[$id]->[2];
    }
}

1;
