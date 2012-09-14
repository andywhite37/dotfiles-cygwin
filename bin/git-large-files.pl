#! /usr/bin/perl -w

use strict;
use warnings;

my @revList = `git rev-list HEAD`;
chomp @revList;

print "Revs: $#revList\n";

foreach my $rev (@revList)
{
    print "rev = $rev\n";
}
