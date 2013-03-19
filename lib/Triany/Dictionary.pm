package Triany::Dictionary;
use strict;
use warnings;
use parent 'Triany::Low';
use constant TABLE_SIZE => 6000;

sub _hash { return $_[0] % TABLE_SIZE + 1; }

sub find_entry {
    my ($self, $key) = @_;

    my $bucket = _hash($key);

    ### bucket 自体が存在していない場合
    if( not defined $self->get_a($bucket)) {
        return 0; 
    }

    ### bucket の先頭で key が存在している場合
    if ( $self->get_a($bucket) == $key ) {
        return $self->get_b($bucket);
    }
       
    ### bucket の先頭で終端
    if ( $self->get_c($bucket) == 0 ) {
        return 0;
    }

    ### bucket の先頭以降を走査
    my $triany = $self->get_c($bucket);
    while ( $triany != 0 ) {
        
        #$triany = $self->get_c($bucket);

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
   
    my $bucket = _hash($key);

    ### bucket が存在していない場合は作成する
    if ( not defined $self->get_a($bucket) ) {

        my $triany;

        while (not defined $self->get_a($bucket)) {
            $triany = $self->allocate_triany();
        }

        $self->set_a($triany, $key);
        $self->set_b($triany, $value);
        $self->set_c($triany, 0);
    
        return;
    }

    ### bucket の 先頭に key が存在する場合
    if ( $self->get_a($bucket) == $key ) {
        $self->set_b($bucket, $value);
        return;
    }
   
    ### bucket の先頭で終端の場合
    if ( $self->get_c($bucket) == 0 ) {
        
        my $new_triany = $self->allocate_triany();

        $self->set_c($bucket, $new_triany);

        $self->set_a($new_triany, $key);
        $self->set_b($new_triany, $value);
        $self->set_c($new_triany, 0);

        return;
    }

    ### bucket の次のリンク以降を走査
    my $triany = $self->get_c($bucket);
    my $_triany = $self->root_triany();
    
    while ( $triany != 0 ) {

        if($self->get_a($triany) == $key) {

            $self->set_b($triany, $value);
            return;
        }
        else {
            $_triany = $triany;
            $triany = $self->get_c($triany);
        }

    }
    
    ### 走査しても見つからずリストの終端になったケース 
    my $new_triany = $self->allocate_triany();

    $self->set_c($_triany, $new_triany);

    $self->set_a($new_triany, $key);
    $self->set_b($new_triany, $value);
    $self->set_c($new_triany, 0);

    return;
}

1;
