public class SalesDashboardPDFExtension {
public Account accountObj {get;set;}
    public SalesDashboardPDFExtension(ApexPages.StandardController controller) {
    accountObj = (Account) controller.getRecord();
    accountObj = [Select a.number_of_Traverllers_Claimants__c, a.Name,a.ERP__c,  a.Travel_Info__c, a.Total_Travel_Spend__c, a.Total_Travel_Spend_Rail__c, a.Total_Travel_Spend_Hotel__c,
                                    a.Top_5_10_cardable_Supplier__c, a.TMC__c, a.Short_Term_Objective__c, a.Long_Term_Objective__c, a.Last_Month__c, a.Key_Drivers__c,
                                    a.Expense_Management_Provider__c, a.Decision_Making__c, a.Customer_Expense_Mgmt_System_use_Detail__c, a.CustomerPriority__c,
                                    a.Competitor_Information__c, a.BillingStreet, a.BillingState, a.BillingPostalCode, a.BillingCountry, a.BillingCity,
                                    a.B2B_Short_Term_Objective__c, a.B2B_Long_Term_Objective__c, a.B2B_Expense_Management_Provider__c,
                                    a.B2B_Decision_Making__c, a.B2B_Competitor_Information__c From Account a where Id=:accountObj.Id LIMIT 1];
    }

}