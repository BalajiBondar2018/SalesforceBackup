public class XMLParserController {


private String parse(String toParse) {
  DOM.Document doc = new DOM.Document();      
  try {
    doc.load(toParse);    
    DOM.XMLNode root = doc.getRootElement();
    return walkThrough(root);
    
  } catch (System.XMLException e) {  // invalid XML
    return e.getMessage();
  }
}






private String walkThrough(DOM.XMLNode node) {
  String result = '\n';
  if (node.getNodeType() == DOM.XMLNodeType.COMMENT) {
    return 'Comment (' +  node.getText() + ')';
  }
  if (node.getNodeType() == DOM.XMLNodeType.TEXT) {
    return 'Text (' + node.getText() + ')';
  }
  if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
    result += 'Element: ' + node.getName();
    if (node.getText().trim() != '') {
      result += ', text=' + node.getText().trim();
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
  return '';  //should never reach here 
}
















/*
String xmlString ='<?xml version="1.0" encoding="iso-8859-1" ?>'+
'<Root>'+
'<Record>'+
    '<CateID>2</CateID>'+
    '<Name>Namexyz</Name>'+
    '<Phone>456879</Phone>'+
    '<Email>info@ymail.com</Email>'+
    '<Website>http://www.namexyz.com/page.html</Website>'+
'</Record>'+
'<Record>'+
    '<CateID>2</CateID>'+
    '<Name>Namexyz</Name>'+
    '<Phone>456879</Phone>'+
    '<Email>info@ymail.com</Email>'+
    '<Website>http://www.namexyz.com/page.html</Website>'+
'</Record>'+
'</Root>';

List<String> personList = getRepeatingValuesFromXMLString(xmlString , 'Record');
//System.debug('@@@@@@@@@@@@@@personList '+personList);


String  valueStr = getValueFromXMLString(xmlString, 'Email', 0);
//System.debug('@@@@@@@@@@@@@@valueStr '+valueStr);


public static string getValueFromXMLString(string xmlString, string keyField, integer location){
    string valueFound = '';
    System.debug('@@@@@@@@@@@ '+ xmlString.contains('<' + keyField + '>'));
    System.debug('@@@@@@@@@@@ '+xmlString.contains('</' + keyField + '>'));
    
    if(xmlString.contains('<' + keyField + '>') && xmlString.contains('</' + keyField + '>')){
    try{
          valueFound = xmlString.substring(xmlString.indexOf('<' + keyField + '>', location) + keyField.length()+2,xmlString.indexOf('</' + keyField + '>', location));   
        }catch (exception e){
            system.debug('Error in getValueFromXMLString.  Details: ' + e.getMessage() + ' keyfield: ' + keyfield);
        }           
    }
    return valueFound;
}


    public static list<string> getRepeatingValuesFromXMLString(string xmlString, string keyField){
        //We want this to be an ordered collection so we need a list and not a set
       integer foundStart = 0;
       integer foundEnd = 0;
       integer currentSpot = 0;
       string itemAdd = '';
       list<string> repeatingValues = new list<string>();
             
       do {        
            foundStart = xmlString.indexOf('<' + keyField + '>', currentSpot);
        if(foundStart >= 0){
             foundEnd = xmlString.indexOf('</' + keyField + '>', foundStart + keyField.length());
             itemAdd = xmlString.substring(foundStart + keyField.length() + 2, foundEnd);
             repeatingValues.add(itemAdd);
        }  
        currentSpot = foundEnd + keyField.length();                    
       } while (foundStart != -1);         
             
       return repeatingValues;
    }
    
 */   


/*
<?xml version='1.0' encoding='iso-8859-1' ?>
<Root>
<Record>
    <CateID>1</CateID>
    <Name>NameABC</Name>
    <Phone>12356</Phone>
    <Email>info@gmail.com</Email>
    <Website>http://www.nameabc.com/page.html</Website>
</Record>
<Record>
    <CateID>2</CateID>
    <Name>Namexyz</Name>
    <Phone>456879</Phone>
    <Email>info@ymail.com</Email>
    <Website>http://www.namexyz.com/page.html</Website>
</Record>
</Root>

// consider, This above XML getting from Listing()

public void Listing()
{     
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://demos.sfxmlpase.com/xml');
        req.setMethod('GET');
        HttpResponse res = http.send(req);        �
        String xmlContent = res.getBody();        �
        XmlStreamReader reader = res.getXmlStreamReader();   �
        XMLData = XMLParser(res.getBody());
     }
public List<String> XMLParser(String strXml)
    {            

        List<String> xmlstring =new List<String>();
        Dom.Document doc = new Dom.Document();
        doc.load(strXml);
        Dom.XMLNode Envelope = doc.getRootElement();
        for(integer i=0; i < Envelope.getChildElements().size(); i++)
        {
            Dom.XMLNode Body = Envelope.getChildElements()[i];
            for(Dom.XMLNode child : Body.getChildElements())
            {
                String Text = child.getText();
                if(child.getText().contains('%23'))
                Text = child.getText().replace('%23', '&');

                xmlstring.add(Text);
            }
        }

    return xmlstring;
    }        //XMLData in Listing() will have all the text inside the
- See more at: http://nanostuffs.com/Blog/?p=1387#sthash.7VKTilz0.dpuf
*/





}