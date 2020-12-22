{ mkDerivation, aeson, aeson-casing, attoparsec, base, bytestring
, Cabal, criterion, fetchgit, file-embed, hashable, hashtables
, hasql, hasql-pool, hasql-transaction, mmorph, monad-control, mtl
, openssl, postgresql, postgresql-binary, postgresql-libpq, resource-pool
, retry, scientific, stdenv, template-haskell, text, text-builder
, th-lift, th-lift-instances, time, transformers-base, uuid, vector
}:
mkDerivation {
  pname = "pg-client";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/hasura/pg-client-hs.git";
    sha256 = "0shvfx2w6wxiw7y0fpza720smi3y0k27l432fi3pb4hpjhpa8h35";
    rev = "633a06ba9c1e6a561b0ad0d25951fcdf6dd054ca";
    fetchSubmodules = true;
  };
  setupHaskellDepends = [ base Cabal ];
  libraryHaskellDepends = [
    aeson aeson-casing attoparsec base bytestring hashable hashtables
    mmorph monad-control mtl postgresql-binary postgresql-libpq
    resource-pool retry scientific template-haskell text text-builder
    th-lift th-lift-instances time transformers-base uuid vector
  ];
  librarySystemDepends = [ postgresql openssl ];
  testHaskellDepends = [ base ];
  benchmarkHaskellDepends = [
    base bytestring criterion file-embed hashable hasql hasql-pool
    hasql-transaction mtl postgresql-libpq text text-builder
  ];
  homepage = "https://github.com/hasura/platform";
  license = stdenv.lib.licenses.bsd3;
}
