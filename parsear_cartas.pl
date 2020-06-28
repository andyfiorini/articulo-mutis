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
open(TXT, ">", $ARGV[1]);

binmode (TXT, 'utf8');
binmode (STDOUT, 'utf8');

my $separador_cartas = qr/\- Del copia|\- Del original|\- Del borrador|\- De una|\- De la/up;
my $numero_carta=0;
my $titulo = "ARCHIVO EPISTOLAR";
my $indice = "ALFABETlCO";

my $pdf = CAM::PDF->new($ARGV[0]);
for my $page ($ARGV[2]..$pdf->numPages) {
  my $cartas = $pdf->getPageContentTree($page);
  $text = CAM::PDF::PageText->render($cartas);
  print TXT $text;
}

close(TXT);
open(TXT, "<", $ARGV[1]);
$prev_linea="";

while ( <TXT> ) {
  $_ =~ s/\,|\'|pues|El|\>|\<|\!|aunque//g;
  if ( $numero_carta == 0 ) {
     @tmp_arr = split('\n');
     $numero_carta = int($tmp_arr[0]);
     open(CARTA, ">", "$ARGV[3]/carta-$numero_carta.txt");
     $prev_linea = $_;
     next;
  }
  if ( $_ =~ /$indice/ ) { break; }

  if ( $_ =~ /$separador_cartas/g )  {
     if ( $_ =~ /\d{1,4} \- Del/ ) { 
       @tmp_arr = split(' ');
     } else {
       @tmp_arr = split(' ', $prev_linea);
     }
     $numero_carta = int($tmp_arr[0]);
     close(CARTA);
     open(CARTA, ">", "$ARGV[3]/carta-$numero_carta.txt");
     print CARTA $_; 
     
  } else {

      #s/\w\- \w//g;
      print CARTA $_; 

  }
  $prev_linea = $_;

}
close(CARTA);
close(TXT);
