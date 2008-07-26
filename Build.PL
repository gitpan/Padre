use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name           => 'Padre',
    license               => 'perl',
    dist_author           => 'Gabor Szabo',
    create_makefile_pl    => 'traditional',
    create_readme         => 0,
    recursive_test_files  => 0,
    script_files          => [qw(bin/padre)],
    requires              => {
        'perl'                    => '5.006',

        'Carp'                    => 0,
        'Cwd'                     => 0,
        'Data::Dumper'            => 0,
        'File::HomeDir'           => 0,
        'File::Spec::Functions'   => 0,
        'Getopt::Long'            => 0,
        'List::Util'              => 0,

        'Class::Accessor'         => 0,
        'File::Slurp'             => 0,
        'DBD::SQLite'             => 0,
        'DBI'                     => 0,
        'Pod::POM'                => 0,
        'YAML'                    => 0,
        'Wx'                      => 0,
        'Wx::Perl::ProcessStream' => 0,
    },
    build_requires        => {
        'Test::More'                => '0.47',
        'Test::Exception'           => 0,
        'Test::NoWarnings'          => 0,
    },
);

$builder->create_build_script();
