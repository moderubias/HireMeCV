use strict;
use warnings;

use Cwd qw(abs_path);
use File::Basename qw(dirname);
use File::Spec;

my $ROOT = abs_path(dirname(__FILE__));

package Compiler {
    use constant {
        PdfLaTeX => 1,
        LuaLaTeX => 4,
        XeLaTeX  => 5,
    };
}

package BuildMode {
    use constant {
        Draft   => 'draft',
        Release => 'release',
        CI      => 'ci',
    };
}

package main;

sub project_root {
    my ($source) = @_;

    my $path = File::Spec->rel2abs($source);
    return dirname($path);
}

my $mode = BuildMode::Draft;
my $BUILD = File::Spec->catdir($PROJECT, 'build');

$out_dir = $BUILD;
$aux_dir = $BUILD;

$pdf_mode = Compiler::LuaLaTeX;

if ($mode eq BuildMode::Draft) {
    $interaction = 'nonstopmode';
    $halt_on_error = 0;
}
elsif ($mode eq BuildMode::Release) {
    $interaction = 'nonstopmode';
    $halt_on_error = 1;
}
elsif ($mode eq BuildMode::CI) {
    $interaction = 'nonstopmode';
    $halt_on_error = 1;
}

$ENV{TEXINPUTS} = join ':',
    File::Spec->catdir($ROOT, 'shared', 'styles')  . '//',
    File::Spec->catdir($ROOT, 'shared', 'classes') . '//',
    File::Spec->catdir($ROOT, 'shared', 'modules') . '//',
    ($ENV{TEXINPUTS} // '');

$ENV{BIBINPUTS} = join ':',
    File::Spec->catdir($ROOT, 'shared', 'bib') . '//',
    ($ENV{BIBINPUTS} // '');
