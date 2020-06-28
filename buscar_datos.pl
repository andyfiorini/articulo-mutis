#!/usr/bin/perl
#
# Autor: Andres Garcia Fiorini
# Fecha: 13/06/2020 
#
use utf8;
use locale;
use POSIX qw(locale_h);
use Encode;
use 5.012;

setlocale(LC_CTYPE, "sp.ISO8859-1");

binmode (TXT, 'utf8');
binmode (STDOUT, 'utf8');

my $numero_carta=0;
my $titulo = "ARCHIVO EPISTOLAR";
my $i = 0;
my $lugar = "Sin Lugar";
my @lugar_fecha = [];
my $anio = "";
my $mes = "";
my $dia = "";
my $txt_file = "";
my $fh;
@176 = [] ;
@177 = [] ;
@178 = [] ;
@179 = [] ;
@180 = [] ;
@181 = [] ;
@182 = [] ;

my $carta_regex = qr/carta\-\d{1,3}\.txt/mp;
my $fecha_regex1 = qr/\,\ {1,2}\w(nero|ebrero|arzo|bril|mayo|unio|ulio|gosto|eptiembre|ctubre|oviembre|iciembre) \d{1,2} de \d{4}/mp;
my $fecha_regex2 = qr/\w(nero|ebrero|arzo|bril|mayo|unio|ulio|gosto|eptiembre|ctubre|oviembre|iciembre) de \d{4}|\w(nero|ebrero|arzo|bril|mayo|unio|ulio|gosto|eptiembre|ctubre|oviembre|iciembre) \d{1,2} de \d{4}/;

#for ( $i = 1; $i < 5; $i++ ) {
  opendir(my $dh, $ARGV[0]) || die "Can't open $i: $!";
while (readdir $dh) {
      $txt_file = $ARGV[0] . "/"  . $_;
      open(TXT, "<", "$txt_file");
      if ( $txt_file =~ /$carta_regex/ ) {

	      #print STDOUT "Archivo: " . $txt_file . "\n";
	      @lugar_fecha = [];

	      $lugar = "Sin Lugar";
	      while ( <TXT> ) {

	       if ( $_ =~ /$fecha_regex2/g ) {

		    chomp;
		    s/ de / /g;
		    @lugar_fecha = split(/ /);

		    for ( $i = 0; $i < $#lugar_fecha ; $i++ ) {
			if ( $lugar_fecha[$i] =~ /\d{4}/ ) { 
			   $anio = $lugar_fecha[$i];
			   $mes = $lugar_fecha[$i-2];
			   $dia = $lugar_fecha[$i-1];
			   #print "fecha:" . $dia . " " . $mes . " " . $anio . "\n";
			} 
		    }
		    
              }
          close(TXT);
	if ( $anio =~ /177/ ) {
		push @177, $txt_file;
	} elsif ( $anio =~ /178\d/ ) {
		push @178, $txt_file;
	} elsif ( $anio =~ /176\d/ ) {
		push @176, $txt_file;
	} elsif ( $anio =~ /179\d/ ) {
		push @179, $txt_file;
	} elsif ( $anio =~ /180\d/ ) {
		push @180, $txt_file;
	} elsif ( $anio =~ /181\d/ ) {
		push @181, $txt_file;
	} elsif ( $anio =~ /182\d/ ) {
		push @18, $txt_file;
	}

       }
   }
}
  closedir $dh;
#}

print STDOUT "\nDecada 1760"; foreach my $item(@176) { print " " . $item; } 
print STDOUT "\nDecada 1770"; foreach my $item(@177) { print " " . $item; } 
print STDOUT "\nDecada 1780"; foreach my $item(@178) { print " " . $item; }
print STDOUT "\nDecada 1790"; foreach my $item(@179) { print " " . $item; }
print STDOUT "\nDecada 1800"; foreach my $item(@180) { print " " . $item; }
