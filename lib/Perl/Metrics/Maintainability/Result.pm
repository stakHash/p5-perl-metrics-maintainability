package Perl::Metrics::Maintainability::Result;

use v5.36;
use strict;
use warnings;

use Moo;
use Scalar::Util qw/looks_like_number/;

use namespace::clean;

our $VERSION = 0.10;

has mi => (
    is  => 'ro',
    isa => sub {
        die "$_[0] must be a number between 0 and 100"
            unless looks_like_number($_[0]) && $_[0] >= 0 && $_[0] <= 100;
    },
    required => 1,
);

has loc => (
    is  => 'ro',
    isa => sub {
        die "$_[0] must be a number larger than 0"
            unless looks_like_number($_[0]) && $_[0] > 0;
    },
    required => 1,
);

has volume => (
    is  => 'ro',
    isa => sub {
        die "$_[0] must be a number larger than 0"
            unless looks_like_number($_[0]) && $_[0] > 0;
    },
    required => 1,
);

has cc => (
    is  => 'ro',
    isa => sub {
        die "$_[0] must be a number larger than 0"
            unless looks_like_number($_[0]) && $_[0] > 0;
    },
    required => 1,
);

has path => (
    is  => 'ro',
    required => 1,
);

1;
__END__

=head1 NAME

Perl::Metrics::Maintainability::Result - Contains analysis result.

=cut
