package App::Cron2RSS;
use strict;
use warnings;

use base 'Exporter';
our %EXPORT_TAGS = (all => [qw[ homedir chdir_to_data ]]);
Exporter::export_ok_tags('all');


=head1 SETUP

=cut

sub local_setup {
    # We can no longer rely on crond to give us the umask we want.
    # Set it explicitly (for this script, and to be inherited by the
    # wrapped job in "add")
    umask 022;
}

sub general_setup {
    my $homedir = homedir();
    die("Can't find 'data' directory in $homedir")
      unless -d "$homedir/data/.";
}

=head1 EXPORTABLE FUNCTIONS

=head2 homedir()

Where the C<data/> lives.

=cut

sub homedir {
    return $FindBin::Bin;
}


=head2 chdir_to_data()

C<chdir> to the data directory, or die.

=cut

sub chdir_to_data {
    my $homedir = homedir();
    chdir $homedir
      or die("Can't find home directory '$homedir'\n");

    chdir 'data'
      or die("No $homedir/data/ subdir!");
}

local_setup();
general_setup();

1;
