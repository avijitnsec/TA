use strict;
use warnings;
use File::Copy;

my $filename;
my $filesize;

my $fldr_nm;
my @timeData;
my $temp;
my $tmp;
my $del;

my $pid = $ARGV[0];
my $blf = $ARGV[1];
print "$pid";
system("taskkill /F /PID $pid");
my $us = "_";
system("adb wait-for-device");
my $serial = `adb get-serialno`;
chomp($serial);
@timeData = localtime(time);
my $ct1 = join('', @timeData);
chomp($ct1);

$fldr_nm = join "", $serial, $us, $ct1;
system ("md $fldr_nm");
system("adb pull /data/local/tmp/ $fldr_nm");
system("adb pull \/data\/local\/tmp $fldr_nm");
sleep 3;
system("perl -w copy.pl $fldr_nm");		
opendir(my $DIR, $fldr_nm) || die "can't opendir $fldr_nm		: $!";  
my @files = readdir($DIR);

foreach my $t (@files)
{
	if(-f "$fldr_nm/$t" ) {
		$tmp = $t;
		$temp = substr($tmp, -2);
		chomp($temp);
		print "$temp\n";
		if($temp ne ".c")
		{
			unlink "$fldr_nm/$t";
		}
	}
	
}

system("perl -w size.pl $fldr_nm");		

closedir($DIR);
system ("copy $blf $fldr_nm");
system ("perl -w post_process.pl $fldr_nm");



