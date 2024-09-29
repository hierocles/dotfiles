{ buildPythonPackage
, fetchPypi
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "qBitrr2";
  version = "4.9.6";

  src = fetchPypi {
    inherit pname version;
    hash = "bfde0ddcf6fdbca47256991e2e608d1d8872c55a00e3884ff9f8329911e79f51";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}