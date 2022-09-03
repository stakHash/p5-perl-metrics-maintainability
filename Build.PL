use strict;
use warnings;
use Module::Build;

# See perldoc Module::Build for details of how this works

Module::Build->new(
    module_name        => 'Perl::Metrics::Maintainability',
    license            => 'perl',
    configure_requires => { 'Module::Build' => 0.42 },
    requires           => {
        'Moo'                     => 2.0,
        'List::AllUtils'          => 0.19,
        'Getopt::Long'            => 2.52,
        'Perl::Metrics::Halstead' => 0.06,
        'Perl::Metrics::Simple'   => 'v1.0.1',
    },
    build_requires => {
        'Module::Build' => 0.42,
    },
    script_files => { 'bin/perlmi' => 1, },
    add_to_cleanup => [ '*.tar.gz', 'Makefile', 'Makefile.old' ],
    meta_merge     => {
        resources => {
                repository =>  'https://github.com/stakHash/p5-perl-metrics-maintainability',
                bugtracker =>  'https://github.com/stakHash/p5-perl-metrics-maintainability/issues',
            },
    },
)->create_build_script;
