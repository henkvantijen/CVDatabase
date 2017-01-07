package CVDatabase::Model::Candidate::Manager;
use base qw(Rose::DB::Object::Manager);
sub object_class { 'CVDatabase::Model::Candidate'}

local $Rose::DB::Object::Manager::Debug = 1;

__PACKAGE__->make_manager_methods('candidates');
# class methods get_x, get_x_iterator, get_x_count, delete_x, update_x


sub get_all_candidates
  {
    shift->get_objects(object_class => 'CVDatabase::Model::Candidate', @_);
  }


1;

#-----------------------------------
