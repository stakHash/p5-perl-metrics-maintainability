package Perl::Metrics::Maintainability;
use strict;
use warnings;

use Moo;
use Perl::Metrics::Simple;
use Perl::Metrics::Maintainability::File;
use Perl::Metrics::Maintainability::Result;

use namespace::clean;

our $VERSION = 0.10;

has paths => (
    is => 'ro',
    required => 1,
);

has analyzer => (
    is => 'lazy',
    builder => 1,
);

sub _build_analyzer {
    my ($self) = @_;
    return Perl::Metrics::Simple->new();
}

sub analyze {
    my ($self) = @_;

    my $results = [grep { defined $_ } map {
        Perl::Metrics::Maintainability::File->new(
            path => $_,
            analyzer => $self->analyzer,
        )->analyze
    } $self->analyzer->list_perl_files(@{$self->paths})];

    return Perl::Metrics::Maintainability::Result->new(results => $results);
}

1;
__END__

=head1 NAME

Perl::Metrics::Maintainability - Analyze maintainability index of Perl files.

=cut
