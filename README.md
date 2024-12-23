# Onix Docker

Onix Docker container builder with Nix flake.

## Usage

Requirements:

- Docker (or any other container runtime)
- 21 GB of disk space

```bash
docker pull ghcr.io/onix-sec/onix:latest
docker run -it --rm ghcr.io/onix-sec/onix:latest bash
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

### Build Image

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
- Script to add `org.opencontainers.image.base.digest` label with the [digest](https://github.com/opencontainers/image-spec/blob/main/descriptor.md#digests) after the build

## License

Onix Docker is licensed under [MIT](./LICENSE).
