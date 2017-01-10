public class JSONParserTestController {
public String fieldValue {get;set;}
    public PageReference PageLoad() {
      String JSONContent = '{"firstName":"John"}';
JSONParser parser = 
   JSON.createParser(JSONContent);
// Advance to the start object marker. 
    
parser.nextToken();
// Advance to the next value. 
    
parser.nextValue();
// Get the field name for the current value. 
    
String fieldName = parser.getCurrentName();
// Get the textual representation  
    
// of the value. 
    
fieldValue = parser.getText();

        return null;
    }

}