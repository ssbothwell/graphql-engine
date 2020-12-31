{ mkDerivation, base, bytestring, ChasingBottoms, containers
, deepseq, fetchgit, gauge, hashable, hashmap, HUnit, mtl
, QuickCheck, random, stdenv, test-framework, test-framework-hunit
, test-framework-quickcheck2
}:
mkDerivation {
  pname = "unordered-containers";
  version = "0.2.13.0";
  src = fetchgit {
    url = "https://github.com/haskell-unordered-containers/unordered-containers.git";
    sha256 = "1m5h3p4qzl78zdicw9hmf7dwdl2gx6zxvspbg51bny2hy3yz5mj7";
    rev = "9d3a2970cd76d31bb4fab7a4611c8d6c43eb7354";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [ base deepseq hashable ];
  testHaskellDepends = [
    base ChasingBottoms containers hashable HUnit QuickCheck random
    test-framework test-framework-hunit test-framework-quickcheck2
  ];
  benchmarkHaskellDepends = [
    base bytestring containers deepseq gauge hashable hashmap mtl
    random
  ];
  homepage = "https://github.com/haskell-unordered-containers/unordered-containers";
  description = "Efficient hashing-based container types";
  license = stdenv.lib.licenses.bsd3;
}
