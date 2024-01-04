#!/bin/bash
archivo_entrada="$1"

# Nombre del archivo de salida


cat "$archivo_entrada" | tr -cs '[:alpha:]|Śś|Ęę|Ćć.' '\n' | sed 's/\./\n/g'

