package Triany::Dictionary;
use strict;
use warnings;
use parent 'Triany::Low';
use constant TABLE_SIZE => 100_000;

sub _hash { return $_[0] % TABLE_SIZE + 1; }

sub _found_bucket { return defined $_[0]->get_a($_[1]) ? 1 : 0 }

sub _get_next_triany { return $_[0]->get_c($_[1]); }

sub find_entry {
    my ($self, $key) = @_;

    my $triany = _hash($key);

    ### 連結リストの終端まで走査
    ### すでに終端の場合は走査しない
    ### key が存在すれば value を返す
    ### key が存在しない場合は 0 を返す
    while ( $triany != 0 ) {
        
        if($self->get_a($triany) == $key) {
            return $self->get_b($triany);
        }

        $triany = $self->_get_next_triany($triany);
    }
    
    return 0;
}

sub set_entry {
    my ($self, $key, $value) = @_;
   
    my $triany = _hash($key);

    if ( not $self->_found_bucket($triany) ) {
        $self->_create_bucket($triany, $key, $value);
        return;
    }

    ### 走査
    my $next_triany;
    while (1) {
        
        return if $self->_find_and_update($triany, $key, $value);

        $next_triany = $self->_get_next_triany($triany);

        last if not $next_triany;

        $triany = $next_triany;
    }
    
    ### 走査しても見つからずリストの終端になったケース 
    $self->_add_chain($triany, $key, $value);

    return;
}

sub _add_chain {
    my ($self, $pre_triany, $key, $value) = @_;

    my $new_triany = $self->allocate_triany();

    $self->set_c($pre_triany, $new_triany);

    $self->set_a($new_triany, $key);
    $self->set_b($new_triany, $value);
    $self->set_c($new_triany, 0);

    return;
}

sub _create_bucket {
    my ($self, $triany, $key, $value) = @_;
        
    my $_triany;
    
    while (not defined $self->get_a($triany)) {
        $_triany = $self->allocate_triany();
    }

    $self->_add_chain($_triany, $key, $value);

    return $_triany;
}

sub _find_and_update {
    my ($self, $triany, $key, $value) = @_;

    if($self->get_a($triany) == $key) {

        $self->set_b($triany, $value);
        return 1;
    }
    
    return; 
}

1;
