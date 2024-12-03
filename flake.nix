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

            # from nixsecpkgs
            awrbacs
            buster
            byp4xx
            carbon14
            cmsmap
            crackhound
            dfscoerce
            finduncommonshares
            git-dumper
            gmsadumper
            go-bhtool
            go-evilarc
            go-windapsearch
            goldencopy
            gosecretsdump
            goshs
            gpp-decrypt
            haiti
            hakrevdns
            hashonymize
            jackit
            keyt
            pof
            pywhisket
            robotstester
            shellerator
            shuffledns
            smartbrute
            smtp-user-enum
            sprayhound
            sublist3r
            toutatis
            uberfile
            waybackurls
            webclientservicescanner
            whatportis
            xsser

            # aclpwn
            adidnsdump
            aircrack-ng
            amass
            amber
            androguard
            android-tools # android-tools-adb
            anew
            # python311Packages.angr # FIXME: broken
            apksigner
            apktool
            arjun
            arsenal
            ascii
            assetfinder
            autoconf
            # autorecon
            avrdude
            awscli
            bettercap
            binwalk
            bloodhound
            # bloodhound-import
            # bloodhound-quickwin
            # bloodhound.py
            bolt
            # bqm
            brakeman
            bruteforce-luks
            bully
            burpsuite
            # byp4xx
            # carbon14
            certipy
            certsync
            cewl
            # checksec-py
            chisel
            # cloudfail
            # cloudmapper
            python312Packages.cloudsplaining
            # cloudsploit
            # clusterd
            # cmsmap
            coercer
            # constellation
            # corscanner
            cowpatty
            # crackhound
            netexec # maintained fork of crackmapexec
            crunch
            # cupp
            # cyperoth
            # darkarmour
            dex2jar
            # dfscoerce
            dirb
            # dirsearch
            das # divideandscan
            dns2tcp
            dnschef
            dnsenum
            dnsx
            donpapi
            # droopescan
            # drupwn
            # eaphammer
            enum4linux-ng
            # enyx
            evil-winrm
            exif
            exifprobe
            exiftool
            exiv2
            eye-witness
            fcrackzip
            feroxbuster
            ffuf
            fierce
            # finalrecon
            findomain
            # finduncommonshares
            firefox
            foremost
            freerdp3 # freerdp2-x11
            frida-tools
            # fuxploider
            gau
            # genusernames
            gf
            ghidra
            # git-dumper
            # githubemail
            git # gittools
            gobuster
            # gopherus
            # gosecretsdump
            gowitness
            gqrx
            gron
            # h2csmuggler
            h8mail
            hackrf
            hakrawler
            hashcat
            # hashonymize
            hcxdumptool
            hcxtools
            hexedit
            holehe
            hping # hping3
            # httpmethods
            httprobe
            httpx
            # hydra
            # ida-free # FIXME: fails to build
            # ignorant
            imagemagick
            python312Packages.impacket
            # infoga
            ipinfo
            iptables
            jadx
            # jd-gui # FIXME fails to build
            # jdwp
            john
            joomscan
            # jwt-cli # jwt
            jwt-hack
            # kadimus
            # KeePwn
            kerbrute
            kiterunner
            # Kraken
            # krbrelayx
            kubectl
            python312Packages.ldapdomaindump
            # ldaprelayscan
            openldap # ldapsearch
            # ldapsearch-ad
            ldeep
            libmspack
            libnfc
            # libnfc # libnfc-crypto1-crack
            libusb1
            ligolo-ng
            # linkedin2username
            xnlinkfinder # linkfinder
            # lnkup
            python312Packages.lsassy # lsassy
            ltrace
            # maigret # FIXME: build fails
            maltego
            # manspider
            libmysqlclient # mariadb-client
            python312Packages.masky # masky
            masscan
            mdcat
            metasploit
            mfcuk
            # mfdread
            mfoc
            minicom
            mitm6
            # moodlescan
            # mousejack
            # msprobe
            naabu
            python312Packages.name-that-hash # name-that-hash
            nasm
            nbtscan
            neo4j
            netdiscover
            conntrack-tools # nfct
            ngrok
            nmap
            # noPac
            # nosqlmap
            # ntlmv1-multi
            nuclei
            # oaburl
            # objection
            # objectwalker
            # oneforall
            onesixtyone
            # osrframework
            # pass
            # PassTheCert
            python311Packages.patator
            # pcredz
            # pcsclite # pcsc
            pdfcrack
            # peepdf
            # petitpotam
            # phoneinfoga
            photon
            php
            # filter
            # chain
            # generator
            # phpggc
            # pkinittools
            # polenum
            powershell
            pre2k
            # prips
            # privexchange
            prowler
            proxmark3
            proxychains
            # pst-utils
            # pth-tools
            pwncat
            # pwndb
            pwndbg
            # pwnedornot
            pwninit
            pwntools
            # pygpoabuse
            # pykek
            # pylaps
            python312Packages.pypykatz
            # pyrit
            # pywhisker
            # pywsus
            radare2
            rdesktop
            reaverwps
            # recon-ng
            # recondog
            # redis-tools
            remmina
            responder
            rlwrap
            # roastinthemiddle
            rockyou
            # routersploit # FIXME: fail tests
            # rsactftool
            rsync
            rtl_433 # rtl-433
            ruler
            # rusthound
            samdump2
            scout
            scrcpy
            exploitdb # searchsploit
            seclists
            semgrep
            # shadowcoerce
            # simplyemail
            sipvicious
            sleuthkit
            # sliver
            # smali
            samba # smbclient
            smbmap
            # smuggler
            soapui # SoapUI
            # spiderfoot
            sqlmap
            ssh-audit
            sshuttle
            sslscan
            # ssrfmap
            # steghide
            # stegolsb
            # stegosuite
            strace
            subfinder
            swaks
            # symfony-exploits
            tailscale
            # targetedKerberoast
            tcpdump
            testdisk
            testssl
            theharvester
            # timing
            # tls-map
            # tls-scanner
            # tomcatwardeployer
            tor
            traceroute
            # trevorspray
            # trid
            trilium-desktop
            tshark
            updog
            username-anarchy
            util-linux
            volatility3
            # vulny-code-static-analysis
            wabt
            wafw00f
            weevely
            wfuzz
            whatweb
            whois
            wifite2
            wireshark
            wpscan
            wuzz
            # XSpear
            # xsrfprobe
            # xsstrike
            # tightvnc # FIXME: not maintained anymore
            yt-dlp
            # ysoserial
            # zerologon
            # zipalign
            zsteg

            # added:
            wordlists
            dalfox
            dnsrecon
            dnstwist
            nikto
            # pagodo
            # https://github.com/Ge0rg3/requests-ip-rotator
            # https://github.com/RetireJS/retire.js
            snallygaster
            webanalyze
          ];
        };
    };
}
