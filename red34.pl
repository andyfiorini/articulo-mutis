#!/usr/bin/perl 
#
# Autor: Andres Garcia Fiorini
# Fecha: 13/06/2020 
#
use CAM::PDF;
use CAM::PDF::PageText;
use utf8;
use locale;
use POSIX qw(locale_h);
use Encode;

setlocale(LC_CTYPE, "sp.ISO8859-1");

binmode (TXT, 'utf8');
binmode (STDOUT, 'utf8');


my %dest = ();
my %dest_arch = ();
my $carta_regex = qr/carta\-\d{1,3}\.txt/mip;
#my $carta_regex = qr/\d{4}\.txt.f.txt/mp;
@list=(1,2);

open(IND, "<", $ARGV[0]);
while( <IND> ) {
  chomp;
  $regex_nombre = qr/$_/i;
  $nombre = "$_";
  chomp $nombre;
  chomp $regex_nombre;

for ($dir = 3; $dir < 5; $dir++ ) {
#  $dir = "decadas";
  opendir(my $dh, $dir) || die "Can't open $i: $!";


  while (readdir $dh) {
      $txt_file = $dir . "/"  . $_;
      if ( $txt_file =~ $carta_regex ) {
      open(TXT, "<", "$txt_file");
           while ( <TXT> ) {
               if ( /$regex_nombre/ ) {

                    chomp;
		    #print "OPEN: $txt_file | encontrado";
		    $dest{ $nombre } = int($dest{$nombre}) + 1;

                    $new_val = $dest_arch{ $nombre };
		    $new_val = $new_val . ":$txt_file";
		    $dest_arch{ $nombre } = $new_val;

              }
	  }
     close(TXT);
    }
  }
closedir($dh);
}
}
close(IND);
print "Frecuencia por apellido:\n";
print "========================\n";
foreach $key (%dest) {
  print "|$key|:|$dest{ $key }|\n";
}
print "Archivos por apellido:\n";
print "======================\n";
foreach $key (%dest_arch) {
  print "$key:$dest_arch{$key}\n";
}
