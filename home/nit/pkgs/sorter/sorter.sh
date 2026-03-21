#!/bin/bash

# ==============================================================================
# 0. CONSTANTE DE TIEMPO (15 minutos en segundos)
# ==============================================================================
# 15 minutos * 60 segundos/minuto = 900 segundos
# Este es el tiempo MINIMO que debe haber pasado desde la CREACIÓN/MODIFICACIÓN
# para que un archivo sea considerado "seguro" para mover.
TIEMPO_MINIMO_SEGUNDOS=900

# ==============================================================================
# 1. FUNCIÓN DE COMPROBACIÓN DE ANTIGÜEDAD
# ==============================================================================
# Comprueba si el archivo tiene al menos TIEMPO_MINIMO_SEGUNDOS de antigüedad
es_archivo_antiguo_minimo() {
  local archivo="$1"
  local tiempo_minimo="$2" # Tiempo en segundos

  # --------------------------------------------------------------------------
  # NOTA CLAVE:
  # El comando 'stat' en Linux/macOS puede dar la fecha de CREACIÓN (Birth/cTime)
  # o MODIFICACIÓN (mTime). 'find -mmin' usa mTime (modificación).
  # Para la mayoría de descargas en curso, el tiempo de MODIFICACIÓN (mTime)
  # es suficiente, ya que se actualiza constantemente mientras se escribe el archivo.
  # Usaremos 'stat' y su tiempo de MODIFICACIÓN (mtime) en segundos.
  # --------------------------------------------------------------------------

  # Obtener la marca de tiempo (epoch) de la última modificación (mTime) del archivo
  # En Linux (GNU stat): %Y
  local mtime_epoch=$(stat -c %Y "$archivo")

  # En macOS (BSD stat): -f %m
  # Si estás usando macOS, deberías cambiar la línea anterior por:
  # local mtime_epoch=$(stat -f %m "$archivo")

  # Obtener el tiempo actual (epoch)
  local tiempo_actual_epoch=$(date +%s)

  # Calcular la antigüedad del archivo en segundos
  local antiguedad=$((tiempo_actual_epoch - mtime_epoch))

  # Comparar: si la antigüedad es MAYOR o IGUAL al tiempo mínimo, retorna 0 (éxito/verdadero)
  if [ "$antiguedad" -ge "$tiempo_minimo" ]; then
    return 0 # Es lo suficientemente antiguo
  else
    # Opcional: Descomentar para ver qué archivos se están omitiendo
    # echo "Saltando archivo reciente: '$archivo' (Antigüedad: ${antiguedad}s)" >&2
    return 1 # Es demasiado reciente
  fi
}


# ==============================================================================
# 2. FUNCIÓN DE MOVIMIENTO SEGURO (Mover sin sobreescribir, renombrando)
# ==============================================================================
mover_seguro() {
  # ... (El código de esta función es idéntico al original, no necesita cambios)
  local origen="$1"
  local destino_dir="$2"
  local nombre_archivo=$(basename "$origen")
  local destino="$destino_dir/$nombre_archivo"

  local nombre_base="${nombre_archivo%.*}"
  local extension="${nombre_archivo##*.}"
  local contador=1
  local nuevo_destino="$destino"

  if [ "$nombre_base" = "$nombre_archivo" ]; then
    extension=""
  else
    extension=".$extension"
  fi

  while [ -e "$nuevo_destino" ]; do
    nuevo_nombre="${nombre_base}(${contador})${extension}"
    nuevo_destino="$destino_dir/$nuevo_nombre"
    contador=$((contador + 1))
  done

  mv "$origen" "$nuevo_destino"
  # echo "Movido: '$origen' -> '$nuevo_destino'"
}

# ==============================================================================
# 3. CREACIÓN DE DIRECTORIOS
# ==============================================================================
# (El código de esta sección es idéntico al original, no necesita cambios)
mkdir -p "1. Video"
mkdir -p "2. Images/PSD"
mkdir -p "2. Images/gif"
mkdir -p "3. Archives"
mkdir -p "4. Documents"
mkdir -p "4. Documents/Word"
mkdir -p "4. Documents/Excel"
mkdir -p "4. Documents/PDF"
mkdir -p "Scripts/JavaScript"
mkdir -p "Scripts/Bash"
mkdir -p "Scripts/Batch"
mkdir -p "Scripts/Lua"
mkdir -p "Scripts/Python"
# ... (rest of mkdir -p commands)
mkdir -p "Scripts/AutoHotkey"
mkdir -p "Scripts/Pawn"
mkdir -p "7. Executables"
mkdir -p "Database"
mkdir -p "Torrents"
mkdir -p "Links"
mkdir -p "5. Audio"
mkdir -p "Miscellaneous"
mkdir -p "6. TextFiles"
mkdir -p "WebFiles"
mkdir -p "GameFiles/SAMP"
mkdir -p "GameFiles/Other"
mkdir -p "3DModels"

