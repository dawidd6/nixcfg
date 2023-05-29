FROM docker.io/library/ubuntu:jammy

RUN apt update && apt install -y curl

RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --extra-conf "sandbox = false" --init none --no-confirm

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

COPY flake.nix flake.lock /flake

#RUN nix profile install nixpkgs#gitMinimal nixpkgs#nil nixpkgs#alejandra
RUN nix profile install /flake#
