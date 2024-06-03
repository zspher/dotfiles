{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  pillow,
  tkinter,
}:
buildPythonPackage rec {
  pname = "ttkbootstrap";
  version = "1.10.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-U5JVJcQQT540VidQDc7S0Dkq10MksqgUZ6ruP/vhpHQ=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    pillow
    tkinter
  ];

  pythonImportsCheck = ["ttkbootstrap"];

  meta = with lib; {
    description = "A supercharged theme extension for tkinter that enables on-demand modern flat style themes inspired by Bootstrap";
    homepage = "https://pypi.org/project/ttkbootstrap";
    license = licenses.mit;
    maintainers = with maintainers; [zspher];
  };
}
