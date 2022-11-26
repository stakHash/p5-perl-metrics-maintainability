package Perl::Metrics::Maintainability::File;
use v5.36;
use strict;
use warnings;

use Moo;
use List::AllUtils qw/max/;
use Perl::Metrics::Halstead;
use Perl::Metrics::Maintainability::File::Result;

use namespace::clean;

has path => (
    is => 'ro',
    required => 1,
);

has analyzer => (
    is => 'ro',
    required => 1,
);

sub analyze {
    my ($self,) = @_;

    my $volume;
    eval {
        $volume = Perl::Metrics::Halstead->new(file => $self->path)->volume;
    };
    return if $@;

    my $analysis = $self->analyzer->analyze_files($self->path);

    my $loc = $analysis->lines;
    my $cc  = $self->_calc_cc($analysis);
    my $mi  = $self->_calc_mi($volume, $cc, $loc);

    return Perl::Metrics::Maintainability::File::Result->new(
        mi     => $mi,
        loc    => $loc,
        cc     => $cc,
        volume => $volume,
        path   => $self->path,
    );
}

sub _calc_cc {
    my ($self, $analysis) = @_;

    my $main_max_cc = $analysis->summary_stats->{main_complexity}->{max} // 0;
    my $sub_max_cc  = $analysis->summary_stats->{sub_complexity}->{max} // 0;
    return max($main_max_cc, $sub_max_cc);
}

# https://docs.microsoft.com/ja-jp/visualstudio/code-quality/code-metrics-maintainability-index-range-and-meaning?view=vs-2022
sub _calc_mi {
    my ($self, $volume, $cc, $loc) = @_;
    return max(0, (171 - 5.2 * log($volume) - 0.23 * $cc - 16.2 * log($loc)) * 100 / 171);
}

1;
__END__

=head1 NAME

Perl::Metrics::Maintainability::File - Analyze maintainability index of a Perl file.

=cut
