{ mkDerivation, aeson, aeson-casing, base, fetchgit, hashable
, hpack, stdenv, template-haskell, text, th-lift-instances
, unordered-containers
}:
mkDerivation {
  pname = "ci-info";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/hasura/ci-info-hs.git";
    sha256 = "1hfbmyz8lwjzwji8zslsib89sw2a6ay3b0qrm4xdk6m8iiwf4ip5";
    rev = "947fd56582b1e8bec9ffed98ca9ac2f6b63e36c9";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    aeson aeson-casing base hashable template-haskell text
    th-lift-instances unordered-containers
  ];
  libraryToolDepends = [ hpack ];
  prePatch = "hpack";
  homepage = "https://github.com/hasura/ci-info-hs#readme";
  license = stdenv.lib.licenses.mit;
}
