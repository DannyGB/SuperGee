using Gtk;

namespace SuperGee { 

    public class SearchHandler : Object, ISearchHandler 
    {
        private IBeetService BeetService { get; set; }
        private Gtk.ListStore TreeList { get; set; }
        private int LsMinLength { get; set; }

        public SearchHandler(IBeetService service, Gtk.ListStore treeList, int lsMinLength) {
            BeetService = service;
            TreeList = treeList;
            LsMinLength = lsMinLength;
        }

        [CCode (instance_pos = -1)]
        public void on_search_changed(Gtk.Entry entry) {

            if(entry.text.length == 0 || entry.text.length >= LsMinLength) {
                TreeList.clear();    
            }

            if(entry.text.length < LsMinLength) {
                return;
            }

            var list = BeetService.ls(entry.text);

            Gtk.TreeIter iter;

            foreach(string entryText in list) {
                TreeList.append(out iter);
                TreeList.set(iter, 0, entryText);
            }
        }
    }
}