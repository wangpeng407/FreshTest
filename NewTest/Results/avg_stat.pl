#!/usr/bin/perl -w
use strict;

my ($group, $table) = @ARGV;
@ARGV == 2 || die "perl $0 group.list mat.xls > stat.mat.xls\n";

my %group_samples = get_hash($group);
open IN, $table ||die $!;
my $tab = <IN>; chomp $tab;
my @allsamples = split /\t/, $tab;
shift @allsamples;
my @groups = sort{$a cmp $b} keys %group_samples;
print "Taxa\t", join("\t", @groups), "\n";
while(<IN>){
	chomp;
	my @ll = split;
	my $taxa = shift @ll;
	my @stats;
#	for my $g(sort{$a cmp $b} keys %group_samples){
	for my $g(@groups){
		my @sg = @{$group_samples{$g}};#每个分组包含的样本
		my @index = match_array_index(\@sg, \@allsamples);#每个分组下的样本对应的下边
		my @data = @ll[@index];
		my ($sum, $avg, $sd)  = &stat(@data);
		push @stats, $avg . ':' . $sd;
	}
	print $taxa, "\t", join("\t", @stats), "\n";
}

#==============================================
sub match_array_index{
    my ($sarray, $barray) = @_; 
    my @sarray = @{$sarray};
    my @barray = @{$barray};
    my $i; 
    my %bindex = map {$_, $i++} @barray;
    my @index = map { $bindex{$_} } grep { exists($bindex{$_}) } @sarray;
    return @index;
}

sub get_hash{
	my ($grouplist) = @_;
	my %group_sample;
	open IN, $grouplist || die $!;
	while(<IN>){
		chomp;
		my ($sample, $group) = split /\t+/;
		push @{$group_sample{$group}}, $sample;
	}
	close IN;
	return %group_sample;
}

sub stat {
	my (@num) = @_;
	my($sum, $avg, $sd, $sumsq);
	$sum+=$_ for @num;
	$avg = $sum / scalar(@num);
	$sumsq+=($_ - $avg)**2 for @num;
	$sd = sqrt($sumsq/scalar(@num));
	return($sum, sprintf("%.5f",$avg), sprintf("%.5f", $sd));
}

#==============================================
sub stat2 {
	my (@num) = @_;
	my ($sum, $avg, $sum_square, $std);
	foreach my $value (@num){
		$sum += $value; #$sum = $sum + $value;
	}
	$avg = $sum / scalar(@num);
	foreach my $value (@num){
		$sum_square += ($value - $avg)**2;
	}
	$std = ($sum_square / scalar(@num))**(1/2);
	return($avg,$std);	
}

