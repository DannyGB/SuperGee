#!/bin/bash

cd build
glib-compile-resources --sourcedir ../resources --generate-source --target SuperG@exe/resources.c ../resources/superg.gresource.xml
ninja

#valac -g --debug ./src/Main.vala ./src/SearchHandler.vala ./src/BeetService.vala ./src/IBeetService.vala ./src/ISearchHandler.vala ./src/EntryHandler.vala ./src/IEntryHandler.vala ./src/Entry.vala --pkg gee-0.8 --pkg gtk+-3.0 --pkg gio-2.0 --pkg gmodule-2.0 -o build/SuperG