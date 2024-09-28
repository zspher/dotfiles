{
  lib,
  fetchPypi,
  python3Packages,
  buildPythonApplication,
  makeDesktopItem,
  copyDesktopItems,
}:
buildPythonApplication rec {
  pname = "fotokilof";
  version = "4.4.8";
  pyproject = true;

  src = fetchPypi {
    pname = "FotoKilof";
    inherit version;
    hash = "sha256-BUWMqGeiMbfczwuFbH+4xtw7FlIyxQWX/weVsg9soLk=";
  };

  nativeBuildInputs = [ copyDesktopItems ];

  build-system = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    pillow
    requests
    (callPackage ../python-tkkbootstrap { })
    wand
    tkinter
    pip
  ];

  desktopItems = [
    (makeDesktopItem {
      desktopName = "FotoKilof";
      name = "FotoKilof";
      exec = "fotokilof";
      comment = "GUI for ImageMagick";
      categories = [
        "Graphics"
        "Utility"
        "Photography"
      ];
    })
  ];
  meta = with lib; {
    description = "Nice gui for ImageMagick";
    homepage = "https://pypi.org/project/FotoKilof";
    license = licenses.mit;
    maintainers = with maintainers; [ zspher ];
    mainProgram = "fotokilof";
  };
}
