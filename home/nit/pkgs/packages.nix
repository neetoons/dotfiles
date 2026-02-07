{ pkgs, inputs, pkgs-unstable,  ...}:
let
    system = pkgs.stdenv.hostPlatform.system;
    unstable = pkgs-unstable;
in
{
    #TODO:
    #-  alacritty
    #-  ewww

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        inputs.zen-browser.packages."${system}".default
        inputs.oxicord.packages.${system}.default

# --- PANTHEON SUITE
        pantheon.elementary-calculator

# --- GNOME SUITE
        gnome-calendar
        gnome-logs
        gnome-clocks
        gnome-font-viewer
        gnome-decoder
        gnome-sound-recorder #reco
        gnome-keyring
        gnome-obfuscate
        gnome-solanum # Aplicación de temporizador Pomodoro para gestionar el tiempo


# --- Desarrollo y Programación (IDEs, Editores de Código, Herramientas de Compilación) ---
        #unstable.zed-editor # Editor de texto y código de alto rendimiento, enfocado en el desarrollo
        ungoogled-chromium
        geany
        yarn
        pnpm
        nodejs_latest # Entorno de ejecución de JavaScript del lado del servidor (versión 24)
        #zeal
        typescript # Lenguaje de programación, superset de JavaScript que añade tipado estático
        python310 # Lenguaje de programación Python (versión 3.10)
        ##android-studio # Entorno de desarrollo integrado (IDE) para crear aplicaciones Android
        pkg-config # Utilidad para ayudar a compilar programas especificando banderas de compilación para bibliotecas
        cmake # Herramienta de gestión de compilación y construcción de software
        #qt5.full # El kit de herramientas Qt (versión 5) para el desarrollo de aplicaciones gráficas
        #qtcreator # Entorno de desarrollo integrado (IDE) para la creación de aplicaciones Qt
        gnumake # Utilidad para controlar la generación de ejecutables y otros archivos a partir de archivos fuente
        gdb # Depurador de GNU (debugger) para programas
        alacritty
        (callPackage ./pawncc/default.nix {})
        vscodium # Versión de VS Code sin telemetría ni código propietario de Microsoft
        #(vscode-with-extensions.override {
        #    vscode = vscodium;
        #    vscodeExtensions = with vscode-extensions; [
        #        #vscodevim.vim
        #        #bbenoist.nix
        #        #ms-python.python
        #        #ms-azuretools.vscode-docker
        #        #ms-vscode-remote.remote-ssh
        #    ]
        #    #++ vscode-utils.extensionsFromVscodeMarketplace [
        #    #    {
        #    #    name = "remote-ssh-edit";
        #    #    publisher = "ms-vscode-remote";
        #    #    version = "0.47.2";
        #    #    sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        #    #    }
        #    #];
        #})

# --- Bases de Datos y APIs ---
        sqlitebrowser # Herramienta gráfica para diseñar, editar y visualizar bases de datos SQLite
        #postman # Herramienta para el desarrollo, prueba y documentación de APIs
        #beekeeper-studio # Cliente SQL de código abierto y multiplataforma
        bruno # Herramienta de código abierto para probar APIs, alternativa a Postman
        dbeaver-bin # Herramienta universal de bases de datos para desarrolladores y administradores

# --- Diseño Gráfico y Multimedia (Imagen y Audio) ---
        kdePackages.elisa # The Elisa music player is developed by the KDE community and strives to be simple and pleasant to use.
        mixxx
        gimp # Editor de imágenes y retoque fotográfico avanzado (alternativa a Photoshop)
        audacity # Editor y grabador de audio digital
        #lmms # Estación de trabajo de audio digital (DAW) de código abierto
        pinta # Programa simple para dibujar/editar imágenes, similar a Paint.NET
        pixelorama # Editor de gráficos pixel-art 2D
        gcolor3 # Selector y capturador de color simple para el escritorio
        converseen # Procesador por lotes de imágenes, permite convertir y redimensionar
        #blender # Suite de creación 3D (modelado, animación, renderizado, etc.)
        #figma-linux # Cliente no oficial para Figma, herramienta de diseño de interfaces
        penpot-desktop # Aplicación de diseño y prototipado de interfaz de usuario, de código abierto

# --- Video y Streaming (Captura, Edición, Reproducción) ---
        #(libsForQt5.callPackage ./friction/default.nix {})
        ##soundux
        ##AppFlowy
        kdePackages.kdenlive # Editor de video no lineal avanzado
        #obs-studio # Software libre y de código abierto para grabación de video y transmisión en vivo
        vlc # Reproductor multimedia altamente compatible
        ffmpeg # Marco multimedia para procesar, convertir y transmitir audio/video
        unstable.yt-dlp # Descargador de videos de YouTube y otros sitios (sucesor de youtube-dl)
        eog # Visor de imágenes Eye of GNOME
        #vidcutter # Editor de video simple para unir o cortar clips
        losslesscut-bin # Editor de video simple para cortes rápidos sin pérdida de calidad
        aegisub # Editor avanzado de subtítulos, popular para karaoke
# --- Comunicación y Productividad (Mensajería, Correo, Notas) ---
        #cohesion
        #zotero
        #unstable.ferdium # Cliente de mensajería que consolida múltiples servicios (WhatsApp, Telegram, etc.)
        (unstable.callPackage ./ferdium/default.nix {})
        unstable.discord
        #unstable.vesktop # Cliente de escritorio alternativo para Discord, con más funciones y personalización
        telegram-desktop # Cliente oficial de escritorio para la aplicación de mensajería Telegram
        #thunderbird # Cliente de correo electrónico, calendario y noticias
        #fractal # Cliente de escritorio para la red de comunicación Matrix
        obsidian # Editor de notas basado en Markdown que utiliza un enfoque de grafo/red
        ##cinny-desktop # Cliente de escritorio para la red de comunicación descentralizada Matrix
        ##zapzap # Cliente de escritorio no oficial para WhatsApp
        #smile # emoji picker
        sticky-notes # Aplicación de notas adhesivas para el escritorio

# --- Ofimática y Lectura (Documentos, Ebooks, RSS) ---
        #unstable.onlyoffice-desktopeditors # Suite ofimática con funciones de colaboración
        unstable.fluent-reader # Lector de RSS/Atom/Feedly con interfaz moderna
        #unstable.newsflash # Lector de noticias RSS/Atom moderno para el escritorio GNOME
        #libreoffice-fresh # Suite ofimática completa y de código abierto (versión más reciente)
        #calibre # Software de gestión de bibliotecas de libros electrónicos

# --- Juegos y Emulación ---
        ##superTuxKart # Juego de carreras de karts de código abierto, similar a Mario Kart
        ##bottles # Herramienta para gestionar 'Wine Prefixes', facilitando la ejecución de software de Windows
        unstable.wine # Capa de compatibilidad para ejecutar aplicaciones de Windows en Linux
        ##superTux # Juego de plataformas 2D, similar a Super Mario Bros.
        ##itch # Cliente de escritorio para la tienda de juegos indie itch.io
        #ludusavi # Herramienta para hacer copias de seguridad y restaurar partidas de videojuegos
        ##antimicroX # Herramienta para mapear botones del gamepad a acciones del teclado/ratón
        steam # Cliente de escritorio para la plataforma de distribución de juegos de Valve
        ##godot3 # Motor de videojuegos 2D y 3D (versión 3.x)
        unstable.lutris
        unstable.heroic
        warehouse
        #quickemu # Herramienta para crear y ejecutar máquinas virtuales QEMU de forma rápida
        qemu # Emulador y virtualizador de máquinas
        net-tools
        #aegyptus # Subtitulador

# --- Utilidades de Sistema y Red (Archivos, Terminal, Monitoreo) ---
        ranger # Administrador de archivos de consola con atajos de teclado al estilo Vi
        p7zip # Utilidad para comprimir y descomprimir archivos en formato 7z
        zip # Utilidad de línea de comandos para crear archivos comprimidos .zip
        unzip # Utilidad de línea de comandos para extraer archivos .zip
        peazip
        #rclone-ui
        rclone # Herramienta de sincronización de archivos con servicios de almacenamiento en la nube
        ncdu # Analizador de uso de disco en modo consola/terminal
        btop # Monitor de recursos del sistema con una interfaz visual y atractiva
        htop # Monitor de procesos interactivo en modo consola (similar a 'top' mejorado)
        unrar-wrapper # Utilidad para extraer archivos comprimidos en formato RAR
        tree # Utilidad de línea de comandos para listar contenido de directorios en formato de árbol
        zsh # Shell de comandos extendida con muchas funciones y personalización
        jq # Procesador ligero y flexible de JSON en línea de comandos
        wget # Utilidad de línea de comandos para descargar archivos desde la web
        fzf # Buscador difuso (fuzzy finder) de línea de comandos
        fastfetch # Herramienta de línea de comandos para mostrar información del sistema y el logo de la distribución
        file-roller # Archivador de archivos (comprime/descomprime) para el escritorio GNOME
        qdirstat # Herramienta gráfica para visualizar el uso del disco
        #guiscrcpy # Interfaz gráfica para scrcpy (controlar y ver Android en el PC)

# --- Redes y Conectividad (Navegadores, Compartición, P2P) ---
        #unstable.youtube-music # Cliente no oficial de escritorio para YouTube Music
        qbittorrent # Cliente BitTorrent moderno y liviano
        #slskd # Cliente de demonio para la red de intercambio de archivos Soulseek (SLSK)
        nicotine-plus # Cliente para la red de intercambio de archivos Soulseek (SLSK)
        #audio-sharing # Herramienta para compartir audio de una aplicación a otra
        #whatip # Utilidad para mostrar la dirección IP pública y otra información de red
        #netpeek # Herramienta gráfica simple para analizar el tráfico de red
        #alpaca # Herramienta de análisis de datos de red, similar a Wireshark
        #shortwave # Reproductor de radio por Internet
        #motrix # Gestor de descargas completo compatible con HTTP, FTP, BitTorrent, etc.

# --- Utilidades Varias y Cuidado Personal ---
        anki-bin # Programa de tarjetas de memoria (flashcards) para el aprendizaje
        sherlock # Herramienta para buscar perfiles de usuario en múltiples redes sociales
        bleachbit # Herramienta de limpieza del sistema para liberar espacio y preservar la privacidad
        #homebank # Software de gestión de finanzas personales
        contrast # Herramienta para verificar el contraste de colores para la accesibilidad web
        wordbook # Aplicación para aprender y gestionar vocabulario
        dialect # Aplicación simple de traducción de idiomas
        speedtest # Utilidad de línea de comandos para probar la velocidad de internet
        copyq # Administrador avanzado de portapapeles con historial
        #organicmaps # Aplicación de mapas sin conexión basada en OpenStreetMap
        meld # Herramienta visual para comparar y fusionar archivos y directorios
        rofimoji
        pika-backup # Herramienta de copia de seguridad simple basada en BorgBackup
        (callPackage ./discord-desktop-mobile/default.nix {})
        #(callPackage ./notion/default.nix {})
        (callPackage ./sorter/default.nix {})
        (callPackage ./sampctl/default.nix {})
        (callPackage ./recorder/default.nix {})
        (unstable.callPackage ./elyprism/default.nix {})
        (callPackage ./tibia/default.nix {})
        #unstable.steam-run
        #unstable.gns3-gui
  ];
}
