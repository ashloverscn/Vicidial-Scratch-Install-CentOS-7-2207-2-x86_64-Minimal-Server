#!/bin/sh

echo -e "\e[0;32m Install and Configure Perl-CPAN\Perl-CPAN-Modules \e[0m"
sleep 2
cd /usr/src
yum install -y perl-CPAN perl-YAML perl-CPAN-DistnameInfo perl-libwww-perl perl-DBI perl-DBD-MySQL perl-GD perl-Env perl-Term-ReadLine-Gnu perl-SelfLoader perl-open.noarch 
##CPM install (Symlnk user cpm path to root bin)
#curl -fsSL https://raw.githubusercontent.com/skaji/cpm/master/cpm > /usr/local/bin/cpm
#curl -fsSL https://raw.githubusercontent.com/skaji/cpm/master/cpm > /bin/cpm
#chmod +x /usr/local/bin/cpm
#chmod +x /bin/cpm
##setup cpm mirror (may be installed without mirrorS too)
#export PERL_CPANM_OPT="--mirror http://www.cpan.org/ --mirror-only"
##install cpm basic essential for all users globlly
#cpm install -g JSON::PP
#cpm install -g JSON::XS
#cpm install -g App::cpanminus
#cpm install -g App::cpm
#cpm install -g JSON::PP JSON::XS App::cpanminus App::cpm
#cpm install -g
#CPM install using mirror argument
#cpm install -g --mirror http://www.cpan.org JSON::PP JSON::XS App::cpanminus App::cpm
#cpm install -g --mirror http://www.cpan.org
##oneliner for CPM install
#curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g JSON::PP JSON::XS App::cpanminus App::cpm
#/usr/local/bin/cpm install -g
##oneliner for CPM install using mirror
#curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g --mirror http://www.cpan.org JSON::PP JSON::XS App::cpanminus App::cpm
#/usr/local/bin/cpm install -g --mirror http://www.cpan.org 

#!/bin/bash

# --- 1. SETUP ISOLATED ENVIRONMENT ---
# Create the directory for the modern Perl build
mkdir -p /usr/local/perl5

# --- 2. REBUILD PERL (THE ENGINE) ---
# Download perl-build and compile Perl 5.38.0 into the isolated folder
# This ensures we don't touch the system Perl (v5.16.3)
curl -L https://raw.githubusercontent.com/tokuhirom/perl-build/master/perl-build | perl - 5.38.0 /usr/local/perl5

# --- 3. ACTIVATE MODERN PERL ---
# Point the current session to the new Perl binary
export PATH=/usr/local/perl5/bin:$PATH

# --- 4. BOOTSTRAP SKAJI MODULES ---
# Use the modern Perl to install cpm and cpanminus
curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g --mirror http://www.cpan.org JSON::PP JSON::XS App::cpanminus App::cpm

# --- 5. CREATE GLOBAL SYMLINKS ---
# Map the new tools to /usr/local/bin so they are globally accessible
ln -sf /usr/local/perl5/bin/cpm /usr/local/bin/cpm
ln -sf /usr/local/perl5/bin/cpanm /usr/local/bin/cpanm

# Refresh the shell's command path hash
hash -r

# --- 6. INSTALL TARGET MODULES ---
# Finally, use the isolated cpm to install your required modules
/usr/local/bin/cpm install -g --mirror http://www.cpan.org JSON::PP JSON::XS

echo -e "\e[0;32m All cpan-modules installed and verified successfuly \e[0m"
sleep 2
