{ runCommandNoCCLocal, inputs }:
runCommandNoCCLocal "scripts" { } ''
  mkdir -p $out
  cp -R ${inputs.self}/scripts $out/bin
''
