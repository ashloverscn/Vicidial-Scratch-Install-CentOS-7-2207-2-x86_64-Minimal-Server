#!/bin/sh

echo -e "\e[0;32m Install and Configure Perl-CPAN\Perl-CPAN-Modules \e[0m"
sleep 2
yum -y install perl-CPAN perl-YAML perl-libwww-perl perl-DBI perl-DBD-MySQL perl-GD perl-Env perl-Term-ReadLine-Gnu perl-SelfLoader perl-open.noarch

#cpan o conf init

#rm -rf /usr/share/perl5/CPAN/Config.pm

perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit' 

cd /usr/bin/
#curl -LOk http://xrl.us/cpanm
#curl -LOk https://github.com/ashloverscn/Vicidial-Scratch-Install-CentOS-7-2207-2-x86_64-Minimal-Server/raw/main/cpanm
\cp -r /usr/src/cpanm ./cpanm
cpan App::cpanminus 
#cpanm --installdeps .
chmod +x cpanm
cpanm -f File::HomeDir
cpanm -f File::Which
cpanm CPAN::Meta::Requirements
cpanm -f CPAN
cpan -i readline --force
cpanm Tk::TableMatrix
cpanm RPM::Specfile
cpanm YAML
cpanm MD5
cpanm String::CRC
cpanm Digest::MD5
cpanm Digest::SHA1
#cpanm readline --force
cpanm Bundle::CPAN
cpanm DBI
cpanm -f DBD::mysql
cpanm Net::Address::IP::Local
cpanm Net::Address::IPv4::Local
cpanm Net::Telnet
cpanm Time::HiRes
cpanm Net::Server
cpanm Switch
cpanm Mail::Sendmail
cpanm Unicode::Map
cpanm Jcode
cpanm Spreadsheet::WriteExcel
cpanm OLE::Storage_Lite
cpanm Proc::ProcessTable
cpanm IO::Scalar
cpanm Spreadsheet::ParseExcel
cpanm Curses
cpanm Getopt::Long
cpanm Net::Domain
cpanm Term::ReadKey
cpanm Term::ANSIColor
cpanm Term::ReadLine::Gnu
cpanm Spreadsheet::XLSX
cpanm Spreadsheet::Read
cpanm Spreadsheet::ReadSXC
cpanm LWP::UserAgent
cpanm HTML::Entities
cpanm HTML::Strip
cpanm HTML::FormatText
cpanm HTML::TreeBuilder
cpanm Time::Local
cpanm MIME::Decoder
cpanm Mail::POP3Client
cpanm Mail::IMAPClient
cpanm Mail::Message
cpanm IO::Socket::SSL
cpanm MIME::Base64
cpanm MIME::QuotedPrint
cpanm Crypt::Eksblowfish::Bcrypt
cpanm Crypt::RC4
cpanm Text::CSV
cpanm Text::CSV_XS
#cpan -i readline --force

echo -e "\e[0;32m Verify all cpan-modules installed successfuly \e[0m"
sleep 2
cpanm File::HomeDir
cpanm File::Which
cpanm CPAN::Meta::Requirements
cpanm CPAN
cpanm Tk::TableMatrix
cpanm RPM::Specfile
cpanm YAML
cpanm MD5
cpanm String::CRC
cpanm Digest::MD5
cpanm Digest::SHA1
#cpanm readline --force
cpanm Bundle::CPAN
cpanm DBI
cpanm DBD::mysql
cpanm Net::Address::IP::Local
cpanm Net::Address::IPv4::Local
cpanm Net::Telnet
cpanm Time::HiRes
cpanm Net::Server
cpanm Switch
cpanm Mail::Sendmail
cpanm Unicode::Map
cpanm Jcode
cpanm Spreadsheet::WriteExcel
cpanm OLE::Storage_Lite
cpanm Proc::ProcessTable
cpanm IO::Scalar
cpanm Spreadsheet::ParseExcel
cpanm Curses
cpanm Getopt::Long
cpanm Net::Domain
cpanm Term::ReadKey
cpanm Term::ANSIColor
cpanm Term::ReadLine::Gnu
cpanm Spreadsheet::XLSX
cpanm Spreadsheet::Read
cpanm Spreadsheet::ReadSXC
cpanm LWP::UserAgent
cpanm HTML::Entities
cpanm HTML::Strip
cpanm HTML::FormatText
cpanm HTML::TreeBuilder
cpanm Time::Local
cpanm MIME::Decoder
cpanm Mail::POP3Client
cpanm Mail::IMAPClient
cpanm Mail::Message
cpanm IO::Socket::SSL
cpanm MIME::Base64
cpanm MIME::QuotedPrint
cpanm Crypt::Eksblowfish::Bcrypt
cpanm Crypt::RC4
cpanm Text::CSV
cpanm Text::CSV_XS
cpanm readline


