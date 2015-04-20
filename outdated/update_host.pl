#!/usr/bin/perl -w
use strict;
use warnings;

our $IPTable;
use lib qw/./;
use IPTable;


sub netselect {
	open FI,'-|','sudo','netselect','-v',@_;
	my $msg = join("",<FI>);
	close FI;
	if($msg =~ m/\s*\d+\s+([\d\.]+)/) {
		return $1;
	}
	return "";
}

sub selectIP {
#	return {
#		'www.google.com'=>'74.125.128.105',
#		'www.googlesource.com'=>'74.125.128.82',
#		'listen.googlelabs.com'=>'74.125.128.141',
#		'plus.google.com'=>'74.125.128.100',
#		'www.gstatic.com'=>'74.125.128.120',
#		'accounts.google.com'=>'74.125.128.105',
#	};
	my @names = keys %{$IPTable};
	my %domains;
	foreach(@names) {
		if($IPTable->{$_}) {
			print STDERR "Select fastest ip for $_:\n";
			$domains{$_} = netselect(@{$IPTable->{$_}});
			print STDERR "$_ -> $domains{$_}\n";
		}
	}
	return \%domains;
}

sub gettable {
	my %domains = %{scalar(shift)};
	my @hosts = @_;
	my %table;
	foreach(@hosts) {
		chomp;
		next unless($_);
		if(m/^\s*([\d\.]+)\s+([^\s#]+)/) {
		#	die("[$1=>$2]\n");
			foreach my $domain (keys %domains) {
				if($2 eq $domain) {
					$table{$1} = $domains{$domain};
				}
			}
		}
	}
	return \%table;
}

sub writehost {
	my %table = %{scalar(shift)};
	my @hosts = @_;
	open FO,'>','hosts' or die("$!\n");
	foreach(@hosts) {
		chomp;
		if(!$_) {
			print FO "$_\n";
			next;
		}
		if(m/^\s*([\d\.]+)\s+[^\s#]+/) {
			my $old = $1;
			if($table{$old} && (!($table{$old} eq $old))) {
				print STDERR "$_ => ";
				$_ =~ s/$old/$table{$old}/g;
				print STDERR "$_\n";
			}
		}
		print FO "$_\n";
	}
	close FO;
}

open FI,'<','hosts' or die("$!\n");
my @hosts = <FI>;
close FI;

writehost(gettable(selectIp(),@hosts),@hosts);

