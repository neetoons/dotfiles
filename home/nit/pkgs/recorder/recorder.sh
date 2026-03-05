#/run/current-system/sw/bin/bash
#
# Script de grabación de pantalla y audio usando wf-recorder, fuzzel, y slurp.
# Requisito: Instalar wf-recorder (nix-shell -p wf-recorder)

# --- CONFIGURACIÓN DE RUTAS Y METADATOS ---

# Directorio persistente para almacenar el archivo de metadatos (PID y rutas).
METADATA_DIR="$HOME/.cache/ffrecord"
METADATA_FILE="$METADATA_DIR/ffmpeg-record.pid"

# Ruta para el directorio de videos del usuario. Busca "Videos" o "videos".
VIDEOS_DIR=$(find "$HOME" -maxdepth 1 -type d -iname "*videos*" -print -quit 2>/dev/null)
if [ -z "$VIDEOS_DIR" ]; then
    # Si no se encuentra, usar el HOME
    VIDEOS_DIR="$HOME"
fi

# --- FUNCIONES DE UTILIDAD ---

# Función para limpiar el directorio de metadatos
cleanup_metadata() {
    rm -rf "$METADATA_DIR"
}

# --- FUNCIONES PRINCIPALES ---

# Función para iniciar la grabación
start_recording() {
    # 1. Verificación de caché activa (AÑADIDO: Comprobación de PID activo)
    if [ -d "$METADATA_DIR" ]; then
        if [ -f "$METADATA_FILE" ]; then
            # Intentar leer el PID registrado
            RECORDER_PID=$(head -n 1 "$METADATA_FILE")

            # Comprobar si el PID sigue corriendo
            if kill -0 "$RECORDER_PID" 2>/dev/null; then
                # PID ACTIVO: Lanzar error de bloqueo
                echo "Error: Ya existe una grabación activa (PID $RECORDER_PID). Detenga la grabación actual primero." >&2
                notify-send --app-name="Recording 🔴" "Error" "Ya hay una grabación en curso."
                exit 1
            else
                # PID INACTIVO (Stale): Limpiar caché y continuar
                echo "Advertencia: Se encontró una grabación inactiva/fallida. Limpiando metadatos y reiniciando..."
                cleanup_metadata
            fi
        else
            # Directorio existe pero archivo no: Asumir fallo parcial, limpiar y continuar
            echo "Advertencia: Se encontró un directorio de metadatos incompleto. Limpiando..."
            cleanup_metadata
        fi
    fi

    # 0. Verificar dependencias (Movido aquí para que la limpieza de caché sea lo primero)
    if ! command -v wf-recorder &> /dev/null; then
        notify-send --app-name="Recording 🔴" "Error" "wf-recorder no está instalado."
        echo "Error: wf-recorder no encontrado. Instálelo con 'nix-shell -p wf-recorder'." >&2
        exit 1
    fi

    # 2. Elegir modo de grabación (fuzzel)
    MODE=$(echo -e "fullscreen\nSelect Area" | fuzzel --dmenu -p "Modo de Grabación:")

    if [ -z "$MODE" ]; then
        echo "Grabación cancelada."
        exit 1
    fi

    WF_ARGS=""
    if [ "$MODE" = "Select Area" ]; then
        # Usar slurp para obtener el área seleccionada
        GEOMETRY=$(slurp)
        if [ -z "$GEOMETRY" ]; then
            echo "Selección de área cancelada."
            exit 1
        fi
        # wf-recorder acepta la geometría de slurp directamente con -g
        WF_ARGS="-g $GEOMETRY"
    fi

    # 3. Crear directorio de metadatos y nombre de archivo.
    mkdir -p "$METADATA_DIR"
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    FILENAME="$TIMESTAMP.mp4"
    OUTPUT_PATH="$METADATA_DIR/$FILENAME"
    LOG_FILE="$METADATA_DIR/recording.log"

    # 4. Comando wf-recorder (ejecutado en background)
    # -a: Graba audio (automáticamente detecta el default de PulseAudio/Pipewire)
    # -c libx264: Codec de video
    # --pixel-format yuv420p: Para compatibilidad con reproductores
    # -f: Archivo de salida
    wf-recorder $WF_ARGS \
        -a \
        -c libx264 -p preset=veryfast -p crf=23 \
        --pixel-format yuv420p \
        -f "$OUTPUT_PATH" > "$LOG_FILE" 2>&1 &

    # Capturar el PID del proceso de fondo
    RECORDER_PID=$!

    # 5. Comprobación de salud
    sleep 0.5
    if ! kill -0 "$RECORDER_PID" 2>/dev/null; then
        echo "Error: wf-recorder (PID $RECORDER_PID) falló al iniciar." >&2
        echo "Log: $(cat $LOG_FILE)"
        notify-send --app-name="Recording 🔴" "Error" "Falló al iniciar la grabación. Revise el log."
        cleanup_metadata # Limpia si falló el inicio
        exit 1
    fi

    # 6. Guardar metadatos
    # Solo necesitamos el PID y la ruta temporal.
    echo "$RECORDER_PID" > "$METADATA_FILE"
    echo "$OUTPUT_PATH" >> "$METADATA_FILE"
    echo "$VIDEOS_DIR/$FILENAME" >> "$METADATA_FILE"

    notify-send --app-name="Recording 🔴" "Grabación Iniciada" "PID: $RECORDER_PID\nArchivo: $FILENAME"
    echo "Grabación iniciada (PID: $RECORDER_PID). Detenga con 'Stop'."
}

# Función para detener la grabación
stop_recording() {
    # 1. Verificar y cargar metadatos
    if [ ! -f "$METADATA_FILE" ]; then
        echo "Error: No se encontró el archivo de metadatos." >&2
        exit 1
    fi

    mapfile -t METADATA < "$METADATA_FILE"
    RECORDER_PID="${METADATA[0]}"
    OUTPUT_PATH="${METADATA[1]}"
    FINAL_DEST="${METADATA[2]}"

    echo "Deteniendo grabación con PID: $RECORDER_PID..."

    # 2. Detener el proceso (SIGINT es mejor para wf-recorder para cerrar bien el archivo)
    if kill -0 "$RECORDER_PID" 2>/dev/null; then
        kill -2 "$RECORDER_PID" # SIGINT

        # Esperar a que termine de escribir
        tail --pid=$RECORDER_PID -f /dev/null
        echo "Proceso detenido correctamente."
    else
        echo "Advertencia: El proceso ya había terminado."
    fi

    # 3. Mover el archivo final
    if [ -f "$OUTPUT_PATH" ] && [ -d "$VIDEOS_DIR" ]; then
        mv "$OUTPUT_PATH" "$FINAL_DEST"
        echo "Grabación finalizada (Guardado en: $FINAL_DEST)"
        notify-send --app-name="Recording 🔴" " " "Grabación guardada en $FINAL_DEST"
    else
        echo "Error: Archivo no creado o destino inválido." >&2
    fi

    # 4. Limpiar metadatos
    cleanup_metadata # Usar la nueva función de limpieza
}

# --- LÓGICA PRINCIPAL ---

# Usar fuzzel para elegir entre Start y Stop
ACTION=$(echo -e "Start\nStop" | fuzzel --dmenu -p "Record:")

case "$ACTION" in
    Start)
        start_recording
        ;;
    Stop)
        stop_recording
        ;;
    *)
        exit 0
        ;;
esac
