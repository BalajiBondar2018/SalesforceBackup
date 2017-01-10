global class GSBBundleDataWebService { 
    webService static List<Account> fetchBundleInformation(List<InputParameter> InputParameterList) { 
    System.debug('@@@@@@InputParameterList '+InputParameterList);
    //variable decleration
    List<Account> accountList = new List<Account>();
    Map<string,string> inputParameterListKeyValueMap = new Map<string,string>();
    
    for(InputParameter InputParameterObj : InputParameterList){
        inputParameterListKeyValueMap.put(InputParameterObj.key , InputParameterObj.value);
    }
    
    Id partnerId = [select Id from Account where Id=:inputParameterListKeyValueMap.get('PartnerId')].Id;
    Id channelId = [select Id from Contact where Id=:inputParameterListKeyValueMap.get('ChannelId')].Id;
    string MCCCode = inputParameterListKeyValueMap.get('MCCCode');
    string isEquipment = inputParameterListKeyValueMap.get('IsEquipment');
    
    if(partnerId != Null && channelId != Null && (MCCCode != Null || MCCCode != '')  && (isEquipment != Null || isEquipment != '')){
        accountList = [select Id,Name from Account LIMIT 2];
        System.debug('@@@@@@accountList '+accountList );
    }
    return accountList;
    }        
    
    //generic webservice input parameter defination
    global class InputParameter{ 
    webService String key;
    webService String value; 
        public InputParameter(string key, string value){
        this.key = key;
        this.value = value;
        }
    }
}

/*
GSBBundleDataWebService.InputParameter ParentIdInputParameter = new GSBBundleDataWebService.InputParameter('PartnerId','1212121212');
GSBBundleDataWebService.InputParameter ChannelIdInputParameter = new GSBBundleDataWebService.InputParameter('ChannelId','98989898');
GSBBundleDataWebService.InputParameter MCCCodeInputParameter = new GSBBundleDataWebService.InputParameter('MCCCode','0570');
GSBBundleDataWebService.InputParameter IsEquipmentParameter = new GSBBundleDataWebService.InputParameter('IsEquipment','No');

List<GSBBundleDataWebService.InputParameter> InputParameterList = new List<GSBBundleDataWebService.InputParameter>();
InputParameterList.add(ParentIdInputParameter);
InputParameterList.add(ChannelIdInputParameter);
InputParameterList.add(MCCCodeInputParameter);
InputParameterList.add(IsEquipmentParameter);
List<Account> accountList = new List<Account>();
accountList = GSBBundleDataWebService.fetchBundleInformation(InputParameterList);
*/