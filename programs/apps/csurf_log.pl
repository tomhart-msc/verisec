#!/usr/bin/perl -w

# Parses output from csurf_run.sh into csv form

my $in = shift @ARGV or die "Gimme a .log!";
open (LOG, "<$in");

while (<LOG>)
{
  if (/=== (.+) ===/)
  {
    $proj = $1;
    $proj =~ s/_(bad|ok)-labeled.prj//;
    $badok = $1;
  }
  if (/avg. max length: ([0-9.]+)/)
  {
    next if ($proj =~ /inlined/);
    $avg_max_len = $1;
    print "$proj,";
    print (($badok eq "ok") ? "safe" : "unsafe");
    print ",";
    print "$avg_max_len\n";
  }
}

close (LOG);
