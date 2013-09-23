#/usr/bin/env perl
use common::sense;
use Config::PL;
use Plack::Runner;
use Proclet;

my $proclet = Proclet->new;
my $config  = do 'config.pl';

foreach my $child ( keys %$config ) {
    my $target = $config->{$child};
    $proclet->service(
        tag  => $child,
        code => sub {
            my $runner = Plack::Runner->new();
            my @port_and_app = ('-p', $target->{port}, '-a', $target->{psgi});
            $runner->parse_options(qw/-s Starlet --max-workers 30/, @port_and_app);
            $runner->run();
        },
    );
}
$proclet->run;
