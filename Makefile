default:

vm-clean-build: vm-build
	rm -f *.qcow2

vm-build:
	nix build '.#nixosConfigurations.$(HOST).config.system.build.vm' -L $(FLAGS)

vm-run:
	./result/bin/run-*-vm

vm-build-local: FLAGS=--override-input nixpkgs git+file://$(HOME)/nixpkgs
vm-build-local: vm-build

host-switch-local: FLAGS=--override-input nixpkgs git+file://$(HOME)/nixpkgs
host-switch-local: host-switch

host-switch:
	sudo nixos-rebuild switch -L --flake '.#$(HOST)' $(FLAGS)

host-boot:
	sudo nixos-rebuild boot -L --flake '.#$(HOST)'

host-build:
	nixos-rebuild build -L --flake '.#$(HOST)'
