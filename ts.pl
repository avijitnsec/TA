open (FILES, "<ts.txt");
while(<FILES>){
	chomp;
	my $v1 = substr($_, 0, -2);
	my $filename = "$v1\\obj\\local\\armeabi\\$v1";
 	if (-e $filename) {
		system("adb push $filename \/data\/local\/tmp");
		sleep 2;
		`adb shell chmod 0777 \/data\/local\/tmp\/$v1`;
		system("adb shell sh \/data\/local\/tmp\/run_exe.sh $v1");
	}
}