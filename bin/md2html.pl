#! /usr/bin/perl -w
use strict;
use warnings;

foreach my $fileName (@ARGV) {
    chomp $fileName;

    system "pandoc.exe $fileName -o $fileName.html\n";

}
