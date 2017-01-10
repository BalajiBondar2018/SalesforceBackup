public class DataModel{
    public list<model> data{get;set;}
    
    public class Model{
        public string sheetname {get;set;}
        public list<string> headers{get;set;}
        public list<map<string,string>> data{get;set;}        
    }
}