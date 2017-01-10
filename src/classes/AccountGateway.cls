/**
 * Class AccountGateway
 * Provides finder methods for accessing data in the Account object.
 */
public without sharing class AccountGateway{
    /**
     * Returns a subset of id's where there are any records in use.
     *
     * Arguments:   Set<Id> accIds - Set of Account Id's to examine
     *
     * Returns:     Set<Id> - Set of Account Id's that are 'in use'
     */
    public static Set<Id> findAccountIdsInUse(Set<Id> accIds)
    {
        Set<Id> inUseIds = new Set<Id>();
        
        for (List<Account> accounts : [Select p.Id, (Select Id From Opportunities Limit 1) From Account p where p.Id in : accIds]){   
            for (Account acc : accounts){
                if (acc.Opportunities.size() > 0){
                    inUseIds.add(acc.id);
                    System.debug('Test');
                }
            }
        }
        return inUseIds;
    }
}