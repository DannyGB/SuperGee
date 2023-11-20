using Gtk;

namespace SuperGee { 

    public class SearchHandler : Object, ISearchHandler 
    {
        private string FILENAME_SWITCH = " -p ";
        private string ALBUMS_SWITCH = " -a ";
        private string DISPLAY_FORMAT_SWITCH = " -f ";
        private IBeetService BeetService { get; set; }
        private Gtk.ListStore TreeList { get; set; }
        private int LsMinLength { get; set; }
        private bool ShowFileName { get; set; }
        private bool AlbumsOnly { get; set; }
        private bool UseDisplayFormat { get; set; }
        private Gtk.SearchEntry SearchEntry { get; set; }
        private Gtk.Entry DisplayFormatEntry { get; set; }

        public SearchHandler(IBeetService service, Gtk.ListStore treeList, int lsMinLength, Gtk.SearchEntry searchEntry, Gtk.Entry displayFormatEntry) {
            BeetService = service;
            TreeList = treeList;
            LsMinLength = lsMinLength;
            SearchEntry = searchEntry;
            DisplayFormatEntry = displayFormatEntry;
        }

        [CCode (instance_pos = -1)]
        public void on_search_changed(Gtk.Entry entry) {

            string text = entry.text;

            if(text.length == 0 || text.length >= LsMinLength) {
                TreeList.clear();    
            }

            if(text.length < LsMinLength) {
                return;
            }

            if(ShowFileName) {                
                text = text + FILENAME_SWITCH;
            }

            if(AlbumsOnly) {
                text = text + ALBUMS_SWITCH;
            }

            if(UseDisplayFormat) {
                warning("Display format: %s", DisplayFormatEntry.text);
                text = text + DISPLAY_FORMAT_SWITCH + "'" + DisplayFormatEntry.text + "'";
                warning("All text: %s", text);
            }

            var list = BeetService.ls(text);

            Gtk.TreeIter iter;

            foreach(string entryText in list) {
                TreeList.append(out iter);
                TreeList.set(iter, 0, entryText);
            }
        }

        [CCode (instance_pos = -1)]
        public void on_show_filename_changed(ToggleButton toggle) {
            ShowFileName = toggle.active;          
            SearchEntry.changed();
        }

        [CCode (instance_pos = -1)]
        public void on_only_albums_changed(ToggleButton toggle) {
            AlbumsOnly = toggle.active;          
            SearchEntry.changed();
        }

        [CCode (instance_pos = -1)]
        public void on_use_display_format_changed(ToggleButton toggle) {
            UseDisplayFormat = toggle.active;          
            SearchEntry.changed();
        }
    }
}