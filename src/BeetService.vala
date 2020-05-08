using Gee;

namespace SuperGee {
    
    public class BeetService : Object, IBeetService{

        private string BEET = "beet";
        private string LS = "ls";
        private const string PATHSWITCH = "-p";
        private string SearchEntry { get; set; }

        public ArrayList<string> ls(string term) 
            requires (term != "")
        {
            SearchEntry = term;
            string standardOut;
            string standardError;
            int commandStatus;
        
            Process.spawn_command_line_sync(CreateCommand(SearchEntry),
                                            out standardOut,
                                            out standardError,
                                            out commandStatus);

            return Parse(standardOut);
        } 

        private ArrayList<string> Parse(string coll) 
            requires (coll != "")
        {
            string[] split = coll.split("\n");

            return new ArrayList<string>.wrap(split);
        }

        private string CreateCommand(string term) {
            return BEET + " " + LS + " " + term;
        }

        public bool searchTextIncludesPathSwitch() {
            return SearchEntry.contains(PATHSWITCH);
        }

    }
    
}