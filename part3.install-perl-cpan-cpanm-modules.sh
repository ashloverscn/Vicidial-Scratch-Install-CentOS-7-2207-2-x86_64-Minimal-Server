#!/bin/sh

export PERL_MM_USE_DEFAULT=1
export PERL_EXTUTILS_AUTOINSTALL="--defaultdeps"
export PERL_CPANM_OPT="--notest --force --skip-satisfied"

echo -e "\e[0;32m Install and Configure Perl-CPAN\Perl-CPAN-Modules \e[0m"
sleep 2
yum -y install perl-CPAN perl-YAML perl-libwww-perl perl-DBI perl-DBD-MySQL perl-GD perl-Env perl-Term-ReadLine-Gnu perl-SelfLoader perl-open.noarch

perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit' 

cd /usr/bin/

\cp -r /usr/src/cpanm ./cpanm

cpan -T -i App::cpanminus 

chmod +x cpanm

./cpanm -n -f File::HomeDir
./cpanm -n -f File::Which
./cpanm -n CPAN::Meta::Requirements
./cpanm -n -f CPAN
./cpanm -n Tk::TableMatrix
./cpanm -n RPM::Specfile
./cpanm -n YAML
./cpanm -n MD5
./cpanm -n String::CRC
./cpanm -n Digest::MD5
./cpanm -n Digest::SHA1
./cpanm -n Bundle::CPAN
./cpanm -n DBI
./cpanm -n -f DBD::mysql
./cpanm -n Net::Address::IP::Local
./cpanm -n Net::Address::IPv4::Local
./cpanm -n Net::Telnet
./cpanm -n Time::HiRes
./cpanm -n Net::Server
./cpanm -n Switch
./cpanm -n Mail::Sendmail
./cpanm -n Unicode::Map
./cpanm -n Jcode
./cpanm -n Spreadsheet::WriteExcel
./cpanm -n OLE::Storage_Lite
./cpanm -n Proc::ProcessTable
./cpanm -n IO::Scalar
./cpanm -n Spreadsheet::ParseExcel
./cpanm -n Curses
./cpanm -n Getopt::Long
./cpanm -n Net::Domain
./cpanm -n Term::ReadKey
./cpanm -n Term::ANSIColor
./cpanm -n Term::ReadLine::Gnu
./cpanm -n Spreadsheet::XLSX
./cpanm -n Spreadsheet::Read
./cpanm -n Spreadsheet::ReadSXC
./cpanm -n LWP::UserAgent
./cpanm -n HTML::Entities
./cpanm -n HTML::Strip
./cpanm -n HTML::FormatText
./cpanm -n HTML::TreeBuilder
./cpanm -n Time::Local
./cpanm -n MIME::Decoder
./cpanm -n Mail::POP3Client
./cpanm -n Mail::IMAPClient
./cpanm -n Mail::Message
./cpanm -n IO::Socket::SSL
./cpanm -n MIME::Base64
./cpanm -n MIME::QuotedPrint
./cpanm -n Crypt::Eksblowfish::Bcrypt
./cpanm -n Crypt::RC4
./cpanm -n Text::CSV
./cpanm -n Text::CSV_XS

echo -e "\e[0;32m Verify all cpan-modules installed successfuly \e[0m"
sleep 2

./cpanm -n File::HomeDir
./cpanm -n File::Which
./cpanm -n CPAN::Meta::Requirements
./cpanm -n CPAN
./cpanm -n Tk::TableMatrix
./cpanm -n RPM::Specfile
./cpanm -n YAML
./cpanm -n MD5
./cpanm -n String::CRC
./cpanm -n Digest::MD5
./cpanm -n Digest::SHA1
./cpanm -n Bundle::CPAN
./cpanm -n DBI
./cpanm -n DBD::mysql
./cpanm -n Net::Address::IP::Local
./cpanm -n Net::Address::IPv4::Local
./cpanm -n Net::Telnet
./cpanm -n Time::HiRes
./cpanm -n Net::Server
./cpanm -n Switch
./cpanm -n Mail::Sendmail
./cpanm -n Unicode::Map
./cpanm -n Jcode
./cpanm -n Spreadsheet::WriteExcel
./cpanm -n OLE::Storage_Lite
./cpanm -n Proc::ProcessTable
./cpanm -n IO::Scalar
./cpanm -n Spreadsheet::ParseExcel
./cpanm -n Curses
./cpanm -n Getopt::Long
./cpanm -n Net::Domain
./cpanm -n Term::ReadKey
./cpanm -n Term::ANSIColor
./cpanm -n Term::ReadLine::Gnu
./cpanm -n Spreadsheet::XLSX
./cpanm -n Spreadsheet::Read
./cpanm -n Spreadsheet::ReadSXC
./cpanm -n LWP::UserAgent
./cpanm -n HTML::Entities
./cpanm -n HTML::Strip
./cpanm -n HTML::FormatText
./cpanm -n HTML::TreeBuilder
./cpanm -n Time::Local
./cpanm -n MIME::Decoder
./cpanm -n Mail::POP3Client
./cpanm -n Mail::IMAPClient
./cpanm -n Mail::Message
./cpanm -n IO::Socket::SSL
./cpanm -n MIME::Base64
./cpanm -n MIME::QuotedPrint
./cpanm -n Crypt::Eksblowfish::Bcrypt
./cpanm -n Crypt::RC4
./cpanm -n Text::CSV
./cpanm -n Text::CSV_XS
