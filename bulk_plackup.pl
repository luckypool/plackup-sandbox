#/usr/bin/env perl
use 5.16.0;
use common::sense;

use FindBin;
use Config::PL;
use Plack::Runner;
use Parallel::ForkManager;

my $config = config_do 'config.pl';

my $max_procs = 10;
my $pm = Parallel::ForkManager->new($max_procs);

$pm->run_on_start(
    sub {
        my ($pid, $ident) = @_;
        say "** $ident started, pid: $pid";
    }
);

foreach my $child ( keys %$config ) {
    my $target = $config->{$child};
    my $pid = $pm->start($target->{name}) and next;

    # This code is the child process
    my $runner = Plack::Runner->new();
    my @port_and_app = ('-p', $target->{port}, '-a', $target->{psgi});
    $runner->parse_options(qw/-s Starlet --max-workers 30/, @port_and_app);
    $runner->run();

    $pm->finish($child); # pass an exit code to finish
}

say "Waiting for Children...";
$pm->wait_all_children;
say "Everybody is out of the pool!";

