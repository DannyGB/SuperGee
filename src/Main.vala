// https://wiki.gnome.org/Projects/Vala/GTKSample
// https://wiki.gnome.org/Projects/Vala/ValaForCSharpProgrammers

using Gtk;
using SuperGee;

int main (string[] args) {

    Gtk.init (ref args);

    var builder = CreateBuilder();
    var window = builder.get_object ("window") as Gtk.Window;
    var treeList = builder.get_object("liststore") as Gtk.ListStore;
    var searchEntry = builder.get_object("searchEntry") as Gtk.SearchEntry;
    var displayFormatEntry = builder.get_object("displayFormatText") as Gtk.Entry;
    var beetService = CreateBeetService();
    var searchHandler = CreateSearchHandler(beetService, treeList, searchEntry, displayFormatEntry);
    var entryHandler = new EntryHandler(beetService);    

    ConnectSignals(builder, searchHandler, entryHandler);

    window.show_all ();

    Gtk.main();

    return 0;
}

IBeetService CreateBeetService() {
    return new BeetService();
}

ISearchHandler CreateSearchHandler(IBeetService beetService, Gtk.ListStore treeList, Gtk.SearchEntry searchEntry, Gtk.Entry displayFormatEntry) {
    return new SearchHandler(beetService, treeList, 3, searchEntry, displayFormatEntry);
}

Builder CreateBuilder() {
    var builder = new Builder.from_resource("/window.ui");

    return builder;
}

void ConnectSignals(Builder builder, ISearchHandler searchHandler, IEntryHandler entryHandler) {
    builder.connect_signals(searchHandler);
    builder.connect_signals(entryHandler);
}