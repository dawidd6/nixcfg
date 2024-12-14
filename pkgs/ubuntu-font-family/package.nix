# Pinning this font to v0.83,
# because newer version of it is garbage IMO
{ stdenvNoCC, fetchzip }:
stdenvNoCC.mkDerivation rec {
  pname = "ubuntu-font-family";
  version = "0.83";

  src = fetchzip {
    url = "https://assets.ubuntu.com/v1/fad7939b-ubuntu-font-family-${version}.zip";
    hash = "sha256-FAg1xn8Gcbwmuvqtg9SquSet4oTT9nqE+Izeq7ZMVcA=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/ubuntu
    mv *.ttf $out/share/fonts/ubuntu
    runHook postInstall
  '';
}
