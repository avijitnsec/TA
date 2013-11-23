my $node = $ARGV[0];
my $al = "activity_list.txt";
	open (FL2, "<$al");
	while(<FL2>){
		chomp;
		$tmp = $_;
		my( $v1, $v2 ) = unpack( 'a17 a105', $tmp );
		$v1 =~ s/\s+//g;
		if ($node eq $v1){
			system("start cmd /k \"$v2\"");
		}
	}
	close(FL2);