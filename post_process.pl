use File::Basename qw/dirname/;
use File::Copy;

my $target = $ARGV[0];
my $files;

`copy Android_mk_generator.pl $target`;
`copy c_generator.pl $target`;
`copy exetest.pl $target`;
`copy run_activity.pl $target`;
`copy activity_list.txt $target`;

chdir ($target);

system("ls *.c > ls.txt");

my $out_file = "ts.txt";
my $tmp;

open my $fh, '>', "$out_file" or die "Cannot open output.txt: $!";
open FILE, "<ls.txt" or die "Could not open the file ls.txt: $!\n";
while (<FILE>){
	chomp;
	my $tmp=$_;
	my $temp=$_;
	substr ($tmp, 0, 6) = "";
	print $fh "$tmp";
	print $fh "\n";
	system("perl -w c_generator.pl $_ $tmp");
	substr ($tmp, -2) = "";
	system("perl -w Android_mk_generator.pl $tmp");
} 
close FILE;
close $fh;
sleep 5;
system("rm *.log");
system("rm *.xml");
#system("rm *.c");
system("rm *.mp3");
system("rm *.3gp");
system("rm *.so");
system("rm *.txt");
system("rm *.sh");
system("rm *.mp4");
system("rm trinityexe");
system("rm lib");
system("rm trinity*");
