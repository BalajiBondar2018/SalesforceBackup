trigger CommitApprovedAccountPlanChanges on Account_Plan__c (after insert, after update) {
	//variables declerations for Insert trigger operations
	public Set<Id> accountIdSet = new Set<Id>();
	public Set<Id> accountCloneIdSet = new Set<Id>();
    public Map<Id , Account_Plan__c> accountplanMap = new Map<Id , Account_Plan__c>();
	public Map<Id,Account> accountIdAccountMap = new Map<Id,Account>();
	public Map<Id,Contact> contactIdcontactMap = new Map<Id,Contact>();
	public Map<Id,Opportunity> opportunityIdopportunityMap = new Map<Id,Opportunity>();
	
	public Map<Id,Account_Clone__c> accountIdAccountCloneMap = new Map<Id,Account_Clone__c>();
	public List<Contact_Clone__c> contactCloneList = new List<Contact_Clone__c>();
	public List<Opportunity_Clone__c> opportunityCloneList = new List<Opportunity_Clone__c>();  
	
	//variables declerations for update trigger operations
	public Set<Id> accountPlanObjIdSet = new Set<Id>();
	public Map<Id,Account_Clone__c> accountcloneIdAccountCloneMap = new Map<Id,Account_Clone__c>();
	public Map<Id,Contact_Clone__c> contactcloneIdcontactCloneMap = new Map<Id,Contact_Clone__c>();
	public Map<Id,Opportunity_Clone__c> opportunitycloneIdopportunityCloneMap = new Map<Id,Opportunity_Clone__c>();
	
	public List<Account> accountList = new List<Account>();
	public List<Contact> contactList = new List<Contact>();
	public List<Opportunity> opportunityList = new List<Opportunity>();

	//create New Account Clone, Contact Clones & Opportunity Clones on creation of new Account Plan    
    if(trigger.isAfter && trigger.isInsert){
		//fetch all the accountplan records being inserted
		for(Account_Plan__c accountplanObj : Trigger.new){
            accountIdSet.add(accountplanObj.account__c);  
        }
        //fetch the account details related to account plan records 
        for(Account_Plan__c accountPlanObj :[select Id, account__c, account__r.Name, account__r.AccountNumber, account__r.OwnerId from Account_Plan__c where Id IN : Trigger.new]){
        	accountplanMap.put(accountPlanObj.Id, accountPlanObj);	
        }
        
        //fetch all the Account,Contact,Opportunity Objects under the updated Account Plans
        for(Account accObj : [Select Id, Name, AccountNumber, OwnerId, (select Id, AccountId, FirstName, LastName, Phone, email from Contacts),(select Id, Name, AccountId, CloseDate, StageName, TotalOpportunityQuantity, Product__c from Opportunities) From Account where Id IN : accountIdSet]){
            accountIdAccountMap.put(accObj.Id , accObj);
            for(Contact conObj : accObj.Contacts){
            	contactIdcontactMap.put(conObj.Id, conObj);	
            }
            for(Opportunity oppObj : accObj.Opportunities){
            	opportunityIdopportunityMap.put(oppObj.Id, oppObj);	
            }
        }
        
        //create a map of account clone wrt to the account plan records
        for(Account_Plan__c accountplanObj : Trigger.new){
	        Account_Clone__c accCloneObj = new Account_Clone__c();
	        accCloneObj.AccountPlan__c = accountplanObj.Id;
	        accCloneObj.Ref_Account__c =  accountplanMap.get(accountplanObj.Id).account__c;
			accCloneObj.Name__c = accountplanMap.get(accountplanObj.Id).account__r.Name;
			accCloneObj.AccountNumber__c =  accountplanMap.get(accountplanObj.Id).account__r.AccountNumber;
			accCloneObj.Owner__c =  accountplanMap.get(accountplanObj.Id).account__r.OwnerId;
	        System.debug('@@@@@@@@accCloneObj '+accCloneObj);
	        accountIdAccountCloneMap.put(accountplanObj.account__c, accCloneObj);
        }
        
        //System.debug('@@@@@@@@@@accountIdAccountCloneMap.size() '+accountIdAccountCloneMap.size());
        	List<Database.SaveResult> AccountInsertResults = Database.insert(accountIdAccountCloneMap.values(), false); 
        //System.debug('@@@@@@@@@@AccountInsertResults '+AccountInsertResults);
        
        for(Database.Saveresult databasesaveresult : AccountInsertResults) 
        	accountCloneIdSet.add(databasesaveresult.getId());
        
        //fetch the details of account clone records being inserted and use reference for inserted contact clones & opportunity clones
        for(Account_Clone__c accountCloneObj : [select Id, Ref_Account__c from Account_Clone__c where Id IN :accountCloneIdSet]){
        	accountIdAccountCloneMap.put(accountCloneObj.Ref_Account__c , accountCloneObj);	
        }	
        
        //create contact clone records for under newly generated Account Plan
        for(Contact conObj : contactIdcontactMap.values()){
        	Contact_Clone__c contactCloneObj = new Contact_Clone__c();
        	contactCloneObj.AccountClone__c = accountIdAccountCloneMap.get(conObj.AccountId).Id;
        	contactCloneObj.Ref_Contact__c = conObj.Id;
        	contactCloneObj.LastName__c = contactIdcontactMap.get(conObj.Id).LastName;
		    contactCloneObj.FirstName__c = contactIdcontactMap.get(conObj.Id).FirstName;
	        contactCloneObj.Phone__c = contactIdcontactMap.get(conObj.Id).Phone;
        	contactCloneObj.Email__c = contactIdcontactMap.get(conObj.Id).Email;
        	contactCloneList.add(contactCloneObj);
        }
        insert contactCloneList;
        //System.debug('@@@@@@@@@@contactCloneList '+contactCloneList);
    	
    	//create opportunity clone records for under newly generated Account Plan
    	for(Opportunity oppObj : opportunityIdopportunityMap.values()){
        	Opportunity_Clone__c  opportunityCloneObj = new Opportunity_Clone__c();
        	opportunityCloneObj.AccountClone__c = accountIdAccountCloneMap.get(oppObj.AccountId).Id;
        	opportunityCloneObj.Ref_Opportunity__c = oppObj.Id;
        	opportunityCloneObj.Opportunity_Name__c = opportunityIdopportunityMap.get(oppObj.Id).Name;
        	opportunityCloneObj.Quantity__c = opportunityIdopportunityMap.get(oppObj.Id).TotalOpportunityQuantity;
	        opportunityCloneObj.Product__c = opportunityIdopportunityMap.get(oppObj.Id).Product__c;
	        opportunityCloneObj.Closed_Date__c = opportunityIdopportunityMap.get(oppObj.Id).CloseDate;
	        opportunityCloneObj.Stage__c = opportunityIdopportunityMap.get(oppObj.Id).StageName;
        	opportunityCloneList.add(opportunityCloneObj);
        }
    	insert opportunityCloneList;
    	//System.debug('@@@@@@@@@@opportunityCloneList '+opportunityCloneList);
    }


	//update Account,Contact & Opportunity records when Account Plan is apporved
    if(trigger.isAfter && trigger.isUpdate){
        for(Account_Plan__c accountplanObj : Trigger.new){
            if(accountplanObj.Request_Status__c == 'Approved') accountPlanObjIdSet.add(accountplanObj.Id);  
        }
        //fetch all the Account Clone Objects under the updated Account Plans
        for(Account_Clone__c accCloneObj : [Select Ref_Account__c, Owner__c, Name__c, Name, Id, AccountPlan__c, AccountNumber__c From Account_Clone__c where AccountPlan__c IN : accountPlanObjIdSet]){
            accountcloneIdAccountCloneMap.put(accCloneObj.Id , accCloneObj);
        }
        
        //fetch all the Contact Clone Objects under the Account Clone object
        for(Contact_Clone__c conCloneObj : [Select Ref_Contact__c, Phone__c, Name, LastName__c, Id, FirstName__c, Email__c,AccountClone__c From Contact_Clone__c where AccountClone__c IN :accountcloneIdAccountCloneMap.Keyset()]){
            contactcloneIdcontactCloneMap.put(conCloneObj.Ref_Contact__c , conCloneObj);
        }
        
        //fetch all the Opportunity Clone Objects under the updated the Account Clone object
        for(Opportunity_Clone__c oppCloneObj : [Select Stage__c, Ref_Opportunity__c, Quantity__c, Product__c, Opportunity_Name__c, Name, Id, Closed_Date__c, AccountClone__c From Opportunity_Clone__c where AccountClone__c IN : accountcloneIdAccountCloneMap.Keyset()]){
            opportunitycloneIdopportunityCloneMap.put(oppCloneObj.Ref_Opportunity__c , oppCloneObj);
        }
        
        for(Account accountObj : [select Id, Name, AccountNumber, OwnerId from Account where Id IN :accountcloneIdAccountCloneMap.keyset()]){
            accountObj.Name = accountcloneIdAccountCloneMap.get(accountObj.Id).Name__c;
            accountObj.AccountNumber = accountcloneIdAccountCloneMap.get(accountObj.Id).AccountNumber__c;
            accountObj.OwnerId = accountcloneIdAccountCloneMap.get(accountObj.Id).Owner__c;
            accountList.add(accountobj);
        }   
        
        for(Contact contactObj : [select Id, FirstName, LastName, Phone, Email from Contact where Id IN :contactcloneIdcontactCloneMap.keyset()]){
            contactObj.FirstName = contactcloneIdcontactCloneMap.get(contactObj.Id).FirstName__c;
            contactObj.LastName = contactcloneIdcontactCloneMap.get(contactObj.Id).LastName__c;
            contactObj.Phone = contactcloneIdcontactCloneMap.get(contactObj.Id).Phone__c;
            contactObj.Email = contactcloneIdcontactCloneMap.get(contactObj.Id).Email__c;
            contactList.add(contactObj);
        }
    
        for(Opportunity oppObj : [select Id, Name, TotalOpportunityQuantity, Product__c, CloseDate, StageName from Opportunity where Id IN :opportunitycloneIdopportunityCloneMap.keyset()]){
            oppObj.Name = opportunitycloneIdopportunityCloneMap.get(oppObj.Id).Opportunity_Name__c;
            oppObj.TotalOpportunityQuantity = opportunitycloneIdopportunityCloneMap.get(oppObj.Id).Quantity__c;
            oppObj.Product__c = opportunitycloneIdopportunityCloneMap.get(oppObj.Id).Product__c;
            oppObj.CloseDate = opportunitycloneIdopportunityCloneMap.get(oppObj.Id).Closed_Date__c;
            oppObj.StageName = opportunitycloneIdopportunityCloneMap.get(oppObj.Id).Stage__c;
            opportunityList.add(oppObj);
        }
        
        update accountList;
        update contactList;
        update opportunityList;
    }
}