#!perl -w

# $Id: pod.t 3723 2008-05-03 16:04:37Z david $

use strict;
use Test::More;
eval 'use Test::Pod 1.20';
plan skip_all => 'Test::Pod 1.20 required for testing POD' if $@;
eval 'use Encode';
plan skip_all => 'Encode 1.20 required for testing POD because it has UTF-8 charactters' if $@;
all_pod_files_ok();