# ==============================================================================
# 4. MOVIMIENTO DE ARCHIVOS (Con Comprobación de Antigüedad)
# ==============================================================================

# Mover archivos a sus respectivos directorios usando la función mover_seguro
for file in *; do
  # 1. Solo procesar archivos, no directorios ni el propio script
  if [ -f "$file" ] && [ "$file" != "$(basename "$0")" ]; then

    # 2. **NUEVA COMPROBACIÓN:** Verificar si el archivo es lo suficientemente antiguo (mínimo 15 minutos)
    if es_archivo_antiguo_minimo "$file" "$TIEMPO_MINIMO_SEGUNDOS"; then

      case "${file,,}" in
      # ... (Todo el bloque 'case' original, solo se pega aquí la estructura por brevedad)
      # Archivos de Word
      *.docx | *.rtf)
        mover_seguro "$file" "4. Documents/Word"
        ;;
      # Archivos de Excel
      *.xlsx | *.xlsm | *.xls)
        mover_seguro "$file" "4. Documents/Excel"
        ;;
      # PDF y Ebook
      *.pdf | *.epub)
        mover_seguro "$file" "4. Documents/PDF"
        ;;
      # Imágenes
      *.webp)
        mover_seguro "$file" "2. Images"
        ;;
      *.png | *.apng | *.bmp | *.jpg | *.jpeg)
        mover_seguro "$file" "2. Images"
        ;;
      # GIF
      *.gif)
      mover_seguro "$file" "2. Images/gif"
      ;;
      *.psd)
        mover_seguro "$file" "2. Images/PSD"
        ;;
      # Scripts
      *.js | *.ts | *.tsx)
        mover_seguro "$file" "Scripts/JavaScript"
        ;;
      *.sh)
        mover_seguro "$file" "Scripts/Bash"
        ;;
      *.bat | *.cmd)
        mover_seguro "$file" "Scripts/Batch"
        ;;
      *.lua)
        mover_seguro "$file" "Scripts/Lua"
        ;;
      *.py)
        mover_seguro "$file" "Scripts/Python"
        ;;
      *.ahk)
        mover_seguro "$file" "Scripts/AutoHotkey"
        ;;
      *.pwn | *.amx | *.inc | *.sma)
        mover_seguro "$file" "Scripts/Pawn"
        ;;
      # Archivos comprimidos
      *.7z | *.zip | *.rar | *.tar.xz | *.tgz | *.pack | *.gz)
        mover_seguro "$file" "3. Archives"
        ;;
      # Ejecutables/Binarios
      *.exe | *.dll | *.jar | *.deb | *.apk | *.msi | *.ico | *.install | *.setup)
        mover_seguro "$file" "7. Executables"
        ;;
      # Bases de Datos
      *.sql | *.kdbx)
        mover_seguro "$file" "Database"
        ;;
      # Torrents
      *.torrent)
        mover_seguro "$file" "Torrents"
        ;;
      # Enlaces
      *.url | *.lnk | *.desktop)
        mover_seguro "$file" "Links"
        ;;
      # Audio
      *.wav | *.mp3)
        mover_seguro "$file" "5. Audio"
        ;;
      # Video
      *.mp4 | *.mkv | *.mov | *.gif | *.webm | *.ogg)
        mover_seguro "$file" "1. Video"
        ;;
      # Archivos de texto
      *.txt | *.md | *.log | *.ini | *.json | *.yml | *.rules | *.ps1 | *.csv)
        mover_seguro "$file" "6. TextFiles"
        ;;
      # Archivos Web
      *.html | *.php | *.webmanifest | *.css | *.opml)
        mover_seguro "$file" "WebFiles"
        ;;
      # Archivos de Juego
      *.dff | *.txd | *.rec | *.asi)
        mover_seguro "$file" "GameFiles/SAMP"
        ;;
      # Modelos 3D
      *.blend)
        mover_seguro "$file" "3DModels"
        ;;
      # Archivos misceláneos (no clasificados)
      *)
        mover_seguro "$file" "Miscellaneous"
        ;; # ¡IMPORTANTE! He añadido esta opción para capturar el resto
      esac
    fi # Fin de la comprobación de antigüedad
  fi
done

# ==============================================================================
# 5. LIMPIEZA Y FINALIZACIÓN
# ==============================================================================
# (El código de esta sección es idéntico al original, no necesita cambios)
find . -depth -type d -empty -delete
find . -depth -type d -empty -delete
chown -R nit:users .

echo "✅ ¡Archivos organizados con éxito! Se evitaron todas las sobreescrituras y se respetó la antigüedad de 15 minutos."
