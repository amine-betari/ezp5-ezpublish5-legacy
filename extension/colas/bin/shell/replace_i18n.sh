#!/bin/bash
## A exécuter uniquement dans le répertoire extension !

find -L . -name "*.php" | xargs sed -i 's/ezi18n/ezpI18n::tr/g'