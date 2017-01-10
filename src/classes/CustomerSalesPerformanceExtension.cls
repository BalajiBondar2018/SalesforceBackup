public class CustomerSalesPerformanceExtension {
public Account accountObj{get;set;}      
public List<Sales_Performance__c> salesPerformanceList = new List<Sales_Performance__c>();
public List<Sales_Performance__c> getsalesPerformanceList(){
        return salesPerformanceList;    
}       
        public CustomerSalesPerformanceExtension(ApexPages.StandardController controller) {
        accountObj = (Account) controller.getRecord();
        accountObj = [select Id, Name from Account where Id=:accountObj.Id LIMIT 1];
        salesPerformanceList = [Select s.c_IMU_Per__c, s.cMin9_Net_Sales__c, s.cMin9_IMU__c, s.cMin9_IMU_Per__c, s.cMin8_Net_Sales__c,
                                                        s.cMin8_IMU__c, s.cMin8_IMU_Per__c, s.cMin7_Net_Sales__c, s.cMin7_IMU__c, s.cMin7_IMU_Per__c, s.cMin6_Net_Sales__c,
                                                    s.cMin6_IMU__c, s.cMin6_IMU_Per__c, s.cMin5_Net_Sales__c, s.cMin5_IMU__c, s.cMin5_IMU_Per__c, s.cMin4_Net_Sales__c,
                                                    s.cMin4_IMU__c, s.cMin4_IMU_Per__c, s.cMin3_Net_Sales__c, s.cMin3_IMU__c, s.cMin3_IMU_Per__c, s.cMin2_Net_Sales__c,
                                                    s.cMin2_IMU__c, s.cMin2_IMU_Per__c, s.cMin1_Net_Sales__c, s.cMin1_IMU__c, s.cMin1_IMU_Per__c, s.cMin12_Net_Sales__c,
                                                    s.cMin12_IMU__c, s.cMin12_IMU_Per__c, s.cMin11_Net_Sales__c, s.cMin11_IMU__c, s.cMin11_IMU_Per__c, s.cMin10_Net_Sales__c,
                                                    s.cMin10_IMU__c, s.cMin10_IMU_Per__c, s.c0_Net_Sales__c, s.c0_IMU__c, s.c0_IMU_Per__c, s.c0Min1_Net_Sales__c,
                                                    s.c0Min1_IMU__c, s.c0Min1_IMU_Per__c, s.Year__c, s.Name, s.Id, s.CurrencyIsoCode, s.Category__c, s.C0_Week4_Net_Sales__c,
                                                    s.C0_Week4_IMU__c, s.C0_Week4_IMU_Perc__c, s.C0_Week3_Net_Sales__c, s.C0_Week3_IMU__c, s.C0_Week3_IMU_Perc__c,
                                                    s.C0_Week2_Net_Sales__c, s.C0_Week2_IMU__c, s.C0_Week1_Net_Sales__c, s.C0_Week1_IMU__c, s.C0_Week1_IMUPerc__c,
                                                    s.C0_Wee2_IMU__c, s.C0_Period__c, s.Account__c From Sales_Performance__c s where s.account__c=:accountObj.Id];
    }
}