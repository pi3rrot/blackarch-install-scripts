Blackarch Install
-----------------

Install From ArchLinux - v0.1 Release (See Github Tags)
-------------------------------------------------------
   1. Download ISO - https://www.archlinux.org/download/
	-> i.e. http://archlinux.c3sl.ufpr.br/iso/2013.12.01/archlinux-2013.12.01-dual.iso
   2. Create Vbox or VMWare Box for it - Do not use this script in real ENV.
   3. # pacman -Syyu
   4. # pacman -S git
   5. git clone https://github.com/BlackArch/blackarch-install-scripts
   6. cd blackarch-install-scripts; sed 's/SEC_ENABLE="true"/SEC_ENABLE="false"/' blackarch-install; sh blackarch-install
   7. Enjoy BlackArch!

Next Release
------------
    - Next release will come with several options:
        1. Install from LiveCD - Dump everything to your partition.
        2. Install from Repository - Install packages you choose From BlackArch Official Repository.
        3. Install from Blackman - Download And Compile Packages from their PKGBUILD.
