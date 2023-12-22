#!/bin/bash

archivo_entrada="$1"

# Nombre del archivo de salida


sed 's/[^A-Za-záéíóúüÁÉÍÓÚÜñÑ ]/ /g' $archivo_entrada | tr '.' '\n' | sed '/^$/d'| sed 's/^[ \t]*//' | sed 's/\b\(page\|text\)\b//g'




# Mostrar el resultado




