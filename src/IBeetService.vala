using Gee;

namespace SuperGee { 
    public interface IBeetService : Object { 
        public abstract string SearchEntry { get; set; }
        public abstract ArrayList<string> ls(string term); 
        public abstract bool searchTextIncludesPathSwitch();
    }
}