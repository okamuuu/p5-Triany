package Triany::Dictionary;
use strict;
use warnings;
use parent 'Triany::Low';

sub find_entry {
    my ($self, $key) = @_;

    my $triany = $self->root_triany();

    while($triany != 0) {
        
        if($self->get_a($triany) == $key) {
            return $self->get_b($triany);
        }
        else {
            $triany = $self->get_c($triany);
        }

    }
    
    return 0;
}

sub set_entry {
    my ($self, $key, $value) = @_;

    my $triany = $self->root_triany();
    my $_triany = $self->root_triany();    
    while($triany != 0) {
    
        if($self->get_a($triany) == $key) {
            return $self->set_b($triany, $value);
        }
        else {
            $triany = $self->get_c($triany);
            if($triany!=0) {
                $_triany = $triany;
            }
        }
    }

    my $new_triany = $self->allocate_triany();

    $self->set_c($_triany, $new_triany);

    $self->set_a($new_triany, $key);
    $self->set_b($new_triany, $value);
    $self->set_c($new_triany, 0);

    return;
}

1;
