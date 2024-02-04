HOST ?= $(shell hostname)
NIXPKGS ?= git+file://$(HOME)/nixpkgs

_:

# VM
vm-build-local: FLAGS=--override-input nixpkgs $(NIXPKGS)
vm-build-local: vm-build
vm-build:
	nix build '.#nixosConfigurations.$(HOST).config.system.build.vm' -L $(FLAGS)

vm-clean:
	rm -f $(HOST).qcow2

vm-run:
	./result/bin/run-$(HOST)-vm

# HOST
host-switch-local: FLAGS=--override-input nixpkgs $(NIXPKGS)
host-switch-local: host-switch
host-switch:
	sudo nixos-rebuild dry-activate -L --flake '.#$(HOST)' $(FLAGS)
	@read -p 'Proceed?'
	sudo nixos-rebuild switch -L --flake '.#$(HOST)' $(FLAGS)

host-boot:
	sudo nixos-rebuild dry-activate -L --flake '.#$(HOST)' $(FLAGS)
	@read -p 'Proceed?'
	sudo nixos-rebuild boot -L --flake '.#$(HOST)'

host-build:
	nixos-rebuild build -L --flake '.#$(HOST)'
