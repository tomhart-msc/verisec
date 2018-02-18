#!/usr/bin/perl -w

# Prints the master list of testcases for the verisec suite, one per line,
# possibly with base file. 
#
# Example compilation units:
# 1. apache/CVE-2004-0940/get_tag/iter1_prefixLong_arr_bad.c \
# apache/CVE-2004-0940/apache.c
# 2. edbrowse/CVE-2006-6909/ftpls/no_strcmp_bad.c

use strict;
use Cwd 'abs_path';

my @IGNORE = qw(/complete/ /mapping_chdir/);

# Drops the last part of a pathname
sub chop_path
{
  my $path = shift;
  my @path_parts = split '/', $path;
  return (join '/', @path_parts[0..$#path_parts-1]);
}

sub substr_array
{
  my $hs = shift;
  my $needles = shift;
  foreach my $n (@$needles)
  {
    return 1 if ($hs =~ /$n/);
  }
  return 0;
}

my @basefiles = map { chomp; $_; } `find . -mindepth 3 -maxdepth 3 -name '*.c'`;
my @testcases = map { chomp; $_; } `find . -mindepth 4 -maxdepth 4 -name '*.c'`;

my %testset_base;

# Build map from testset to base file (e.g., bind/CA-1999-14 =>
# bind/CA-1999-14/bind.c)
foreach my $bf (@basefiles)
{
  $testset_base{chop_path($bf)} = $bf;
}

# Print each testcase possibly with base file, one per line
foreach my $tc (@testcases)
{
  next if (substr_array ($tc, \@IGNORE));

  print abs_path($tc);
  my $testset = chop_path(chop_path($tc));
  if (defined $testset_base{$testset})
  {
    print " " . abs_path($testset_base{$testset});
  }
  print "\n";
}
