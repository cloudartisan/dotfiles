#!/usr/bin/perl

use Socket;

my @t = gethostbyname($ARGV[0]);
print "\$name     = $t[0]\n"; shift(@t);
print "\$aliases  = $t[0]\n"; shift(@t);
print "\$addrtype = $t[0]\n"; shift(@t);
print "\$length   = $t[0]\n"; shift(@t);

foreach (@t) {
  print "          = ", inet_ntoa($_), "\n";
}
