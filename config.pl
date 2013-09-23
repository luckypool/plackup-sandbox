use utf8;
use FindBin;
+{
    'plackup-a' => {
        cpanfile => $FindBin::Bin . '/modules/plackup-a/cpanfile',
        psgi     => $FindBin::Bin . '/modules/plackup-a/app.psgi',
        port     => 8001,
    },
    'plackup-b' => {
        cpanfile => $FindBin::Bin . '/modules/plackup-b/cpanfile',
        psgi     => $FindBin::Bin . '/modules/plackup-b/app.psgi',
        port     => 8002,
    },
};
