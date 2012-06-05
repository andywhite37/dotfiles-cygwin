#! /usr/bin/perl -w
use strict;
use warnings;

my @files = `ls *.sql`;
chomp @files;

my $database = "Oracle";

foreach my $file (@files)
{
    #print "${file}\n";
    print "<File Id=\"${database}${file}\" Name=\"${database}${file}\" Source=\"\$(var.BDSI_AM_INVENTORY.TargetDir)..\\..\\..\\Infor\\8.3\\${database}\\CustomDataSpies\\${file}\" DiskId=\"1\" Checksum=\"yes\"/>\n";
}
