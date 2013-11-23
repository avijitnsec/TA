my $bl;

open (FILES, "<ts.txt") or die "Couldn't copy: $!";
while(<FILES>){
	chomp;
	my $v1 = substr($_, 0, -2);
	my $filename = "$v1\\obj\\local\\armeabi\\$v1";
	my $bl = "$v1\\node.txt";
	print "$filename";
	print "checking.. \n";
 	if (-e $filename) {
		system("adb push $filename \/data\/local\/tmp");
		sleep 2;
		`adb shell chmod 0777 \/data\/local\/tmp\/$v1`;
		print "$v1";
		my $str ="adb shell while :;do ./data/local/tmp/$v1; done &\n";
		print $str;
        open my $file, '<', "$bl"; 
		my $firstLine = <$file>; 
		close $file;
		if ($firstLine ne ""){
			if(-e "run_activity.pl")
			{
				print "run_activity.pl not found\n";
			}
			system("start cmd /k \"perl -w run_activity.pl $firstLine\"");
			print "Running actinity for $firstLine\n";
		}
		system("start cmd /k \"adb shell while \:\;do \.\/data\/local\/tmp\/$v1\; done &\"\"\"");
		system("start cmd /k \"perl check_dev2.pl $$ $v1\"");
	}
}