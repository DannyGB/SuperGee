// https://wiki.gnome.org/Projects/Vala/GTKSample
// https://wiki.gnome.org/Projects/Vala/ValaForCSharpProgrammers

using Gtk;
using SuperGee;

int main (string[] args) {

    Gtk.init (ref args);

    var builder = CreateBuilder();
    var window = builder.get_object ("window") as Gtk.Window;
    var treeList = builder.get_object("liststore") as Gtk.ListStore;
    var beetService = CreateBeetService();
    var searchHandler = CreateSearchHandler(beetService, treeList);
    var entryHandler = new EntryHandler(beetService);

    ConnectSignals(builder, searchHandler, entryHandler);

    window.show_all ();

    Gtk.main();

    return 0;
}

IBeetService CreateBeetService() {
    return new BeetService();
}

ISearchHandler CreateSearchHandler(IBeetService beetService, Gtk.ListStore treeList) {
    return new SearchHandler(beetService, treeList);
}

Builder CreateBuilder() {
    var builder = new Builder.from_resource("/window.ui");

    return builder;
}

void ConnectSignals(Builder builder, ISearchHandler searchHandler, IEntryHandler entryHandler) {
    builder.connect_signals(searchHandler);
    builder.connect_signals(entryHandler);
}