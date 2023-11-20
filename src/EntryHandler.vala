using Gtk;

namespace SuperGee { 
    public class EntryHandler : Object, IEntryHandler {

        private IBeetService BeetService { get; set; }        

        public EntryHandler(IBeetService beetService) {
            BeetService = beetService;            
        }

        [CCode (instance_pos = -1)]
        public void row_activated(TreeView treeView, TreePath path, TreeViewColumn column) {
            TreeIter iter;
            
            if(!hasPath()) {
                return;
            }

            if (treeView.model.get_iter (out iter, path)) {
                Entry entry = getSelection(treeView.model, iter);
                openFile(entry.text);
            }
        }

        private static Entry getSelection (Gtk.TreeModel model, Gtk.TreeIter iter) {
            var entry = new SuperGee.Entry();
            model.get (iter, 0, out entry.text);
            
            return entry;
        }

        private void openFile(string entryText) {
            var file = File.new_for_path(entryText);
            if(file.query_exists()) {
                try {
                    AppInfo.launch_default_for_uri(file.get_uri(), null);
                } catch(Error e) {
                    warning("Unable to launch %s", entryText);
                }
            }
        }

        private bool hasPath() {
            return BeetService.searchTextIncludesPathSwitch();
        }
    }
}