FROM docker.io/nixpkgs/devcontainer

ENV PATH="/root/.nix-profile/bin:${PATH}"

COPY nix.conf /etc/nix/
COPY flake.nix flake.lock /flake/

RUN nix profile install /flake
