package CVDatabase;
use Mojo::Base 'Mojolicious';
use Data::Dumper;

# This method will run once at server start
sub startup {
  my $self = shift;

  #$app->plugin('TagHelpers');
  
  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;


  $r->get('/candidate/create')->to('candidate#create');

  #$r->get('/candidate/:cand_id/view')->to('candidate#view');
  
  $r->get ('/candidate/:cand_id/edit')->to('candidate#edit');  #fetch from db
  $r->post('/candidate/:cand_id/edit')->to('candidate#edit')->name('cand_edit_post');      #store into db

  #ATTACHMENT
  $r->get ('/attachment/:cand_id/upload')->to('attachment#upload')->name('attachment_show_upload');
  $r->post('/attachment/:cand_id/upload')->to('attachment#upload')->name('attachment_post_upload');

  $r->get ('/attachment/:attach_id/process')->to('attachment#process')->name('attachment_get_process');
  $r->post('/attachment/:attach_id/process')->to('attachment#process')->name('attachment_post_process');
 
 
  # Normal route to controller
  $r->get('/')->to('example#welcome');

}

1;
