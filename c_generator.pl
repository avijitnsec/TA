my @pagebuffer_page;
my @files_page;
my @addresses_page;
my @sizes_page;
my @commands_page;
my @global_pos;
my @flag_set;

my @files_nopage;
my @addresses_nopage;
my @sizes_nopage;
my @commands_nopage;

my $node = NULL;
my $line = NULL;
my $pg = NULL;
my $type;
my $pb = "page";
my $fl = "file";
my $add = "addr";
my $count = 0;
my $count1 = 0;
my $count2 = 0;
my $sz = "size";
my $command = "cmd_";
my $file_name = $ARGV[0];
my $out_file = $ARGV[1];
my $temp = 1;
my $tmp;
my $flag = 0;

open (FILE, "<$file_name");
while (<FILE>)
{
	chomp;
	my $tmp=$_;
	$v1 = substr($tmp, 0, 4);
	if($v1 eq "TRIN")
	{
		break;
	}
	
	if($v1 eq "PAGE")
	{
		$flag = 0;
		print "PAGE $flag\n";
		push(@flag_set, $flag);
	}
	elsif ($v1 eq "NOPA")
	{
		$flag = 1;
		print "NOPAGE $flag\n";
		push(@flag_set, $flag);
	}
	else{

		if($v1 eq $pb )
		{
			push(@pagebuffer_page, $tmp);		
		}
		
		if($v1 eq $add)
		{
				push(@addresses_page, $tmp);		
		}

		if($v1 eq $fl)
		{
			push(@files_page, $tmp);
		}

		if($v1 eq $add)
		{
			print "Count1 increased\n";
		}

		if($v1 eq $sz)
		{
			push(@sizes_page, $tmp);		
		}
		
		if($v1 eq $command)
		{
			push(@commands_page, $tmp);		
			$count++;
			push(@global_pos, $count);

		}
	}
}

open my $fh, '>', "$out_file" or die "Cannot open output.txt: $!";
$line = $files_page[0];
while(index($line, '  ') > 0){ 
	$line =~ s/  / /g; 
}	 
my @tokens = split(" ", $line);	    
$node = $tokens[2];
substr ($node, -1, 1) = "";
substr ($node, 0, 1) = "";

print $fh "//$node\n";
	
print $fh "#include <stdlib.h>\n";
print $fh "#include <stdio.h>\n";
print $fh "#include <sys/ioctl.h>\n";
print $fh "#include <sys/mman.h>\n";
print $fh "#include <sys/types.h>\n";
print $fh "#include <fcntl.h>\n";

print $fh "int main\(void\)\{\n";
foreach (@pagebuffer_page)
{
	print $fh "char ";
	print $fh "$_;\n"; 
}
print $fh "char *page =  NULL;\n";
print $fh "\n";

print $fh "int fd = open(";
$line = $files_page[0];
while(index($line, '  ') > 0){ 
	$line =~ s/  / /g; 
}	 
my @tokens = split(" ", $line);	    
$node = $tokens[2];
substr ($node, -1, 1) = "";
substr ($node, 0, 1) = "";
print $fh "$tokens[2], O_RDWR);\n"; 

my $c = 0;

for (; $c < $count ;)
{
	my $line1 = $addresses_page[$c];
	print "$line1\n";
	while(index($line1, '  ') > 0)
	{ 
		$line1 =~ s/  / /g; 
	}	 
	my @tokens = split(" ", $line1);

	if($flag_set[$c] == 0)	#Avijit
	{
		print $fh "if (MAP_FAILED == (page = mmap((long *)$tokens[2], 4096, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, 0, 0))) {";
		print $fh "\n";
		print $fh "exit(-2);";
		print $fh "\n";
		print $fh "}";
		print $fh "\n";
		my $line2 = $sizes_page[$c];
		while(index($line2, '  ') > 0)
		{ 
			$line2 =~ s/  / /g; 
		}	 
		my @tokens1 = split(" ", $line2);	
		my $line4 = $pagebuffer_page[$c];
		while(index($line4, '  ') > 0)
		{ 
			$line4 =~ s/  / /g; 
		}	 
		my @tokens4 = split(" ", $line4);	
		substr ($tokens4[0], -2) = "";
		print $fh "memcpy(page, $tokens4[0], 4096);";
		print $fh "\n";
	}
	my $line3 = $commands_page[$c];
	# print $line3;
	while(index($line3, '  ') > 0){ 
		$line3 =~ s/  / /g; 
	}	 
	my @tokens2 = split(" ", $line3);

	print $fh "printf(";
	print $fh "\"";
	print $fh "It is runnint $node node";
	print $fh "\"";
	print $fh ");";
	print $fh "\n";
	print $fh "ioctl(fd, $tokens2[2], $tokens[2]);";	
	print $fh "\n";
	print $fh "\n";
	$c++;
}
print $fh "return 0;\n";
print $fh "\}\n";
close $fh; 