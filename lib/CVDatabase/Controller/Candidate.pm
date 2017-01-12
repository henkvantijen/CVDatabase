package CVDatabase::Controller::Candidate;
use Mojo::Base 'Mojolicious::Controller';

use CVDatabase::Model::Candidate;

use Data::Dumper;

sub view {
  my $self = shift;

  my $cand_id = $self->param('id');
  return $self->redirect_to('/404') if( $cand_id !~ /\d+/ );
  my $cand = CVDatabase::Model::Candidate->new(id => $cand_id);
  $cand->load;

  # $self->loggedin_user;
  $self->stash( cand => $cand );
  $self->stash( page_caption => "Kandidaat Details" );

  $self->show();
}


# This action will render a template
sub show {
  my $self = shift;

  # Render template "candidate/view.html.ep" with message
  $self->render(msg => 'Candidate');
}

sub create {
    my $c = shift;
    my $cand = CVDatabase::Model::Candidate->new;
  
}



sub edit {
  my $c = shift;
  my $cand_id = $c->param('cand_id');
  #$c->stash(msg => 'Wijzig');
  my $cand;
  my @errors = ();
  my $params = $c->req->body_params->to_hash; 

  $cand = CVDatabase::Model::Candidate->new(id => $cand_id)->load() or die $!;

print Dumper "ERRSTR > " . join ("- \n",  $cand->validate($params)) . "--\n\n";

  if ($c->req->method eq 'POST') {
    foreach (keys %$params) { $cand->$_($params->{$_})};   #make sticky
    @errors = $cand->validate($params);
    if (scalar @errors < 1) {
      $cand->save;
      $c->stash(post_message => 'Candidate updated into DB');
    } else {  
      $c->stash(post_message => "Errors, check your input.");
      
    };    
  };   


print "\nQUERY BODY\n";
print Dumper %{$params};
print Dumper $c->req->body_params->to_hash;

    
  $c->stash( cand => $cand, errors => \@errors );
  $c->stash( page_caption => "Kandidaat Wijzig" );

  #$self->show();
}


1;
