# Onix Docker

Onix Docker container builder with Nix and flakes.

## Usage

```bash
nix build github:onix-sec/onix-docker
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
