{ mkDerivation, base, fetchgit, hashable, monad-control, stdenv
, stm, time, transformers, transformers-base, vector
}:
mkDerivation {
  pname = "resource-pool";
  version = "0.2.3.2";
  src = fetchgit {
    url = "https://github.com/hasura/pool.git";
    sha256 = "1298v5x8lrrvvd5z9wkdyvi76v30zhd3kcbjhryz6gws2mhgpg3a";
    rev = "0fdfaed4e109ca6a6bf00ed6d79c329626e3bdd4";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base hashable monad-control stm time transformers transformers-base
    vector
  ];
  homepage = "http://github.com/bos/pool";
  description = "A high-performance striped resource pooling implementation";
  license = stdenv.lib.licenses.bsd3;
}
