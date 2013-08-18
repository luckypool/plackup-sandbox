#/usr/bin/env perl
use 5.16.0;
use common::sense;

use FindBin;
use Carton::CLI;
use Config::PL;

my $config = config_do 'config.pl';

foreach my $key ( keys %$config ) {
    my $target = $config->{$key};
    my @options = qw(install --cpanfile), $target->{cpanfile};
    Carton::CLI->new->run(@options);
}

say "done!";

