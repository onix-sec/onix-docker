# Onix Docker

Onix Docker container builder with Nix and flakes.

## Usage

### Requirements

- [Nix](https://nixos.org/download/)
- Configure Nix to allow `nix-command` and `flakes`:

  ```bash
  mkdir ~/.config/nix
  cat > ~/.config/nix/nix.config << EOF
  experimental-features = nix-command flakes
  EOF
  ```

### Install

```bash
git clone https://github.com/onix-sec/onix-vm.git
cd onix-vm
```

Edit `flake.nix` to choose the tools you need.

```bash
nix build .
docker load < ./result
docker run -it --rm onix bash
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
