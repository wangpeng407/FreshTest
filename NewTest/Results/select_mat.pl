#!/usr/bin/perl -w
use strict;
use Getopt::Long;
my %opt;
GetOptions(\%opt,"detail");
@ARGV == 2 || die "perl $0 list Unigenes.relative.g.xls > sel.Unigenes.relative.g.xls\n
	--detail if last column is details, set this argument\n
";

my ($list, $matrix) = @ARGV;
open IN, $list || die $!;
my @SelSams;
while(<IN>){
	chomp;
	my @l = split /\t/;
	push @SelSams, $l[0];
}
close IN;

open IN, $matrix || die $!;
my $h = <IN>; chomp $h;
my @header = split /\t+/, $h;
my @index = match_array_index(\@SelSams, \@header);
print STDERR "selected index is ", join(" ", @index), "\n";;
print join("\t", @header[(0,@index)]), "\n";
while(<IN>){
	chomp;
	my @ll = split /\t+/;
	my @selindex = $opt{detail} ? (0, @index, $#ll) : (0, @index);
	my @selline = @ll[@selindex];
	print join("\t", @selline), "\n";
}
close IN;

sub match_array_index{
	my ($sarray, $barray) = @_;
	my @sarray = @{$sarray};
	my @barray = @{$barray};
	my $i;
	my %bindex = map {$_, $i++} @barray;
	my @index = map { $bindex{$_} } grep { exists($bindex{$_}) } @sarray;
	return @index;
}

