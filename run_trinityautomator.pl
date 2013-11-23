my $file="supported_nodes.txt"; 
my $file1 = "supported_nodes.txt";
my $temp;
my $temp1;
my $flag=1;
my $device_check = "perl -w check_device.pl $$";
my $tmp_bl = ".txt";
my $bl;
my $bl_tmp;
my $count = 0;
my $device;
my $serial;
my $pid = $$;
my $ct1; 
$us = "_";
@timeData = localtime(time);
my $ct1 = join('', @timeData);
chomp($ct1);
system("adb wait-for-device");
$serial = `adb get-serialno`;
chomp($serial);
$bl = join "", $serial, $us, $ct1, $tmp_bl;
system("adb wait-for-device");
system ("adb push trinity_target.sh \/data\/local\/tmp");
sleep 1;
system ("adb push iofuzz_target.sh \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\android-75\\Dropbox\\trinityexe \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\android-75\\Dropbox\\iofuzz \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\libs\\armeabi\\libqfast.so \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\libs\\armeabi\\libfuzzxmlparser.so \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\qfastconfig\\qfastfield_param.xml \/data\/local\/tmp");
sleep 1;
system ("adb push \\\\frosty\\android_stability\\Phani\\Linux_Security\\Trinity\\trinityBinary\\qfastconfig\\qfastfield_grammar.xml \/data\/local\/tmp");
sleep 1;
print ("Current running PID: $pid $bl\n");
system( "start cmd.exe /k $device_check $bl" );

while (1) {
	open FILE, "<$file" or die "Could not open $file: $!\n";
	@array=<FILE>;
	close FILE;
	$randomline=$array[rand @array];
	$temp = $randomline;
        $temp =~ s/\R//g;
	chomp ($temp);
	open FL1, "<$bl"; 
	while(<FL1>){
		chomp;
		$bl_tmp = $_;
		if( $temp == $bl_tmp)
		{
			next;
		}
	}
	print "1\n";
	close(FL1);
	system("adb shell \"su -c \"chmod 0777 \/data\/busybox\/busybox\"\"");
	`adb shell \"su -c \"lsof | /data/busybox/busybox awk '{ print \$ \9 }' | grep /dev/\"\" > current_nodes.txt`;
	open(FL2, "<$file1") or die "Could not open $bl: $!\n";	
	while (<FL2>) {
		chomp;
		$temp1 = $_;
		$temp1 =~ s/\R//g;
	
		if ($temp eq $temp1){
			open OUTFILE, ">>$bl"  or die "Error opening : $!";
			print OUTFILE $temp;
			print OUTFILE "/\n";
			close (OUTFILE);
			if ($temp ne ""){
				system("start cmd /k \"perl -w run_activity.pl $temp\"");
			}
			print "Running trinity on $temp";
			system("start cmd /k \"adb shell \"su -c \"sh /data/local/tmp/trinity_target.sh $temp\"\"\"");
			system("start cmd /k \"adb shell \"su -c \"sh /data/local/tmp/iofuzz_target.sh $temp\"\"\"");
			sleep(60);
			$flag++;
			if ( $flag == 15)
                        {
                              print ("Running 15 nodes..so terminating.. ");
                              exit (1);
                        }
		}	
	}
	close(FL2);
}
close(FILE);