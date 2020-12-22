{ mkDerivation, aeson, aeson-casing, ansi-wl-pprint, asn1-encoding
, asn1-types, async, attoparsec, attoparsec-iso8601, auto-update
, base, base16-bytestring, base64-bytestring, bifunctors, binary
, byteorder, bytestring, case-insensitive, ci-info, containers
, criterion, cron, cryptonite, data-has, deepseq, dependent-map
, dependent-sum, directory, ekg-core, ekg-json, exceptions
, fast-logger, file-embed, filepath, generic-arbitrary
, ghc-heap-view, graphql-parser, hashable, hspec, hspec-core
, hspec-expectations-lifted, http-api-data, http-client
, http-client-tls, http-types, immortal, insert-ordered-containers
, jose, lens, lens-aeson, lifted-async, lifted-base, list-t
, mime-types, mmorph, monad-control, monad-time, monad-validate
, mtl, mustache, mwc-probability, mwc-random
, natural-transformation, network, network-uri
, optparse-applicative, pem, pg-client, postgresql-binary
, postgresql-libpq, process, profunctors, psqueues, QuickCheck
, quickcheck-instances, random, regex-tdfa, safe, scientific
, semialign, semigroups, semver, shakespeare, split, Spock-core
, stdenv, stm, stm-containers, template-haskell, text, text-builder
, text-conversions, th-lift-instances, these, time, transformers
, transformers-base, unix, unordered-containers, uri-encode, uuid
, validation, vector, vector-builder, wai, wai-websockets, warp
, websockets, witherable, wreq, x509, yaml, zlib
}:
mkDerivation {
  pname = "graphql-engine";
  version = "1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson aeson-casing ansi-wl-pprint asn1-encoding asn1-types async
    attoparsec attoparsec-iso8601 auto-update base base16-bytestring
    base64-bytestring bifunctors binary byteorder bytestring
    case-insensitive ci-info containers cron cryptonite data-has
    deepseq dependent-map dependent-sum directory ekg-core ekg-json
    exceptions fast-logger file-embed filepath generic-arbitrary
    ghc-heap-view graphql-parser hashable http-api-data http-client
    http-client-tls http-types immortal insert-ordered-containers jose
    lens lens-aeson lifted-async lifted-base list-t mime-types mmorph
    monad-control monad-time monad-validate mtl mustache network
    network-uri optparse-applicative pem pg-client postgresql-binary
    postgresql-libpq process profunctors psqueues QuickCheck
    quickcheck-instances random regex-tdfa safe scientific semialign
    semigroups semver shakespeare split Spock-core stm stm-containers
    template-haskell text text-builder text-conversions
    th-lift-instances these time transformers transformers-base unix
    unordered-containers uri-encode uuid validation vector
    vector-builder wai wai-websockets warp websockets witherable wreq
    x509 yaml zlib
  ];
  executableHaskellDepends = [
    base bytestring ekg-core pg-client text text-conversions time unix
  ];
  testHaskellDepends = [
    aeson base bytestring hspec hspec-core hspec-expectations-lifted
    http-client http-client-tls http-types jose lifted-base
    monad-control mtl natural-transformation optparse-applicative
    pg-client process QuickCheck safe split text time transformers-base
    unordered-containers
  ];
  benchmarkHaskellDepends = [
    async base bytestring criterion deepseq mwc-probability mwc-random
    split text vector
  ];
  homepage = "https://www.hasura.io";
  description = "GraphQL API over Postgres";
  license = stdenv.lib.licenses.asl20;
}
