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
          created = "2024-12-19T11:48:02+00:00";
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

          ];
        };
    };
}
