use strict;
use warnings;
use File::Copy;

my $source_dir = $ARGV[0]; #"C\:\\android-ndk-r9b\\LDXR230046_1271761011333090";
my $target_dir = "android-ndk-r9b\\platforms\\android-14\\arch-arm\\usr";

opendir(my $DIR, $source_dir) || die "can't opendir $source_dir: $!";  
my @files = readdir($DIR);

foreach my $t (@files)
{
   if(-f "$source_dir/$t" ) {
      copy "$source_dir/$t", "$target_dir/$t";
   }
}

closedir($DIR);