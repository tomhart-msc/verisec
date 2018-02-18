#!/usr/bin/perl -w

use strict;

my $STUBS;
my $APPS;
my $LIST;

if (!($STUBS = $ENV{'STUBS'})) { die "STUBS ain't set!"; }
if (!($APPS = $ENV{'APPS'})) { die "APPS ain't set!"; }

$LIST = shift @ARGV or die "Gimme a list!";

open (LIST, "<$LIST") or die "Can't open $LIST";
while (<LIST>)
{
  my @files = split;
  my $base = $files[0];
  $base =~ s/^$APPS//; # strip prefix to apps
  $base =~ s/^[.\/]*//; # strip leading dots and slash
  my ($testset, $testcase) = (split '/', $base)[2,3];
  $testcase =~ s/\.c$//; # strip trailing (-labeled)?.c
  my $project = "$testset-$testcase";

  my @args = ("csurf", "gcc", "-o", $project);
  push @args, @files;
  push @args, $STUBS;
  system (@args);
  die "Failed to compile project $project" unless ([-f "$project.prj"]);
}
close (LIST);
