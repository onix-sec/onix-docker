# Onix Docker

Onix Docker container builder with Nix flake.

## Usage

```bash
docker pull ghcr.io/onix-sec/onix:0.1.0
docker run -it --rm ghcr.io/onix-sec/onix:0.1.0 bash
```

## Build

Build the Docker image from source.

### Requirements

- [Nix](https://nixos.org/download/)
- Configure Nix to allow `nix-command` and `flakes`:

  ```bash
  mkdir ~/.config/nix
  cat > ~/.config/nix/nix.config << EOF
  experimental-features = nix-command flakes
  EOF
  ```

### Build

Edit `flake.nix` to choose the tools you need.

```bash
nix build .
docker load < ./result
```

> [!NOTE]
> To create an image with every tool, you'll need to download 4.1 GiB and have 24 GiB on disk.
> The compressed Docker image will weight 7.8Gb and once loaded it's 20Gb.

Then run bash in it:

```bash
docker run -it --rm onix bash
```

Or execute a single tool inside the container:

```bash
docker run --rm onix nmap --help
```

For interactive tools use `-it` flag:

```bash
docker run --rm -it onix keyt -o
```

## Develop

Update flakes:

```bash
nix flake update
```

## TODO

- Automatically build the image and push it to a registry with a CI
- Create a user inside the container

## License

Onix Docker is licensed under [MIT](./LICENSE).
