{
  description = "Onix Docker container builder";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixsecpkgs = {
      url = "github:deoktr/nixsecpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixsecpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      packages."${system}".default =
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ nixsecpkgs.overlays.default ];
          };
        in
        pkgs.dockerTools.buildLayeredImage {
          name = "onix";
          tag = "latest";
          contents = with pkgs; [
            bash

            # awrbacs
            # buster
            # byp4xx
            # carbon14
            # cmsmap
            # crackhound
            # dfscoerce
            # entropy
            # finduncommonshares
            # git-dumper
            # gmsadumper
            # go-bhtool
            # go-evilarc
            # go-windapsearch
            # goldencopy
            # gosecretsdump
            # goshs
            # gpp-decrypt
            # haiti
            # hakrevdns
            # hashonymize
            # homoglyph
            # jackit
            # keyt
            # pof
            # pywhisket
            # robotstester
            # shellerator
            # shuffledns
            # smartbrute
            # smtp-user-enum
            # sprayhound
            # sublist3r
            # toutatis
            # uberfile
            # waybackurls
            # webclientservicescanner
            # whatportis
            # xsser

            # adidnsdump
            # aircrack-ng
            # amass
            # amber
            # androguard
            # android-tools # android-tools-adb
            # anew
            # apksigner
            # apktool
            # arjun
            # arsenal
            # ascii
            # assetfinder
            # autoconf
            # avrdude
            # awscli
            # bettercap
            # binwalk
            # bloodhound
            # bolt
            # brakeman
            # bruteforce-luks
            # bully
            # burpsuite
            # certipy
            # certsync
            # cewl
            # chisel
            # python312Packages.cloudsplaining
            # coercer
            # cowpatty
            # netexec # maintained fork of crackmapexec
            # crunch
            # dex2jar
            # dirb
            # das # divideandscan
            # dns2tcp
            # dnschef
            # dnsenum
            # dnsx
            # donpapi
            # enum4linux-ng
            # evil-winrm
            # exif
            # exifprobe
            # exiftool
            # exiv2
            # eye-witness
            # fcrackzip
            # feroxbuster
            # ffuf
            # fierce
            # findomain
            # firefox
            # foremost
            # freerdp3 # freerdp2-x11
            # frida-tools
            # gau
            # gf
            # ghidra
            # git # gittools
            # gobuster
            # gowitness
            # gqrx
            # gron
            # h8mail
            # hackrf
            # hakrawler
            # hashcat
            # hcxdumptool
            # hcxtools
            # hexedit
            # holehe
            # hping # hping3
            # httprobe
            # httpx
            # imagemagick
            # python312Packages.impacket
            # ipinfo
            # iptables
            # jadx
            # john
            # joomscan
            # # jwt-cli # jwt
            # jwt-hack
            # kerbrute
            # kiterunner
            # kubectl
            # python312Packages.ldapdomaindump
            # openldap # ldapsearch
            # ldeep
            # libmspack
            # libnfc
            # # libnfc # libnfc-crypto1-crack
            # libusb1
            # ligolo-ng
            # xnlinkfinder # linkfinder
            # python312Packages.lsassy # lsassy
            # ltrace
            # maltego
            # libmysqlclient # mariadb-client
            # python312Packages.masky # masky
            # masscan
            # mdcat
            # metasploit
            # mfcuk
            # mfoc
            # minicom
            # mitm6
            # naabu
            # python312Packages.name-that-hash # name-that-hash
            # nasm
            # nbtscan
            # neo4j
            # netdiscover
            # conntrack-tools # nfct
            # ngrok
            nmap
            # nuclei
            # onesixtyone
            # python311Packages.patator
            # pdfcrack
            # photon
            # php
            # powershell
            # pre2k
            # prowler
            # proxmark3
            # proxychains
            # pwncat
            # pwninit
            # pwndbg
            # pwntools
            # python312Packages.pypykatz
            # radare2
            # rdesktop
            # reaverwps
            # remmina
            # responder
            # rlwrap
            # rockyou
            # rsync
            # rtl_433 # rtl-433
            # ruler
            # samdump2
            # scout
            # scrcpy
            # exploitdb # searchsploit
            # seclists
            # semgrep
            # sipvicious
            # sleuthkit
            # samba # smbclient
            # smbmap
            # soapui # SoapUI
            # sqlmap
            # ssh-audit
            # sshuttle
            # sslscan
            # strace
            # subfinder
            # swaks
            # tailscale
            # tcpdump
            # testdisk
            # testssl
            # theharvester
            # tor
            # traceroute
            # trilium-desktop
            # tshark
            # updog
            # username-anarchy
            # util-linux
            # volatility3
            # wabt
            # wafw00f
            # weevely
            # wfuzz
            # whatweb
            # whois
            # wifite2
            # wireshark
            # wpscan
            # wuzz
            # yt-dlp
            # zsteg

            # wordlists
            # dalfox
            # dnsrecon
            # dnstwist
            # nikto
            # snallygaster
            # webanalyze
          ];
        };
    };
}
