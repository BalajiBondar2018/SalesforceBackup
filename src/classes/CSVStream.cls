public class CSVStream {
    public static Boolean isTest;
    public static String strEmailAddr;
    public static String strOut;
    public static Boolean restRequested;
    public String strEmail{get;set;}
    public String strRptname{get;set;}
    
    void CSVStream () {
        strOut = '';        
        }
 
   public String getCSVStream() {
        //restRequested = System.isFuture() || System.isScheduled();
        executeRpt();
        System.debug('@@@@@@@@@@@executeRpt called.');
        return strOut;
        }
  
    public void executeRpt() {
        String requestURL;
        requestURL = '/' + strRptname + '?csv=1';
        //requestURL = '/' + strRptname + '?export=1&enc=UTF-8&xf=csv';
        
        strOut = new PageReference(requestURL).getContent().toString();
        System.debug('@@@@@@@@@@@CALLING executeRpt:  output= ' + strOut );
    }
 
}