public  class Xmlparsercls {
    public String xmlstring{get;set;}
    public String outxmlstring{get;set;}
    public String filename{get;set;}
    public blob body{get;set;}
    public Xmlparsercls(){
    }

//Parsing xml what you entered in the left text area
    public pagereference Parsexml(){
       outxmlstring ='';
       DOM.Document xmlDOC = new DOM.Document(); 
       xmlDOC.load(xmlstring); 
       DOM.XMLNode rootElement = xmlDOC.getRootElement();
       String result= walkThrough(rootElement);
       return null;
    }
  
  //This is for parsing xml file what you selected
  public pagereference Parsexmlfile(){
       outxmlstring ='';
       DOM.Document xmlDOC = new DOM.Document(); 
       xmlstring=body.tostring();
       system.debug('****xmlstring'+xmlstring);
       xmlDOC.load(xmlstring); 
       DOM.XMLNode rootElement = xmlDOC.getRootElement();
       String result= walkThrough(rootElement);
       return null;
    }
    
   Public String walkThrough(DOM.XMLNode node) {
        String result = '\n';
        if (node.getNodeType() == DOM.XMLNodeType.COMMENT) {
            return 'Comment (' +  node.getText() + ')';
        }
        if (node.getNodeType() == DOM.XMLNodeType.TEXT) {
            return 'Text (' + node.getText() + ')';
        }
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
            
            if (node.getText().trim() != '') {
                outxmlstring += node.getName()+'=' +node.getText().trim()+'\n';
                String nName = node.getName();
            /*    if(nName == 'XXX')
                  {
                             String xxx = node.getText().trim();
                   }    */
            }
            if (node.getAttributeCount() > 0) { 
                for (Integer i = 0; i< node.getAttributeCount(); i++ ) {
                    result += ', attribute #' + i + ':' + node.getAttributeKeyAt(i) + '=' + node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
                }  
            }
            for (Dom.XMLNode child: node.getChildElements()) {
                result += walkThrough(child);
            }
            return result;
        }
        return '';
    }
}