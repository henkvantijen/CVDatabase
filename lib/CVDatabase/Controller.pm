package CVDatabase::Controller;

use strict;
use warnings;

use base 'Mojolicious::Controller';
use Mojo::ByteStream 'b';

use Data::Dumper;

sub new {
  
  my $class = shift;
  my ( $path, $data ) = @_;
  
  #print "NEW NEW NEW \n";
  
  my $c = $class->SUPER::new(@_);
  
  #$c->{foobar} = "NUEVO \n";
  $c->init();
  return $c;
}  


1;   #not in generated ?
