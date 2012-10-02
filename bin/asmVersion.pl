#! /usr/bin/perl -w

use strict;
use warnings;

sub usage;

my $verbose = 0;
my $onlyBlueDotAssemblies = 0;
my $showIldasmOutput = 0;

if ($#ARGV + 1 > 0)
{
    foreach my $arg (@ARGV)
    {
        if ("$arg" eq "-v")
        {
            print "Verbose output is on\n";
            $verbose = 1;
        }
        elsif ("$arg" eq "-b")
        {
            print "Only BlueDot assemblies is on\n";
            $onlyBlueDotAssemblies = 1;
        }
        elsif ("$arg" eq "-i")
        {
            print "Show ildasm output is on\n";
            $showIldasmOutput = 1;
        }
        elsif ("$arg" eq "-h")
        {
            &usage;
        }
    }
}

my @files = `find . -print | grep '\.[ed][xl][el]\$'`;
chomp @files;

if ($onlyBlueDotAssemblies)
{
    @files = grep(/.*BlueDot.*/, @files);
}

foreach my $file (@files)
{
    # Replace cygwin / path separator 
    $file =~ s/\//\\/g;

    if ($verbose)
    {
        print "File: $file\n";
    }

    my $assemblyName = `basename '$file' | sed 's/\.dll//' | sed 's/\.exe//'`;
    chomp $assemblyName;

    if ($verbose)
    {
        print "Assembly name: $assemblyName\n";
    }

    my @ildasmLines = `ildasm.exe /TEXT '$file'`;
    chomp @ildasmLines;

    my $found = 0;
    foreach my $ildasmLine (@ildasmLines)
    {
        if ($showIldasmOutput)
        {
            print "$ildasmLine\n";
        }

        if ($ildasmLine =~ /.assembly $assemblyName/i)
        {
            $found = 1;
        }

        if ($found and $ildasmLine =~ /\.ver \d*:\d*:\d*:\d*/)
        {
            print "$file - $ildasmLine\n";
            last;
        }
    }
}

sub usage()
{
    print "Usage: asmVersion.pl [-v] [-i] [-b] | [-h]\n";
    print "\n";

    print "Attempts to display the assembly version for all assemblies from the current directory and recursively downward.\n";
    print "\n";

    print "Options:\n";
    print "\n";
    print "-b - Only show assemblies with \"Blue Dot\" in the file name\n";
    print "-v - Show verbose output\n";
    print "-i - Show ildasm.exe output in full\n";
    print "-h - Show this usage message\n";
    print "\n";

    exit;
}
