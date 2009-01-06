#!perl -T
use Test::More tests => 1;
use Tkx;
use Tkx::ROText;

my $mw     = Tkx::widget->new('.');
my $rotext = $mw->new_tkx_ROText();

$rotext->insert('end', "The quick brown fox jumped over the lazy dog.\n");
$rotext->delete('1.4', '1.9');
$rotext->insert('1.4', 'sly');

is($rotext->get('1.0', '2.0 - 1 chars'), 'The sly brown fox jumped over the lazy dog.', 'edit');
