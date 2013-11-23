my $temp = 1;
my $pid = $ARGV[0];
my $exe = $ARGV[1];
my $ret = system("adb devices");
my $us = "_";
my $sl = `adb get-serialno`;
my $tmp = 1;
my $flag;
chomp ($sl);
@timeData = localtime(time);
$ct = join('', @timeData);
$fldr_nm = join "", $sl, $us, $ct;
for (;;){
	if(`adb get-state` =~ m/device/i) {
		print "Device is running fine";
		sleep 10;
	}
	else {
		print "$pid";
		system("taskkill /F /PID $pid");
		`mkdir black`;
		chdir("black") or die "black": $_;
		system ("adb pull /data/local/tmp/$exe");
		exit(1);
	}
	sleep 1;
}