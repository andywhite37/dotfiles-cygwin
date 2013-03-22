#! /usr/bin/env perl

use strict;
use warnings;

my @branches = @ARGV;

if (scalar @branches == 0)
{
    print "No branches to archive";
    exit;
}
    
foreach my $branch (@branches)
{
    print "Would you like to tag the branch: $branch? y/n: ";
    my $tagAnswer = <STDIN>;
    chomp $tagAnswer;

    if ($tagAnswer eq "y")
    {
        print "git tag -a -m 'Archiving legacy $branch' archived-branch-$branch origin/$branch\n";
        system "git tag -a -m 'Archiving legacy $branch' archived-branch-$branch origin/$branch";
    }
    else
    {
        print "Not tagging origin/$branch";
    }

    print "Would you like to delete the remote branch: origin/$branch? y/n: ";
    my $deleteAnswer = <STDIN>;
    chomp $deleteAnswer;

    if ($deleteAnswer eq "y")
    {
        print "git push origin :$branch\n";
        system "git push origin :$branch";
    }
    else
    {
        print "Not deleting origin/$branch\n";
    }
}
