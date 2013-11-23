my @pagebuffer_page;
my @files_page;
my @addresses_page;
my @sizes_page;
my @commands_page;

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
my $count1 = 0;
my $count2 = 0;
my $count = 0;
my $sz = "size";
my $command = "cmd_";
my $file_name = $ARGV[0];
my $out_file;
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
		$flag = 1;
		print "PAGE $flag\n";
	}
	elsif ($v1 eq "NOPA")
	{
		$flag = 2;
		print "NOPAGE $flag\n";
	}
	else
	{
		if($v1 eq $pb )
		{
			if( $flag == 1)
			{
				push(@pagebuffer_page, $tmp);		
			}
		}

		if($v1 eq $fl)
		{
			print "flag = $flag\n";
			if( $flag == 1)
			{
				push(@files_page, $tmp);		
			}
			elsif( $flag == 2)
			{
				push(@files_nopage, $tmp);		
			}
		}

		if($v1 eq $add)
		{
			if($flag == 1)
			{
				push(@addresses_page, $tmp);		
				print "Count1 increased\n";
				$count1++;
			}
			elsif($flag == 2)
			{
				push(@addresses_nopage, $tmp);		
				print "Count2 increased\n";
				$count2++;
			}
		}

		if($v1 eq $sz)
		{
			push(@sizes, $tmp);		
		}
		if($v1 eq $command)
		{
			push(@commands, $tmp);		
			if( $flag == 1)
			{
				push(@commands_page, $tmp);		
			}
			elsif( $flag == 2)
			{
				push(@commands_nopage, $tmp);		
			}
		}
	}
	
}

$i = 0;
for(;$i<$count1;){
	print "1";
	$out_file = join "", $count, ".c";
	open my $fh, '>', "$out_file" or die "Cannot open output.txt: $!";
	print $fh "#include <stdlib.h>\n";
	print $fh "#include <stdio.h>\n";
	print $fh "#include <sys/ioctl.h>\n";
	print $fh "#include <sys/mman.h>\n";
	print $fh "#include <sys/types.h>\n";
	print $fh "#include <fcntl.h>\n";
	
	print $fh "int main\(void\)\{\n";
	print $fh "char ";
	print $fh "$pagebuffer_page[count];\n"; 
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
	my $line1 = $addresses_page[$i];
	while(index($line1, '  ') > 0){ 
		$line1 =~ s/  / /g; 
	}	 
	my @tokens = split(" ", $line1);	
	print $fh "if (MAP_FAILED == (page = mmap((long *)$tokens[2], 4096, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, 0, 0))) {";
	print $fh "\n";
	
	print $fh "exit(-2);";
	print $fh "\n";
	print $fh "}";
	print $fh "\n";
	my $line2 = $sizes_page[$i];

	while(index($line2, '  ') > 0){ 
		$line2 =~ s/  / /g; 
	}	 
	my @tokens1 = split(" ", $line2);	
	my $line4 = $pagebuffer_page[$i];

	while(index($line4, '  ') > 0){ 
		$line4 =~ s/  / /g; 
	}	 
	my @tokens4 = split(" ", $line4);	
	substr ($tokens4[0], -2) = "";
	print $fh "memcpy(page, $tokens4[0], 4096);";
	print $fh "\n";
	my $line3 = $commands_page[$i];
	print $line3;
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

	print $fh "return 0;\n";
	print $fh "\}\n";
	close $fh; 
	$count++;
	$i++;
}

$i = 0;
for(;$i<$count2;)
{
	print ("\nNo page: $count2\n");
	$out_file = join "", $count, ".c";
	open my $fh, '>', "$out_file" or die "Cannot open output.txt: $!";
	print $fh "#include <stdlib.h>\n";
	print $fh "#include <stdio.h>\n";
	print $fh "#include <sys/ioctl.h>\n";
	print $fh "#include <sys/mman.h>\n";
	print $fh "#include <sys/types.h>\n";
	print $fh "#include <fcntl.h>\n";
	
	print $fh "int main\(void\)\{\n";
	print $fh "char ";
	print $fh "$pagebuffer_page[count];\n"; 
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
	
	my $line1 = $addresses_nopage[$i];
	while(index($line1, '  ') > 0){ 
		$line1 =~ s/  / /g; 
	}	 
	my @tokens = split(" ", $line1);	
	my $line3 = $commands_nopage[$i];
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

	print $fh "return 0;\n";
	print $fh "\}\n";
	close $fh; 
	$count++;
	$i++;
}