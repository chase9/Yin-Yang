#!/bin/bash

# ui file from qt designer
pyside6-uic ./designer/main_window.ui > ./src/yin_yang/ui/main_window.py
# extract strings to translate
pyside6-lupdate ./designer/main_window.ui ./src/yin_yang/ui/main_window_connector.py \
  -ts ./resources/translations/yin_yang.*.ts -no-obsolete
# generate binary translation files
pyside6-lrelease ./resources/translations/yin_yang.*.ts
# resource file
pyside6-rcc ./resources/resources.qrc -o ./src/yin_yang/resources_rc.py
