final: prev: {
  discord-desktop-mobile = final.callPackage ./discord-desktop-mobile.nix { };
  sorter = final.callPackage ./sorter.nix { };
  recorder = final.callPackage ./recorder.nix { };
  pawncc = final.callPackage ./pawncc.nix { };
  ferdium = final.callPackage ./ferdium.nix { };
  assets = final.callPackage ./assets.nix { };
  manhattan-cafe = final.callPackage ./manhattan-cafe.nix { };
}
