project('SuperG', 'vala', 'c')

dependencies = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gee-0.8'),
    dependency('gtk+-3.0'),
    dependency('gio-2.0'),
    dependency('gmodule-2.0')
]

sources = files(
    'Main.vala',
    'SearchHandler.vala',
    'BeetService.vala',
    'IBeetService.vala',
    'ISearchHandler.vala',
    'EntryHandler.vala',
    'IEntryHandler.vala',
    'Entry.vala',
    '../build/SuperG@exe/resources.c')

executable('SuperG', sources, dependencies: dependencies)