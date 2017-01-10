public class WMSTeleCheckServiceHandler{

    public Static Map<String, String> parseXML(String requestXMLStr){
    Map<String,String> requestMap = new   Map<String,String>();
    
    DOM.Document doc = new DOM.Document();      
    doc.load(requestXMLStr);    
    DOM.XMLNode root = doc.getRootElement();
    String nodeValueMappingStr = walkThrough(root);
    System.debug('@@@@@@@@@@@@@@@nodeValueMappingStr '+nodeValueMappingStr);
    //iterate through the Map and get the Attribute,value pair
    
    
    
    return requestMap;   
    }
    
    public static String walkThrough(DOM.XMLNode node) {
        String result = '';
        
            if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
                //result += 'Element: ' + node.getName();
                
                if (node.getText().trim() != '') {
                    result += node.getText().trim();
                    
                    //System.debug('@@@@@@@@@@node.getText().trim()'+node.getText().trim());
                }
                
                if (node.getAttributeCount() > 0) { 
                    for (Integer i = 0; i< node.getAttributeCount(); i++ ) {
                        //result += ', attribute #' + i + ':' + node.getAttributeKeyAt(i) + '=' + node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
                        //result += ', attribute #' + i + ':' + node.getAttributeKeyAt(i) + '=' + node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
                        if(node.getAttributeKeyAt(i) =='name'){
                        	result += ','+ node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
                        	//System.debug('@@@@@@@@@@@@@@'+ node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i)));
                        }
                        
                        //System.debug('@@@@@@@@@@@node.getAttributeKeyAt(i) '+node.getAttributeKeyAt(i));
                        //System.debug('@@@@@@@@@@@node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i)) '+node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i)));
                        //System.debug('@@@@@@@@@@node.getText().trim()'+node.getText().trim());
                        //if(node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i)) == 'MerchantID') 
                        //    MID = node.getText().trim();
                         
                    }  
                }
                
                //System.debug('@@@@@@@@@@@result '+result);
                for (Dom.XMLNode child: node.getChildElements()) {
                    result += walkThrough(child);
                }
                System.debug('@@@@@@@@@@@@result '+result);
                return result;
            }
        return '';  //should never reach here 
        } 
    
    
    
    public static Case createCaseObject(Map<String , String> requestMap ){
    Case caseObj = new Case();
    return caseObj;  
    }

}