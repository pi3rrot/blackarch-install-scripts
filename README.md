Blackarch Install
-----------------

Install From ArchLinux
------------------------
   1. Download ISO - https://www.archlinux.org/download/
	-> i.e. http://archlinux.c3sl.ufpr.br/iso/2013.12.01/archlinux-2013.12.01-dual.iso
   2. Create Vbox or VMWare Box for it - Do not use this script in real ENV.
   3. # pacman -Syyu
   4. # pacman -S git
   5. git clone https://github.com/BlackArch/blackarch-install-scripts
   6. cd blackarch-install-scripts; sed 's/SEC_ENABLE="true"/SEC_ENABLE="false"/' blackarch-install; sh blackarch-install
   7. Enjoy BlackArch!
