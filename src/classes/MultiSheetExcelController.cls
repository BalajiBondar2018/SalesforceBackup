public class MultiSheetExcelController{
    public string xmlheader {get;set;}
    public DataModel dModel {get;set;}
    public string endfile{get;set;}
    public MultiSheetExcelController(){
        //VF page gives some issues directly using the below code there, so wrap up in variable
        xmlheader ='<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?>';
        endfile = '</Workbook>';
    }
    public Document doc;
    public Document getImagedocument(){
    doc = [Select d.Id, d.ContentType, d.Body From Document d where d.Id='01590000000UegJ'];
    return doc;
    }
    
     public String image {
        get {
        //return doc.Body;
        doc = [Select d.Id, d.ContentType, d.Body From Document d where d.Id='01590000000UegJ'];
        return EncodingUtil.Base64Encode(doc.Body);
        }
    }
    

}