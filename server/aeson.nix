{ mkDerivation, attoparsec, base, base-compat
, base-compat-batteries, base-orphans, base16-bytestring
, bytestring, containers, data-fix, deepseq, Diff, directory, dlist
, fetchgit, filepath, generic-deriving, ghc-prim, hashable
, hashable-time, integer-logarithms, primitive, QuickCheck
, quickcheck-instances, scientific, stdenv, strict, tagged, tasty
, tasty-golden, tasty-hunit, tasty-quickcheck, template-haskell
, text, th-abstraction, these, time, time-compat
, unordered-containers, uuid-types, vector
}:
mkDerivation {
  pname = "aeson";
  version = "1.5.4.1";
  src = fetchgit {
    url = "https://github.com/haskell/aeson";
    rev = "8579faf30e0f977425fbf330038fb1d5c2c34727";
    sha256 = "1arx13q4frc40vch8qrgybi78z8yxkvskl4gr1c8ygjv9miyfhr1";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    attoparsec base base-compat-batteries bytestring containers
    data-fix deepseq dlist ghc-prim hashable primitive scientific
    strict tagged template-haskell text th-abstraction these time
    time-compat unordered-containers uuid-types vector
  ];
  testHaskellDepends = [
    attoparsec base base-compat base-orphans base16-bytestring
    bytestring containers data-fix Diff directory dlist filepath
    generic-deriving ghc-prim hashable hashable-time integer-logarithms
    QuickCheck quickcheck-instances scientific strict tagged tasty
    tasty-golden tasty-hunit tasty-quickcheck template-haskell text
    these time time-compat unordered-containers uuid-types vector
  ];
  homepage = "https://github.com/bos/aeson";
  description = "Fast JSON parsing and encoding";
  license = stdenv.lib.licenses.bsd3;
}
