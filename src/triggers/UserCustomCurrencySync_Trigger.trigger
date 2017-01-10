trigger UserCustomCurrencySync_Trigger on User (before insert, before update)
{  
    System.debug('UserCustomCurrencySync_Trigger - Count of users:' + Trigger.New.size());
    for(user person : trigger.new)
    {
        if(trigger.isInsert)
        {
            System.debug('UserCustomCurrencySync_Trigger - insert for user: ' + person.Id +
                        '. Currency code=' + person.DefaultCurrencyIsoCode);
            //Set the custom currency field to the same as the built-in currency code
            //person.Currency__c = person.DefaultCurrencyIsoCode;
        }
        else if(trigger.isUpdate)
        {
            //If the built-in currency code changes, update the custom currency code to match
            user oldUser = trigger.oldMap.get(person.Id);
            
            System.debug('UserCustomCurrencySync_Trigger - check for update for user: ' + person.Id +
                        '. New Currency code=' + person.DefaultCurrencyIsoCode + '. Old currency code=' + oldUser.DefaultCurrencyIsoCode);
            
            If(oldUser.DefaultCurrencyIsoCode != person.DefaultCurrencyIsoCode)
            {
                System.debug('UserCustomCurrencySync_Trigger - update for user: ' + person.Id +
                        '. Currency code=' + person.DefaultCurrencyIsoCode);
                //person.Currency__c = person.DefaultCurrencyIsoCode;
            }
        }
    }
}