#!/rfs/apps/bin/perl5.6.1
BEGIN {require 5.006}
use strict;
use warnings;
use lib '../lib';
use Tkx;
use Tkx::ROText;
Tkx::package_require('tile');

my $textstate;

my $mw = Tkx::widget->new('.');
$mw->g_wm_title("Tkx::ROText v $Tkx::ROText::VERSION");
Tkx::bind('<Control-w>', $mw, sub {$mw->destroy});

my $f = $mw->new_frame(-relief => 'flat');
$f->g_pack(-side => 'bottom', -padx => 5, -pady => 5, -fill => 'x');

my $tw= $mw->new_tkx_ROText(-font => 'Consolas 12');

my $cb = $mw->new_ttk__combobox(
	-width        => 20,
	-state        => 'readonly',
	-textvariable => \$textstate,
	-values       => [qw'normal disabled readonly zzz'],
);

Tkx::bind($cb, '<<ComboboxSelected>>', sub { $tw->configure(-state => $textstate) });

$textstate = $tw->cget(-state);

$cb->g_pack(-anchor => 'w');
$tw->g_pack(-side => 'top', -fill => 'both', -expand => 1);

$tw->insert('end', "Now is the time for all good men to come to the aid of their country.\n");
$tw->insert('1.0', "The quick brown fox jumped over the lazy dog.\n");
$tw->delete('2.11', '2.15');
$tw->insert('2.11', 'tuna');

$tw->configure(-foreground => 'red');

$mw->g_focus;
Tkx::MainLoop();
