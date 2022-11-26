package Perl::Metrics::Maintainability::Result;

use v5.36;
use strict;
use warnings;

use Moo;
use List::AllUtils qw/all nsort_by rev_nsort_by/;
use namespace::clean;
our $VERSION = 0.10;

has results => (
    is => 'rwp',
    isa => sub {
        my $type = ref $_[0];
        die 'results must be ARREYREF of Perl::Metrics::Maintainability::File::Result'
            unless defined $type
                && $type eq 'ARRAY'
                && all { $_->meta->name eq 'Perl::Metrics::Maintainability::File::Result' } @{$_[0]}
    },
    required => 1,
);

sub has_results {
    my ($self,) = @_;
    return scalar(grep { $_->is_valid } @{$self->results}) > 0
}

sub sort {
    my ($self, $key, $direction) = @_;

    $self->_set_results([
        $direction eq 'desc'
            ? rev_nsort_by { $_->$key } @{$self->results}
            : nsort_by { $_->$key } @{$self->results}
    ]);

    return $self;
}

sub inflate_text {
    my ($self,) = @_;
    my $text = "MI\tLoC\tcc\tvolume\t\tpath\n--------------------------------------------------------------------------------\n";
    for my $result (@{$self->results}) {
        $text = $text . sprintf(
            "%0.2f\t%d\t%d\t%0.2f\t\t%s\n",
            $result->mi,
            $result->loc,
            $result->cc,
            $result->volume,
            $result->path,
        );
    }
    return $text;
}

1;
__END__

=head1 NAME

Perl::Metrics::Maintainability::Result - Contains analysis result.

=cut
