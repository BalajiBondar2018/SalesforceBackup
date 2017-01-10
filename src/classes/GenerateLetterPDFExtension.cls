public class GenerateLetterPDFExtension {
public string letterbodyStr {get;set;}
    public GenerateLetterPDFExtension(ApexPages.StandardController controller) {
        letterbodyStr = '<table width="100%" border="1"><tr><td>Test123</td><td>Test1</td><td>Test1</td></tr><td>Test2</td><td>Test1</td><td>Test1</td></table>'; 
        //letterbodyStr = '<b>Hello World</b>';
    }
}