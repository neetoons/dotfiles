{ wrapQtAppsHook, pkgs }:
with pkgs;
clangStdenv.mkDerivation rec {
  pname = "friction";
  version = "1.0.0-rc.2";
  src = fetchFromGitHub {
    owner = "friction2d";
    repo = "friction";
    rev = "4db403b5f5490da3c32593b8c44800e83547f410";
    hash = "sha256-H9A1+lB/PIdFX7+x3SsEkYGWCfAzrhIrcJXjgXxsfbA=";
    fetchSubmodules = true;
  };

    clang = clang_18;
    qscintilla = libsForQt5.qscintilla;

    nativeBuildInputs = [
      ninja
      clang
      cmake
      pkg-config
      wrapQtAppsHook
    ];

    buildInputs = [
    qt5Full
    qscintilla
    ffmpeg_4-full
    python3
    libunwind
    expat
    harfbuzzFull
    freetype
    fontconfig
    libjpeg_turbo
    libpng
    libwebp
    zlib
    icu
    mesa
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
    "-DCMAKE_CXX_COMPILER=${clang}/bin/clang++"
    "-DCMAKE_C_COMPILER=${clang}/bin/clang"
    "-DQSCINTILLA_INCLUDE_DIRS=${qscintilla}/include/qt5"
    "-DQSCINTILLA_LIBRARIES_DIRS=${qscintilla}/lib"
    "-DQSCINTILLA_LIBRARIES=qscintilla2_qt5"
  ];

  meta = {
    description = "Motion graphics application";
    homepage = "https://github.com/friction2d/friction";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
