#!/bin/bash
python3 -c 'import crypt; print(crypt.crypt("TwojeHasloTutaj", crypt.mksalt(crypt.METHOD_SHA512)))'

