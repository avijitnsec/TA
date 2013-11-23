use strict;
use warnings;
use File::Copy;

my $filename;
my $filesize;
my $fldr_nm;

$fldr_nm = $ARGV[0];
opendir(my $DIR, $fldr_nm) || die "can't opendir $fldr_nm: $!";  
my @files = readdir($DIR);

foreach my $t (@files)
{
	$filesize = -s "$fldr_nm/$t";
	if($filesize == 0)
	{
		unlink "$fldr_nm/$t";
	}
}