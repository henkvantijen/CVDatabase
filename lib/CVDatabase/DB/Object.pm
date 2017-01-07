package CVDatabase::DB::Object;

use CVDatabase;
use CVDatabase::DB;
use base qw(Rose::DB::Object);
use Rose::DB::Object::Helpers qw(load_or_insert);

local $CVDatabase::DB::Object::Debug = 1;
sub init_db { CVDatabase::DB::->new }

our $app;


sub new {
  my $self = shift;

  $self->SUPER::new(@_);

  #our $app = shift;   #to get config

  #warn "app empty in DB::Object->new"  unless $app;

}



sub get_config {
  my $self = shift;

    my $CONFIG_PATH = '/var/www/html/Bancadi2016/bancadi.conf';
  #  {
        unless (my $return = do $CONFIG_PATH) {
            warn "couldn't parse $CONFIG_PATH: $@" if $@;
            warn "couldn't do    $CONFIG_PATH: $!" unless defined $return;
            warn "couldn't run   $CONFIG_PATH"     unless $return;

        } else {
          my $config = $return;
        }
   # }


  #$self->{config} = $ENV{'config'};

  #print "\n in object new >>>>"  .  dump %ENV;

   #print "\n in object new >>>>"  .  dump $self;

   return  $config;

}


1;

