package CVDatabase::Controller::Attachment;
use Mojo::Base 'CVDatabase::Controller'; 
use Mojo::Upload;
use CVDatabase::Model::Attachment;

use Data::Dumper;

# Document=Document, Attachment=Attachment

use File::Basename 'basename';
use File::Path 'mkpath';

# Attachments base URL
our $ATTACHMENTS_BASE = '/cvdatabase/cvuploads';
#TODO  make sub dirs, to support 10thousands of uploads
#TODO  set rights of upload dirs  (chmod)
# Directory to save files
# (static is MojoX::Dispatcher::Static object)
our $ATTACHMENTS_DIR;

sub init {
    my $c = shift;
    print "INIT \n";
    $ATTACHMENTS_DIR  = $c->app->home->rel_file('/public') . $ATTACHMENTS_BASE;
    
    #Create directory if not exists
    unless (-d $ATTACHMENTS_DIR) {
      mkpath $ATTACHMENTS_DIR or die "Cannot create dirctory: $ATTACHMENTS_DIR";
    }
};




sub view {
  my $self = shift;

  my $attachment_id = $self->param('id');
  return $self->redirect_to('/404') if( $attachment_id !~ /\d+/ );
  my $attachment = CVDatabase::Model::Attachment->new(id => $attachment_id);
  $attachment->load;

  # $self->loggedin_user;
  $self->stash( attachment => $attachment );
  $self->stash( page_caption => "Document Details" );

  $self->show();
}


# This action will render a template
sub show {
  my $self = shift;

  # Render template "Attachment/view.html.ep" with message
  $self->render(msg => 'Attachment');
}

sub create {
    my $c = shift;
    my $attachment = CVDatabase::Model::Attachment->new;
  
}



sub upload {
  my $c = shift;
  #my $attachment_id = $c->param('cand_id');
  #$c->stash(msg => 'Wijzig');
  my $attachment;
  my @errors = ();
  my $params = $c->req->body_params->to_hash; 

  $attachment = CVDatabase::Model::Attachment->new; or die $!;
  $attachment->candidate_id($c->param('cand_id'));

  if ($c->req->method eq 'POST') {
    # Process uploaded file
    
    
    if ($c->req->is_limit_exceeded) {
      push @errors, 'File is too big';
    }


    #return $c->redirect_to('form') unless ;
    # $attach is Mojo::Upload object?
    my $attach = $c->param('doc_upload');
    my $attach_size = $attach->size;
    my $attach_name = $attach->filename;
  
    print "***Thanks for uploading $attach_size byte file $attach_name.";

    # Not upload
    unless ($attach) {
      return $c->render(
        template => 'error', 
        message  => "Upload fail. File is not specified."
      );
    }
    
    # Upload max size
    my $upload_max_size = 3 * 1024 * 1024;
    
    # Over max size
    if ($attach->size > $upload_max_size) {
      return $c->render(
        template => 'error',
        message  => "Upload fail. attach size is too large."
      );
    }
    
    # Check file type
    my $attach_type = $attach->headers->content_type;
    
    my $valid_exts = 
    {'application/msword' => 'doc', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'docx',   
       'application/pdf' => 'pdf'};
    
    print Dumper $valid_exts;
    my %valid_types = map {$_ => 1} keys %$valid_exts;
   
    # Content type is wrong
    unless ($valid_types{$attach_type}) {
    
        push @errors, "Upload fail. Content type is wrong.";
        goto RENDER; 
    }
    
    my $ext = $valid_exts->{$attach_type};
    
    # attach file
    my $attach_file = "$ATTACHMENTS_DIR/" . create_filename(). ".$ext";
    
    # If file exists, Retry creating filename
    while(-f $attach_file){
      $attach_file = "$ATTACHMENTS_DIR/" . create_filename() . ".$ext";
    }
    
    # Save to file
    $attach->move_to($attach_file);
    
    if ($ext eq 'docx') {
        my $md_result = qx "pandoc --from docx --to markdown_mmd $attach_file >$attach_file.md "; # or die $!;
        print "MD RESULT = " . $md_result;
    }  
    
    # Store in new attachment object
    my $md = do {local $/ = undef;  open my $fh, "<", $file
        or die "could not open $file: $!"; <$fh>;}
    $attachment->text_md($md);
    my $attach_id = $attachment->save;
    
    # Redirect to top page
    $c->redirect_to("/attachment/$attach_id/review");
  };

RENDER:
#print "\nQUERY BODY\n";
#print Dumper %{$params};
#print Dumper $c->req->body_params->to_hash;

    
  $c->stash( attachment => $attachment, errors => \@errors );
#  $c->stash( page_caption => "Kandidaat Wijzig" );

  #$self->show();
} 

sub create_filename {
  
  # Date and time
  my ($sec, $min, $hour, $mday, $month, $year) = localtime;
  $month = $month + 1;
  $year = $year + 1900;
  
  # Random number(0 ~ 999)
  my $rand_num = int(rand 1000);

  # Create file name form datatime and random number
  # (like attach-20091014051023-789)
  my $name = sprintf(
    "attach-%04s%02s%02s%02s%02s%02s-%03s",
    $year,
    $month,
    $mday,
    $hour,
    $min,
    $sec,
    $rand_num
  );
  
  return $name;
}


sub 






1;
