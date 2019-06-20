#!/sr/in/perl -w
use strict;
@ARGV >= 3 || die "perl $0 all.m8 len.xls screening.m8.xls 50,70\n";
my($m8, $lenfile, $out, $cutoff) = @ARGV;
$cutoff ||= '50,70'; #for neucliotides, 80,80; identity cut and coverage cut;
my ($iden_cut, $cov_cut) = split /,/, $cutoff;
print "#identity_cut: $iden_cut; coverage_cut: $cov_cut\n";

my %id_len = hash_construct($lenfile);
open OUT, ">", $out || die $!;
open ML, $m8 || die $!;
my (%id_evl, %id_line);
while(<ML>){
	chomp;
	my($id, $eval) = (split /\t/)[0,-2];
	push @{$id_evl{$id}}, $eval;
	push @{$id_line{$id}}, $_;
}
close ML;
print "ID\tSubj\tIdentity\tConverage\tE-value\tMin_evalue\n";
for (sort{$a cmp $b} keys %id_evl){
	my @evalues = sort {$a <=> $b} @{$id_evl{$_}};
	my $min_eval = scalar(@evalues)>1 ? $evalues[0]*10 : $evalues[0];
	for my $l (@{$id_line{$_}}){
		my($subj, $iden, $s, $e, $evalue) = (split /\t/, $l)[1,2,6,7,-2];
		$id_len{$_} || warn "No $_ vs length\n";
		my $cov = abs($s-$e)/$id_len{$_};
		if($evalue<=$min_eval && $iden>=$iden_cut && $cov>=$cov_cut/100){
			print OUT $l, "\n";
		}else{
			print "$_\t$subj\t$iden\t$cov\t$evalue\t$min_eval\n";
			next;
		}
	}
}
close OUT;


sub hash_construct{
	my($file) = @_;
	my %hash;
	open IN, $file || die $!;
	while(<IN>){
		chomp;
		my($id, $len) = split /\t/;
		$hash{$id} = $len;
	}
	close IN;
	return %hash;
}

