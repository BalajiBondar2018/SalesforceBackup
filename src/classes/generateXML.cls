public class generateXML {
    public void generateXmlRequest(){
        
        System.debug('@@@@@@@@@@@@@@generateXmlRequest');
        DOM.Document body = new DOM.Document();
        String prefix = 'xsd';
        String nameSpace = 'xsd';
        String method = 'pushAccountRequest';
        
        DOM.XmlNode root = body.createRootElement('schema', 'http://my.name.space/SD', 'xsd');
        System.debug('@@@@@@@@@@@root '+root);
        
        
        List<String> allRequieredFields = fetchAccountFields();
        System.debug('@@@@@@@@@@@allRequieredFields '+allRequieredFields );
        String requiredFields = String.join(allRequieredFields, ',');
        
        //List<Account> allAccounts = Database.query('SELECT ' + requiredFields + ', (select id, name, email from Contacts) FROM ACCOUNT LIMIT 1');
        List<Account> allAccounts = Database.query('SELECT Name,Phone,Id, (select id, name, email from Contacts) FROM ACCOUNT LIMIT 1');
        System.debug('@@@@@@@@@@@allAccounts '+allAccounts  );
       
        List<OfficeDepot__WMS_Fields__c> serviceFields = [
                            SELECT o.OfficeDepot__sequence__c, o.OfficeDepot__minOccurs__c, o.OfficeDepot__XMLLabel__c, o.OfficeDepot__Type__c,
                            o.OfficeDepot__Source_Object__c, o.OfficeDepot__Request_Name__c, o.OfficeDepot__Parent_Node__c, o.OfficeDepot__Node__c,
                            o.OfficeDepot__NameSpace_Prefix__c, o.OfficeDepot__Field_Name__c, o.OfficeDepot__Data_Type__c, o.Name, o.Id 
                            From OfficeDepot__WMS_Fields__c o
                 
                WHERE o.OfficeDepot__Request_Name__c = :method
                ORDER BY o.OfficeDepot__sequence__c];
        System.Debug('@@@@@@@@@@@@@@OfficeDepot__WMS_Fields__c ' + serviceFields.size());
        
       //Add Account Details one by one
        for(Account eachAccount : allAccounts){
            Dom.XmlNode accountNode = root.addChildElement('complexType','xsd',  'xsd');
            accountNode.SetAttribute( 'name' , 'accountobj');
            appendSObjectToXml(accountNode, eachAccount, serviceFields);
            System.debug(body.toXmlString());
        }
    }
    
    public void appendSObjectToXml(Dom.XmlNode accountNode, Account eachAccount, List<OfficeDepot__WMS_Fields__c> serviceFields){
        Map<string, dom.xmlnode> xmlnodemap = new Map<string, dom.xmlnode>();
        
        //get Namespaces from custom setting
        Map<String,OfficeDepot__WMS_Namespaces__c> allNameSpaces = OfficeDepot__WMS_Namespaces__c.getall();
         System.Debug('@@@@@@@@@@@@@@allNameSpaces  ' + allNameSpaces);
        
        for(OfficeDepot__WMS_Fields__c field : serviceFields){
            if(field.Type__c == 'XmlNode'){
                if(field.Parent_Node__c == 'root'){
                    xmlnodemap.put(field.OfficeDepot__XMLLabel__c, accountNode);
                }
                else{
                    DOM.XmlNode xmlNode = xmlnodemap.get(field.OfficeDepot__Parent_Node__c).addChildElement(field.OfficeDepot__Node__c, 'xsd', 'xsd');
                    if(field.OfficeDepot__Node__c != 'complexType'){
                        xmlNode .SetAttribute( 'name' , field.OfficeDepot__XMLLabel__c);
                        xmlNode .SetAttribute( 'type' , 'xsd:string');
                    }
                    xmlnodemap.put(field.OfficeDepot__XMLLabel__c, xmlNode);
                    }
            }else if(field.Type__c == 'Field'){
                String innerText = '';
                Boolean isNull = true;
                
                //get the required field 
                String fieldRequired = field.Field_Name__c;
                sObject anAccount = eachAccount;
                Object value = anAccount.get(fieldRequired);
                System.Debug('Field: ' + fieldRequired + ' Value: ' + String.valueOf(value));
                
                if(value != null){
                    innerText = String.valueOf(value);
                    isNull = false;
                }
                
                if(!isNull){
                    DOM.XmlNode xmlField = xmlnodemap.get(field.OfficeDepot__Parent_Node__c).addChildElement(field.OfficeDepot__Node__c, 'xsd' , 'xsd');                                
                    xmlField.SetAttribute( 'name' , field.OfficeDepot__XMLLabel__c);
                    xmlField.SetAttribute( 'type' , 'xsd:string');
                    xmlField.addTextNode(innerText);
                    System.debug('@@@@@@@@@@@xmlField'+xmlField); 
                }
            }
        }
    }
    
    private List<String> fetchAccountFields(){
        List<OfficeDepot__WMS_Fields__c> allServiceFields = [
                SELECT o.OfficeDepot__sequence__c, o.OfficeDepot__minOccurs__c, o.OfficeDepot__XMLLabel__c, o.OfficeDepot__Type__c,
                 o.OfficeDepot__Source_Object__c, o.OfficeDepot__Request_Name__c, o.OfficeDepot__Parent_Node__c, o.OfficeDepot__Node__c,
                  o.OfficeDepot__NameSpace_Prefix__c, o.OfficeDepot__Field_Name__c, o.OfficeDepot__Data_Type__c, o.Name, o.Id 
                  From OfficeDepot__WMS_Fields__c o
                  
                WHERE o.OfficeDepot__Type__c = 'Field' and o.OfficeDepot__Source_Object__c = 'Account'];
        List<String> allFields = new List<String>();
        for(OfficeDepot__WMS_Fields__c aServiceField : allServiceFields){
            allFields.add(aServiceField.Field_Name__c);
        }
        return allFields;
    }
    
}