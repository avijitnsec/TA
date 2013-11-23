use File::Basename qw/dirname/;
use File::Copy;

my $h1 = "# -------------------------------------------------------";
my $h2 = "#                      XML Parser";
my $h3 = "# -------------------------------------------------------";

my $temp;
my $tmp = $ARGV[0];
my $fl = join(".", $tmp, "c");

my $first = "LOCAL_PATH := \$\(call my-dir)";

my $second = "include \$\(CLEAR_VARS)";
my $third = "LOCAL_SRC_FILES  += $fl";
my $fourth = "LOCAL_MODULE           := $tmp";
my $fifth = "LOCAL_C_INCLUDES := \$\(LOCAL_PATH)";
my $sixth = "include \$\(BUILD_EXECUTABLE)";

# -------------------------------------------------------
#                      XML Parser
# -------------------------------------------------------
#include $(CLEAR_VARS)
#LOCAL_SRC_FILES  += ioctl_reprod-child4862.c
#LOCAL_MODULE           := ioctl_reprod-child4862
#LOCAL_C_INCLUDES := $(LOCAL_PATH)
#include $(BUILD_EXECUTABLE)

$temp = join "", "ioclt_", $fl;
my $fldr_name =$tmp;
`mkdir $fldr_name`;
copy($fl, $fldr_name) or die "Couldn't copy: $!";
chdir($fldr_name) or die "Cant chdir to $path $!";
`mkdir jni`;

if (-e "Android.mk") {
 print "File Exists!";
 exit(0);
 } 
open OUTFILE, ">>Android.mk"  or die "Error opening : $!";
print OUTFILE $h1;
print OUTFILE "\n";
print OUTFILE $h2;
print OUTFILE "\n";
print OUTFILE $h3;
print OUTFILE "\n";
print OUTFILE $first;
print OUTFILE "\n";
print OUTFILE $second;
print OUTFILE "\n";
print OUTFILE $third;
print OUTFILE "\n";
print OUTFILE $fourth;
print OUTFILE "\n";
print OUTFILE $fifth;
print OUTFILE "\n";
print OUTFILE $sixth;
print OUTFILE "\n";
close (OUTFILE);
print "Done !!";

copy($fl, "jni") or die "Couldn't copy: $!";
copy("Android.mk", "jni") or die "Couldn't copy: $!";

open my $file, '<', "$fl"; 
my $firstLine = <$file>; 
close $file;

open (MYFILE, '>node.txt');
substr ($firstLine, 0, 2) = "";
 print MYFILE "$firstLine";
 close (MYFILE);

unlink "Android.mk";
system("ndk-build");

