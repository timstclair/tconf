# Local setup, called from tconf/setup.sh

INPUT=$TCONF/local

hml shell/bash_profile .bash_profile
hml etc/xinitrc .xinitrc
hml etc/yaourtrc .yaourtrc
hml etc/gpg-agent.conf .gnupg/gpg-agent.conf
hml etc/pam_environment .pam_environment
