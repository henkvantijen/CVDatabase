package CVDatabase::DB;

use base qw(Rose::DB);

__PACKAGE__->use_private_registry;

__PACKAGE__->register_db(
    driver   => 'mysql',
    database => 'cvdatabase',
    host     => '127.0.0.1',
    username => 'root',
    password => 'mys6l@@@@',
    connect_options => {ChopBlanks => 1},    #should not be necessary....
);

1;
