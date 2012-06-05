#! /usr/bin/perl -w

use strict;
use warnings;

print "File: $ARGV[0]\n";

open FILE, "$ARGV[0]" or die $!;

my $startTime;

my $authorizationStartTime;
my $authorizationEndTime;

my $populateInfrastructureStartTime;

my $requestDataStartTime;
my $receiveDataStartTime;

my @processMessageStartTimes;
my @processMessageEndTimes;
my @messageProcessingTimes;
my $messagesProcessed = 0;

my $endTime;

my $totalTime;

while (my $line = <FILE>)
{
    if ($line =~ /.*Entering GetDatabase/)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\]/;
        $startTime = $1;
    }
    if ($line =~ /Authorizing User: /)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\]/;
        $authorizationStartTime = $1;
    }
    if ($line =~ /Authorized Plant: /)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\]/;
        $authorizationEndTime = $1;
    }
    if ($line =~ /Populating infrastructure data/)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\]/;
        $populateInfrastructureStartTime = $1;
    }
    if ($line =~ /Requesting.*data.../)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\]/;
        $requestDataStartTime = $1;
    }
    if ($line =~ /Attempting to receive all data/)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\]/;
        $receiveDataStartTime = $1;
    }
    if ($line =~ /Processing message:/)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\]/;
        push(@processMessageStartTimes, $1);
    }
    if ($line =~ /Processing complete:/)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\].*Processing complete: (.*) seconds/;
        print "Message processing time: $2\n";
        push(@processMessageEndTimes, $1);
        push(@messageProcessingTimes, $2);
        $messagesProcessed++;
    }
    if ($line =~ /Database stream created in/)
    {
        #print "$line\n";
        $line =~ /^\[(....-..-.. ..:..:..,...)\].*Database stream created in (.*) seconds/;
        $endTime = $1;
        $totalTime = $2;
    }
}

close FILE;

#print @processMessageStartTimes;
#print @processMessageEndTimes;
#print @messageProcessingTimes;

my $totalMessageProcessingTime = 0;
foreach my $messageProcessingTime (@messageProcessingTimes)
{
    $totalMessageProcessingTime += $messageProcessingTime;
}

my $avgMessageProcessingTime = $totalMessageProcessingTime / $messagesProcessed;

my $totalMessageProcessingTimeMinutes = $totalMessageProcessingTime / 60;
my $totalTimeMinutes = $totalTime / 60;


print "\n";
print "-----------------------------------------------------------------\n";
print "Start Time:                      $startTime\n";
print "Authorization start time:        $authorizationStartTime\n";
print "Authorization end time:          $authorizationEndTime\n";
print "Create database end time:        $populateInfrastructureStartTime\n";
print "Request all data start time:     $requestDataStartTime\n";
print "Receive all data start time:     $receiveDataStartTime\n";
print "End time:                        $endTime\n";
print "\n";
print "Total messages processed:        $messagesProcessed\n";
print "Total message processing time:   $totalMessageProcessingTime seconds ($totalMessageProcessingTimeMinutes minutes)\n";
print "Average message processing time: $avgMessageProcessingTime seconds\n";
print "\n";
print "Total time:                      $totalTime seconds ($totalTimeMinutes minutes)\n";
print "-----------------------------------------------------------------\n";


