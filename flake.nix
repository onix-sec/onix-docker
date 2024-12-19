{
  description = "Onix Docker container builder";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixsecpkgs = {
      url = "github:onix-sec/nixsecpkgs";
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

          version = "0.2.0";
          created = "2024-12-19T11:53:35+00:00";
        in
        pkgs.dockerTools.buildLayeredImage {
          name = "onix";
          tag = version;
          created = created;

          # Docker support up to 128, restricting allow user to extend the image
          maxLayers = 64;

          config = {
            Hostname = "onix";
            User = "1000";

            # https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
            Labels = {
              "org.opencontainers.image.created" = created;
              "org.opencontainers.image.authors" = "onix-sec";
              "org.opencontainers.image.url" = "https://github.com/onix-sec/onix-docker";
              "org.opencontainers.image.documentation" =
                "https://github.com/onix-sec/onix-docker/blob/main/README.md";
              "org.opencontainers.image.source" = "https://github.com/onix-sec/onix-docker";
              "org.opencontainers.image.version" = version;
              "org.opencontainers.image.revision" = if (self ? shortRev) then self.shortRev else "dirty";
              "org.opencontainers.image.vendor" = "onix-sec";
              "org.opencontainers.image.licenses" = "MIT";
              "org.opencontainers.image.ref.name" = version;
              "org.opencontainers.image.title" = "Onix";
              "org.opencontainers.image.description" = "Image containing a collection of cybersecurity tools";
              # "org.opencontainers.image.base.name" = "";
            };
          };

          contents = with pkgs; [
            dockerTools.usrBinEnv
            dockerTools.binSh
            dockerTools.caCertificates

            # https://nixos.org/manual/nixpkgs/stable/#sec-fakeNss
            (dockerTools.fakeNss.override {
              extraPasswdLines = [ "user:x:1000:1000:user:/var/empty:/bin/sh" ];
              extraGroupLines = [ "user:x:1000:" ];
            })

            # shells
            bash
            zsh

            # utils
            coreutils
            tmux
            curl
            wget

            # custom from nixsecpkgs
            awrbacs
            buster
            byp4xx
            carbon14
            cmsmap
            crackhound
            dfscoerce
            entropy
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
            homoglyph
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

            # nixpkgs
            adidnsdump
            aircrack-ng
            amass
            amber
            androguard
            android-tools # android-tools-adb
            anew
            apksigner
            apktool
            arjun
            arsenal
            ascii
            assetfinder
            autoconf
            avrdude
            awscli
            bettercap
            binwalk
            bloodhound
            bolt
            brakeman
            bruteforce-luks
            bully
            burpsuite
            certipy
            certsync
            cewl
            chisel
            python312Packages.cloudsplaining
            coercer
            cowpatty
            netexec # maintained fork of crackmapexec
            crunch
            dex2jar
            dirb
            das # divideandscan
            dns2tcp
            dnschef
            dnsenum
            dnsx
            donpapi
            enum4linux-ng
            evil-winrm
            exif
            exifprobe
            exiftool
            exiv2
            eyewitness
            fcrackzip
            feroxbuster
            ffuf
            fierce
            findomain
            firefox
            foremost
            freerdp3 # freerdp2-x11
            frida-tools
            gau
            gf
            ghidra
            git # gittools
            gobuster
            gowitness
            gqrx
            gron
            h8mail
            hackrf
            hakrawler
            hashcat
            hcxdumptool
            hcxtools
            hexedit
            holehe
            hping # hping3
            httprobe
            httpx
            imagemagick
            python312Packages.impacket
            ipinfo
            iptables
            jadx
            john
            joomscan
            # jwt-cli # jwt
            jwt-hack
            kerbrute
            kiterunner
            kubectl
            python312Packages.ldapdomaindump
            openldap # ldapsearch
            ldeep
            libmspack
            libnfc
            # libnfc # libnfc-crypto1-crack
            libusb1
            ligolo-ng
            xnlinkfinder # linkfinder
            python312Packages.lsassy # lsassy
            ltrace
            maltego
            libmysqlclient # mariadb-client
            python312Packages.masky # masky
            masscan
            mdcat
            metasploit
            mfcuk
            mfoc
            minicom
            mitm6
            naabu
            python312Packages.name-that-hash # name-that-hash
            nasm
            nbtscan
            neo4j
            netdiscover
            conntrack-tools # nfct
            ngrok
            nmap
            nuclei
            onesixtyone
            python311Packages.patator
            pdfcrack
            photon
            php
            powershell
            pre2k
            prowler
            proxmark3
            proxychains
            pwncat
            pwninit
            pwndbg
            pwntools
            python312Packages.pypykatz
            radare2
            rdesktop
            reaverwps
            remmina
            responder
            rlwrap
            rockyou
            rsync
            rtl_433 # rtl-433
            ruler
            samdump2
            scout
            scrcpy
            exploitdb # searchsploit
            seclists
            semgrep
            sipvicious
            sleuthkit
            samba # smbclient
            smbmap
            soapui # SoapUI
            sqlmap
            ssh-audit
            sshuttle
            sslscan
            strace
            subfinder
            swaks
            tailscale
            tcpdump
            testdisk
            testssl
            theharvester
            tor
            traceroute
            trilium-desktop
            tshark
            updog
            username-anarchy
            util-linux
            volatility3
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
            yt-dlp
            zsteg

            # additionnal
            wordlists
            dalfox
            dnsrecon
            dnstwist
            nikto
            snallygaster
            webanalyze
          ];
        };
    };
}
