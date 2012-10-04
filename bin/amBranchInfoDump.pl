#! /usr/bin/env perl

use strict;
use warnings;

my $targetBranch = 'productdev';

my @branches = `git branch -a | grep remotes/origin | grep -v remotes/origin/HEAD | grep -v remotes/origin/product | grep -v remotes/origin/master`;
chomp @branches;

foreach my $branch (@branches)
{
    $branch =~ s/^\s+//;
    $branch =~ s/\s+$//;

    print "-----------------------------------------------------------------------\n";
    print "$branch\n";
    print "-----------------------------------------------------------------------\n";

    # Show the count of commits that aren't merged
    my @commitsNotInTarget = `git log --pretty=format:'%H - %an - %s' $branch ^$targetBranch`;
    chomp @commitsNotInTarget;
    my $commitsNotInTargetCount = scalar(@commitsNotInTarget);
    print "$commitsNotInTargetCount commits in $branch not merged into $targetBranch\n";

    # Show how far behind the branch is from target branch
    my @commitsInTarget = `git log --pretty=format:'%H - %an - %s' ^$branch $targetBranch\n`;
    chomp @commitsInTarget;
    my $commitsInTargetCount = scalar(@commitsInTarget);
    print "$commitsInTargetCount commits in $targetBranch not in $branch\n";

    # Show the list of commits that aren't merged
    if ($commitsNotInTargetCount > 0)
    {
        print "Commits not merged into $targetBranch:\n";
        foreach my $commitNotInTarget (@commitsNotInTarget)
        {
            print "$commitNotInTarget\n";
        }
    }
    else
    {
        print "$branch has no commits that have not been merged into $targetBranch - can be deleted\n";

#        print "Would you like to delete the remote branch $branch? (y or n): ";
#        my $deleteAnswer = <STDIN>;
#        chomp $deleteAnswer;
#
#        if ($deleteAnswer eq "y")
#        {
#            print "You answered yes!, deleting...\n";
#            my $branchToDelete = $branch;
#            $branchToDelete =~ s/remotes\/origin\///;
#
#            print "git push origin :$branchToDelete\n";
#            system "git push origin :$branchToDelete\n";
#
#            print "Hit enter to continue...";
#            my $enter = <STDIN>;
#        }
#        else
#        {
#            print "You did not answer yes, not deleting!\n";
#        }

    }

    print "\n";
}

