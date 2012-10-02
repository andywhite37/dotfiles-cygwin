#! /usr/bin/env python

import os, sys

bigfiles = []

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

revcount = os.popen('git rev-list HEAD | wc -l')
print "Revision count: %s" % revount
revisionNumber = 0;

for revision in os.popen('git rev-list HEAD'):
    print "Processing revision %s" % revisionNumber

    for f in os.popen('git ls-tree -zrl %s' % revision).read().split('\0'):
        if f:
            mode, type, commit, size, path = f.split(None, 4)

            if is_number(size):
                #print "mode = %s" % mode
                #print "type = %s" % type
                #print "commit = %s" % commit
                #print "size = %s" % size
                #print "path = %s" % path
                #if int(size) > int(sys.argv[1]):
                bigfiles.append((int(size), commit, path))

    revisionNumber+=1

for f in sorted(set(bigfiles)):
    print f
