public class JSONParserController {
List<MIDWrapper> MIDWrapperList = new List<MIDWrapper>();
List<GSS_MID_Store__c> GSSMIDStoreList  = new List<GSS_MID_Store__c>();

    public PageReference PageLoad() {
    String jsonStr = 
        '{"merchant":[' +
        '{"merchantId":"12121212","equipment":[' +
            '{"terminalNum":"11111","datawireId":"222222","serialNum":"","equipmentType":""},' +
            '{"terminalNum":"","datawireId":"44444","serialNum":"","equipmentType":""}]},' +
        
        '{"merchantId":"23232323","equipment":[' +
            '{"terminalNum":"55555","datawireId":"6666666","serialNum":"","equipmentType":""},' +
            '{"terminalNum":"77777","datawireId":"888888","serialNum":"","equipmentType":""},' +
            '{"terminalNum":"99999","datawireId":"000000","serialNum":"","equipmentType":""}]}' +
        ']}';

    // Parse entire JSON response.
    JSONParser parser = JSON.createParser(jsonStr);
    while (parser.nextToken() != null) {
        // Start at the array of MIDWrappers.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next MIDWrapper statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire MIDWrapper object, including its array of line items.
                    MIDWrapper MIDWrapperObj  = (MIDWrapper)parser.readValueAs(MIDWrapper.class);
                    MIDWrapperList.add(MIDWrapperObj); 
                    system.debug('Size of list items: ' + MIDWrapperObj.equipment.size());
                    //For debugging purposes, serialize again to verify what was parsed.
                    String s = JSON.serialize(MIDWrapperObj);
                    system.debug('Serialized MIDWrapper: ' + s);
                    // Skip the child start array and start object markers.
                    parser.skipChildren();
                }
            }
        }
    }
    
    for(MIDWrapper MIDWrapperObj : MIDWrapperList){
    GSS_MID_Store__c GSSMIDStoreObj = new GSS_MID_Store__c();
    GSSMIDStoreObj.MID__c = MIDWrapperObj.merchantId;
    String terminalIdStr = '';
    String datawireIdStr = '';
    
    for(Integer count = 0; count < MIDWrapperObj.equipment.size() ; count++){
        terminalIdStr += MIDWrapperObj.equipment[count].terminalNum;
        datawireIdStr += MIDWrapperObj.equipment[count].datawireId;
        if(count != MIDWrapperObj.equipment.size()-1){
            if(MIDWrapperObj.equipment[count].terminalNum !='') terminalIdStr += ';';
            if(MIDWrapperObj.equipment[count].datawireId != '') datawireIdStr += ';';
        }
    }
    
    terminalIdStr = terminalIdStr.removeEnd(';');
    datawireIdStr = datawireIdStr.removeEnd(';');
    
    GSSMIDStoreObj.Terminal_ID__c = terminalIdStr;
    GSSMIDStoreObj.Datawire_ID__c = datawireIdStr;
    //System.debug('@@@@@@GSSMIDStoreObj.Terminal_ID__c '+GSSMIDStoreObj.Terminal_ID__c);
    //System.debug('@@@@@@GSSMIDStoreObj.Datawire_ID__c '+GSSMIDStoreObj.Datawire_ID__c);
        
    GSSMIDStoreList.add(GSSMIDStoreObj);   
    
    }
    System.debug('@@@@@@GSSMIDStoreObj '+GSSMIDStoreList);
    
    
    
return null;    
} 

//--------------------Inner classes used for serialization by readValuesAs()-------------------------------------------------
    public class MIDWrapper {
        public String merchantId;
        List<equipment> equipment;
        
        public MIDWrapper(String mId, List<equipment> eList) {
            merchantId = mId;
            equipment = eList.clone();
        }
    }  
    
    public class equipment {
        public String terminalNum;
        public String datawireId;
        public String serialNum;
        public String equipmentType;
    }
}