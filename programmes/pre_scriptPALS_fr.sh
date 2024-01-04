#!/bin/bash
archivo_entrada="$1"

# Nombre del archivo de salida

cat "$archivo_entrada" | tr -cs "[:alpha:]|Éé|Àà|Çç|Èè|Ùù|âêîôûÂÊÎÔÛ|\'|.|´|" "\n" | sed "s/\./\n/g" | sed "s/\b\'\b//g"


