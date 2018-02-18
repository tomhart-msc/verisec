#!/usr/bin/perl

# Labels vulnerable statements in verisec testcases with VULN1, VULN2, etc.

my $MASTER = "master_list";

sub label
{
  my $tc = shift;
  my $vuln = 0;
  my $vuln_idx = 1;
  my $labeled_path;

  $tc =~ m#^(.+)\.c$#;
  $labeled_path = "$1-labeled.c";

#  print "$tc\n";
#  print "$labeled_path\n";

  open (TC, "<$tc") or die "Unable to open $tc";
  open (LTC, ">$labeled_path");
  while (<TC>)
  {
    if (m#\/\*.*(BAD|OK).*\*\/#)
    {
      $vuln = 1;
      next;
    }

    if ($vuln)
    {
      print LTC "VULN$vuln_idx: $_"; # newline is intact
      $vuln = 0;
      $vuln_idx++;
    }
    else
    {
      print LTC $_;
    }
  }
  close (LTC);
  close (TC);
}

open (MASTER, "<$MASTER");
while (<MASTER>)
{
  my $tc = (split)[0];
  label ($tc);
}
close (MASTER);
