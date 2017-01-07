package CVDatabase::Model::Candidate;
use strict;
use warnings;

use base qw(CVDatabase::DB::Object);



#use CVDatabase::Model::Candidate::Manager;

local $Rose::DB::Object::Manager::Debug = 1;

__PACKAGE__->meta->setup(
    table      => 'candidate',
    auto => 1,
);


#__PACKAGE__->meta->make_manager_class('candidates');


sub validate {
  my $c  = shift;
  my $post_params = shift;

  print "/nVALIDATE/n";
  
  my @errors = ();
  
  push @errors, "Skills invullen"        if (length($$post_params{'skills'}) < 3);  
  
  push @errors, "Functietitel ontbreekt" if (length($$post_params{'last_job_title'}) < 3);  
  
  @errors;
  
};


1;    
