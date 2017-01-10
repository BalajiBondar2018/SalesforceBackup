global class SalesforceXMLReaderWebService {
    webService static String createOpportunity(String SOAInputXMLStr) {
    //variable decleration
    String responseStr = '';//string to capture the response message to SOA
    
    //Retrieve the root element for this document.
    List<String> orgInfo=new List<String>();

    Dom.Document doc = new Dom.Document();
    doc.load(SOAInputXMLStr);
    DOM.XMLNode root = doc.getRootElement();
    String str = walkThrough(root);

    return responseStr ;
    }
    
    
    public static String walkThrough(DOM.XMLNode node) {
        String result = '\n';
            if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
                result += 'Element: ' + node.getName();
                
                if (node.getText().trim() != '') {
                    result += ', text=' + node.getText().trim();
                    //System.debug('@@@@@@@@@@node.getText().trim()'+node.getText().trim());
                }
                
                if (node.getAttributeCount() > 0) { 
                    for (Integer i = 0; i< node.getAttributeCount(); i++ ) {
                        result += ', attribute #' + i + ':' + node.getAttributeKeyAt(i) + '=' + node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
                        //System.debug('@@@@@@@@@@@node.getAttributeKeyAt(i) '+node.getAttributeKeyAt(i));
                        System.debug('@@@@@@@@@@@node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i)) '+node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i)));
                        System.debug('@@@@@@@@@@node.getText().trim()'+node.getText().trim());
                        //if(node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i)) == 'MerchantID') 
                        //    MID = node.getText().trim();
                         
                    }  
                }
                
                for (Dom.XMLNode child: node.getChildElements()) {
                    result += walkThrough(child);
                }
                return result;
            }
        return '';  //should never reach here 
        }
}