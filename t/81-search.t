#!/usr/bin/perl

use strict;
use warnings;


use Test::More;
use t::lib::Padre;
use Padre::Util 'get_matches';

my $tests;
plan tests => $tests;

SCOPE: {
    my ($start, $end, @matches) = get_matches("abc", qr/x/, 0, 0);
    is_deeply(\@matches, [], 'no match');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abc", qr/b/, 0, 0);
    is_deeply(\@matches, [ 1, 2, [1,2] ], 'one match');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abcbxb", qr/b/, 0, 0);
    is_deeply(\@matches, [ 1, 2, [1,2], [3,4], [5,6] ], 'three matches');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abcbxb", qr/b/, 1, 2);
    is_deeply(\@matches, [ 3, 4, [1,2], [3,4], [5,6] ], 'three matches');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abcbxb", qr/b/, 3, 4);
    is_deeply(\@matches, [ 5, 6, [1,2], [3,4], [5,6] ], 'three matches');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abcbxb", qr/b/, 5, 6);
    is_deeply(\@matches, [ 1, 2, [1,2], [3,4], [5,6] ], 'three matches, wrapping');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abcbxb", qr/b/, 5, 6, 1);
    is_deeply(\@matches, [ 3, 4, [1,2], [3,4], [5,6] ], 'three matches backwards');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abcbxb", qr/b/, 1, 2, 1);
    is_deeply(\@matches, [ 5, 6, [1,2], [3,4], [5,6] ], 'three matches backwards wrapping');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abcbxb", qr/b(.)/, 1, 2);
    is_deeply(\@matches, [ 3, 5, [1,3], [3,5] ], '2 matches');
    BEGIN { $tests += 1; }
}

SCOPE: {
    my (@matches) = get_matches("abcbxb", qr/b(.?)/, 1, 2, 1);
    is_deeply(\@matches, [ 5, 6, [1,3], [3,5], [5,6] ], 'three matches bw, wrap');
    BEGIN { $tests += 1; }
}
