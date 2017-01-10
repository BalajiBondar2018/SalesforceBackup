public class ShowProjectThresholdController {
    //variable decleration
    public List<ThresholdWrapper> thresholdWrapperList {get;set;}
    public List<OfficeDepot__Revenue_History__c> revenueHistoryList = new List<OfficeDepot__Revenue_History__c>();
    
    public ShowProjectThresholdController(ApexPages.StandardController controller) {
                Account accountObj = (Account) controller.getRecord();
                thresholdWrapperList = new List<ThresholdWrapper>();
                revenueHistoryList = [select Id, OfficeDepot__Week__c, OfficeDepot__Speed_to_Revenue_Health__c, OfficeDepot__Account__c from OfficeDepot__Revenue_History__c
                                                where OfficeDepot__Account__c =:accountObj.Id order by OfficeDepot__Week__c];
                
                //revenueHistoryList = [select Id, OfficeDepot__Week__c, OfficeDepot__Speed_to_Revenue_Health__c, OfficeDepot__Account__c from OfficeDepot__Revenue_History__c];
                
                
                 for(Integer count=0 ; count < revenueHistoryList.size() ; count++){
                        ThresholdWrapper thresholdWrapperObj = new ThresholdWrapper();
                        thresholdWrapperObj.weekstartDate = revenueHistoryList[count].OfficeDepot__Week__c;
                        thresholdWrapperObj.ThresholdValue = Integer.valueof(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c);
                        //---------------------------------------------Threshold Range(50-54)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 50 && revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c<= 54){
                            thresholdWrapperObj.show5054CellFlag = TRUE;
                            if(count==0){
                                    thresholdWrapperObj.show5054TopArrowFlag = TRUE;
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                        thresholdWrapperObj.show5054TopArrowFlag = TRUE;
                                //Increase Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                        thresholdWrapperObj.show5054RightArrowFlag = TRUE;
                                }       
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show5054LeftArrowFlag = TRUE;
                                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=55) thresholdWrapperObj.show5559ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=60) thresholdWrapperObj.show6064ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=65) thresholdWrapperObj.show6569ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=70) thresholdWrapperObj.show7074ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=75) thresholdWrapperObj.show7579ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=80) thresholdWrapperObj.show8084ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=85) thresholdWrapperObj.show8589ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=90) thresholdWrapperObj.show90ContinousLeftArrowFlag = TRUE;
                                }
                            }       
                        }
                        //---------------------------------------------Threshold Range(55-59)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 55 && revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c<= 59){
                            thresholdWrapperObj.show5559CellFlag = TRUE;
                            if(count==0){
                                    thresholdWrapperObj.show5559RightArrowFlag = TRUE;
                                    thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                        thresholdWrapperObj.show5559TopArrowFlag = TRUE;
                                //Increase Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                        thresholdWrapperObj.show5559RightArrowFlag = TRUE;
                        
                                        if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=54) thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                }
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show5559LeftArrowFlag = TRUE;                               
                                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=60) thresholdWrapperObj.show6064ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=65) thresholdWrapperObj.show6569ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=70) thresholdWrapperObj.show7074ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=75) thresholdWrapperObj.show7579ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=80) thresholdWrapperObj.show8084ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=85) thresholdWrapperObj.show8589ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=90) thresholdWrapperObj.show90ContinousLeftArrowFlag = TRUE;
                                }
                            }       
                        }
                        //---------------------------------------------Threshold Range(60-64)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 60 && revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c<= 64){
                            thresholdWrapperObj.show6064CellFlag = TRUE;
                            if(count==0){
                                    thresholdWrapperObj.show6064RightArrowFlag = TRUE;
                                    thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                    thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                        thresholdWrapperObj.show6064TopArrowFlag = TRUE;
                                //Increase Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                        thresholdWrapperObj.show6064RightArrowFlag = TRUE;
                        
                                        if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=54) thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                        if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=59) thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                }
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                    thresholdWrapperObj.show6064LeftArrowFlag = TRUE;
                                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=65) thresholdWrapperObj.show6569ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=70) thresholdWrapperObj.show7074ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=75) thresholdWrapperObj.show7579ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=80) thresholdWrapperObj.show8084ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=85) thresholdWrapperObj.show8589ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=90) thresholdWrapperObj.show90ContinousLeftArrowFlag = TRUE;
                            }       
                        }
                        
                        //---------------------------------------------Threshold Range(65-69)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 65 && revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c<= 69){
                            thresholdWrapperObj.show6569CellFlag = TRUE;
                            if(count==0){
                                thresholdWrapperObj.show6569RightArrowFlag = TRUE;
                                thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                    thresholdWrapperObj.show6569TopArrowFlag = TRUE;
                                //Increase Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show6569RightArrowFlag = TRUE;
                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=54) thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=59) thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=64) thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                }
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show6569LeftArrowFlag = TRUE;                               
                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=70) thresholdWrapperObj.show7074ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=75) thresholdWrapperObj.show7579ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=80) thresholdWrapperObj.show8084ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=85) thresholdWrapperObj.show8589ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=90) thresholdWrapperObj.show90ContinousLeftArrowFlag = TRUE;
                                }
                            }       
                        }
                        
                        //---------------------------------------------Threshold Range(70-74)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 70 && revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c<= 74){
                            thresholdWrapperObj.show7074CellFlag = TRUE;
                            if(count==0){
                                thresholdWrapperObj.show7074RightArrowFlag = TRUE;
                                thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                    thresholdWrapperObj.show7074TopArrowFlag = TRUE;
                                //Increase Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show7074RightArrowFlag = TRUE;
                            
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=54) thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=59) thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=64) thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=69) thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                }
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show7074LeftArrowFlag = TRUE;                               
                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=75) thresholdWrapperObj.show7579ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=80) thresholdWrapperObj.show8084ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=85) thresholdWrapperObj.show8589ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=90) thresholdWrapperObj.show90ContinousLeftArrowFlag = TRUE;
                            }
                            }       
                        }
                        
                        //---------------------------------------------Threshold Range(75-79)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 75 && revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c<= 79){
                            thresholdWrapperObj.show7579CellFlag = TRUE;
                            if(count==0){
                                thresholdWrapperObj.show7579RightArrowFlag = TRUE;
                                thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show7074ContinousRightArrowFlag = TRUE;
                                    
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                    thresholdWrapperObj.show7579TopArrowFlag = TRUE;
                                //Increase Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show7579RightArrowFlag = TRUE;
                                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=54) thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=59) thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=64) thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=69) thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=74) thresholdWrapperObj.show7074ContinousRightArrowFlag = TRUE;
                                }
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show7579LeftArrowFlag = TRUE;                               
            
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=80) thresholdWrapperObj.show8084ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=85) thresholdWrapperObj.show8589ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=90) thresholdWrapperObj.show90ContinousLeftArrowFlag = TRUE;
                                }
                            }       
                        }
                        
                        //---------------------------------------------Threshold Range(80-84)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 80 && revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c<= 84){
                            thresholdWrapperObj.show8084CellFlag = TRUE;
                            if(count==0){
                                thresholdWrapperObj.show8084RightArrowFlag = TRUE;
                                thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show7074ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show7579ContinousRightArrowFlag = TRUE;
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                    thresholdWrapperObj.show8084TopArrowFlag = TRUE;
                                //Increase Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show8084RightArrowFlag = TRUE;
                                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=54) thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=59) thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=64) thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=69) thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=74) thresholdWrapperObj.show7074ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=79) thresholdWrapperObj.show7579ContinousRightArrowFlag = TRUE;
                                }
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show8084LeftArrowFlag = TRUE;                               
                                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=85) thresholdWrapperObj.show8589ContinousLeftArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=90) thresholdWrapperObj.show90ContinousLeftArrowFlag = TRUE;
                                }
                            }       
                        }
                        
                        
                        //---------------------------------------------Threshold Range(85-89)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 85 && revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c<= 89){
                            thresholdWrapperObj.show8589CellFlag = TRUE;
                            if(count==0){
                                thresholdWrapperObj.show8589RightArrowFlag = TRUE;
                                thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show7074ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show7579ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show8084ContinousRightArrowFlag = TRUE;
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                    thresholdWrapperObj.show8589TopArrowFlag = TRUE;
                                //Increase Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show8589RightArrowFlag = TRUE;
                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=54) thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=59) thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=64) thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=69) thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=74) thresholdWrapperObj.show7074ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=79) thresholdWrapperObj.show7579ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=84) thresholdWrapperObj.show8084ContinousRightArrowFlag = TRUE;
                                }
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show8589LeftArrowFlag = TRUE;                               
                                            
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c>=90) thresholdWrapperObj.show90ContinousLeftArrowFlag = TRUE;
                                }
                            }       
                        }
                        
                        //---------------------------------------------Threshold Range(90+)-----------------------------------------------------------------------------
                        if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c>= 90){
                            thresholdWrapperObj.show90CellFlag = TRUE;
                            if(count==0){
                                thresholdWrapperObj.show90RightArrowFlag = TRUE;
                                thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show7074ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show7579ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show8084ContinousRightArrowFlag = TRUE;
                                thresholdWrapperObj.show8589ContinousRightArrowFlag = TRUE;
                            }
                            else{
                                if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c == revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c)
                                    thresholdWrapperObj.show90TopArrowFlag = TRUE;
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c >= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show90RightArrowFlag = TRUE;
                                    
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=54) thresholdWrapperObj.show5054ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=59) thresholdWrapperObj.show5559ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=64) thresholdWrapperObj.show6064ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=69) thresholdWrapperObj.show6569ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=74) thresholdWrapperObj.show7074ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=79) thresholdWrapperObj.show7579ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=84) thresholdWrapperObj.show8084ContinousRightArrowFlag = TRUE;
                                    if(revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c<=89) thresholdWrapperObj.show8589ContinousRightArrowFlag = TRUE;
                                }
                                //Decrease Graph
                                else if(revenueHistoryList[count].OfficeDepot__Speed_to_Revenue_Health__c <= revenueHistoryList[count-1].OfficeDepot__Speed_to_Revenue_Health__c){
                                    thresholdWrapperObj.show90LeftArrowFlag = TRUE;                         
                                }
                            }       
                        }
                        
                thresholdWrapperList.add(thresholdWrapperObj);  
                }
        }

       public class ThresholdWrapper{
            public Date weekstartDate{get;set;}
            public Integer ThresholdValue {get;set;}
            
            public Boolean show5054CellFlag{get;set;}
            public Boolean show5559CellFlag{get;set;}
            public Boolean show6064CellFlag{get;set;}
            public Boolean show6569CellFlag{get;set;}
            public Boolean show7074CellFlag{get;set;}
            public Boolean show7579CellFlag{get;set;}
            public Boolean show8084CellFlag{get;set;}
            public Boolean show8589CellFlag{get;set;}
            public Boolean show90CellFlag{get;set;}
            
            public Boolean show5054RightArrowFlag {get;set;}
            public Boolean show5054LeftArrowFlag {get;set;}
            public Boolean show5054TopArrowFlag {get;set;}
            
            public Boolean show5559RightArrowFlag {get;set;}
            public Boolean show5559LeftArrowFlag {get;set;}
            public Boolean show5559TopArrowFlag {get;set;}
            
            public Boolean show6064RightArrowFlag {get;set;}
            public Boolean show6064LeftArrowFlag {get;set;}
            public Boolean show6064TopArrowFlag {get;set;}
            
            public Boolean show6569RightArrowFlag {get;set;}
            public Boolean show6569LeftArrowFlag {get;set;}
            public Boolean show6569TopArrowFlag {get;set;}
            
            public Boolean show7074RightArrowFlag {get;set;}
            public Boolean show7074LeftArrowFlag {get;set;}
            public Boolean show7074TopArrowFlag {get;set;}
            
            public Boolean show7579RightArrowFlag {get;set;}
            public Boolean show7579LeftArrowFlag {get;set;}
            public Boolean show7579TopArrowFlag {get;set;}
            
            public Boolean show8084RightArrowFlag {get;set;}
            public Boolean show8084LeftArrowFlag {get;set;}
            public Boolean show8084TopArrowFlag {get;set;}
            
            public Boolean show8589RightArrowFlag {get;set;}
            public Boolean show8589LeftArrowFlag {get;set;}
            public Boolean show8589TopArrowFlag {get;set;}
            
            public Boolean show90RightArrowFlag {get;set;}
            public Boolean show90LeftArrowFlag {get;set;}
            public Boolean show90TopArrowFlag {get;set;}
            
            //---------------------Continous Arrow ------------------------------
            public Boolean show5054ContinousRightArrowFlag {get;set;}
            public Boolean show5054ContinousLeftArrowFlag {get;set;}
            
            public Boolean show5559ContinousRightArrowFlag {get;set;}
            public Boolean show5559ContinousLeftArrowFlag {get;set;}
            
            public Boolean show6064ContinousRightArrowFlag {get;set;}
            public Boolean show6064ContinousLeftArrowFlag {get;set;}
            
            public Boolean show6569ContinousRightArrowFlag {get;set;}
            public Boolean show6569ContinousLeftArrowFlag {get;set;}
            
            public Boolean show7074ContinousRightArrowFlag {get;set;}
            public Boolean show7074ContinousLeftArrowFlag {get;set;}
            
            public Boolean show7579ContinousRightArrowFlag {get;set;}
            public Boolean show7579ContinousLeftArrowFlag {get;set;}
            
            public Boolean show8084ContinousRightArrowFlag {get;set;}
            public Boolean show8084ContinousLeftArrowFlag {get;set;}
            
            public Boolean show8589ContinousRightArrowFlag {get;set;}
            public Boolean show8589ContinousLeftArrowFlag {get;set;}
            
            public Boolean show90ContinousRightArrowFlag {get;set;}
            public Boolean show90ContinousLeftArrowFlag {get;set;}
    }   
}


/*
   public PageReference onLoad() {
       
        thresholdWrapperList = new List<ThresholdWrapper>();
        //-----------------------------------------------------------1---------------------------------------------------
        ThresholdWrapper thresholdWrapperObj1 = new ThresholdWrapper();
        
        thresholdWrapperObj1.weekstartDate = System.Today();
        thresholdWrapperObj1.ThresholdValue = 52;
        
        thresholdWrapperObj1.show5054CellFlag = FALSE;
        thresholdWrapperObj1.show5559CellFlag = FALSE;
        thresholdWrapperObj1.show6064CellFlag = FALSE;
        thresholdWrapperObj1.show6569CellFlag = FALSE;
        thresholdWrapperObj1.show7074CellFlag = TRUE;
            thresholdWrapperObj1.show7074RightArrowFlag = TRUE;
            thresholdWrapperObj1.show7074LeftArrowFlag = FALSE;
            thresholdWrapperObj1.show7074TopArrowFlag = FALSE;
        thresholdWrapperObj1.show7579CellFlag = FALSE;
        thresholdWrapperObj1.show8084CellFlag = FALSE;
        thresholdWrapperObj1.show8589CellFlag = FALSE;
        thresholdWrapperObj1.show90CellFlag = FALSE;
        
        
         thresholdWrapperObj1.show5054ContinousRightArrowFlag = TRUE;
         thresholdWrapperObj1.show5054ContinousLeftArrowFlag = FALSE;
        
         thresholdWrapperObj1.show5559ContinousRightArrowFlag = TRUE;
         thresholdWrapperObj1.show5559ContinousLeftArrowFlag = FALSE;
        
         thresholdWrapperObj1.show6064ContinousRightArrowFlag = TRUE;
         thresholdWrapperObj1.show6064ContinousLeftArrowFlag = FALSE;
        
         thresholdWrapperObj1.show6569ContinousRightArrowFlag = TRUE;
         thresholdWrapperObj1.show6569ContinousLeftArrowFlag = FALSE;
        
         thresholdWrapperObj1.show7074ContinousRightArrowFlag = FALSE;
         thresholdWrapperObj1.show7074ContinousLeftArrowFlag = FALSE;
        
         thresholdWrapperObj1.show7579ContinousRightArrowFlag = FALSE;
         thresholdWrapperObj1.show7579ContinousLeftArrowFlag = FALSE;
        
         thresholdWrapperObj1.show8084ContinousRightArrowFlag = FALSE;
         thresholdWrapperObj1.show8084ContinousLeftArrowFlag = FALSE;
        
         thresholdWrapperObj1.show8589ContinousRightArrowFlag = FALSE;
         thresholdWrapperObj1.show8589ContinousLeftArrowFlag = FALSE;
        
         thresholdWrapperObj1.show90ContinousRightArrowFlag = FALSE;
         thresholdWrapperObj1.show90ContinousLeftArrowFlag = FALSE;
        //------------------------------------------------------------2--------------------------------------------------
        ThresholdWrapper thresholdWrapperObj2 = new ThresholdWrapper();
        
        thresholdWrapperObj2.weekstartDate = System.Today() + 7;
        thresholdWrapperObj2.ThresholdValue = 52;
        
        thresholdWrapperObj2.show5054CellFlag = TRUE;
            thresholdWrapperObj2.show5054RightArrowFlag = FALSE;
            thresholdWrapperObj2.show5054LeftArrowFlag = TRUE;
            thresholdWrapperObj2.show5054TopArrowFlag = FALSE;
        thresholdWrapperObj2.show5559CellFlag = FALSE;
        thresholdWrapperObj2.show6064CellFlag = FALSE;
        thresholdWrapperObj2.show6569CellFlag = FALSE;
        thresholdWrapperObj2.show7074CellFlag = FALSE;
            
        thresholdWrapperObj2.show7579CellFlag = FALSE;
        thresholdWrapperObj2.show8084CellFlag = FALSE;
        thresholdWrapperObj2.show8589CellFlag = FALSE;
        thresholdWrapperObj2.show90CellFlag = FALSE;
        
        thresholdWrapperObj2.show5054ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj2.show5054ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj2.show5559ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj2.show5559ContinousLeftArrowFlag = TRUE;
        
        thresholdWrapperObj2.show6064ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj2.show6064ContinousLeftArrowFlag = TRUE;
        
        thresholdWrapperObj2.show6569ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj2.show6569ContinousLeftArrowFlag = TRUE;
        
        thresholdWrapperObj2.show7074ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj2.show7074ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj2.show7579ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj2.show7579ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj2.show8084ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj2.show8084ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj2.show8589ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj2.show8589ContinousLeftArrowFlag = FALSE;
        
        //------------------------------------------------------------3--------------------------------------------------
        ThresholdWrapper thresholdWrapperObj3 = new ThresholdWrapper();
        
        thresholdWrapperObj3.weekstartDate = System.Today() + 14;
        thresholdWrapperObj3.ThresholdValue = 52;
        
        thresholdWrapperObj3.show5054CellFlag = TRUE;
            thresholdWrapperObj3.show5054RightArrowFlag = FALSE;
            thresholdWrapperObj3.show5054LeftArrowFlag = FALSE;
            thresholdWrapperObj3.show5054TopArrowFlag = TRUE;
        thresholdWrapperObj3.show5559CellFlag = FALSE;
        thresholdWrapperObj3.show6064CellFlag = FALSE;
        thresholdWrapperObj3.show6569CellFlag = FALSE;
        thresholdWrapperObj3.show7074CellFlag = FALSE;
            
        thresholdWrapperObj3.show7579CellFlag = FALSE;
        thresholdWrapperObj3.show8084CellFlag = FALSE;
        thresholdWrapperObj3.show8589CellFlag = FALSE;
        thresholdWrapperObj3.show90CellFlag = FALSE;
        
        thresholdWrapperObj3.show5054ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj3.show5054ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj3.show5559ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj3.show5559ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj3.show6064ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj3.show6064ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj3.show6569ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj3.show6569ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj3.show7074ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj3.show7074ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj3.show7579ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj3.show7579ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj3.show8084ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj3.show8084ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj3.show8589ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj3.show8589ContinousLeftArrowFlag = FALSE;

        //--------------------------------------------------4------------------------------------------------------------
        ThresholdWrapper thresholdWrapperObj4 = new ThresholdWrapper();
        
        thresholdWrapperObj4.weekstartDate = System.Today() + 21;
        thresholdWrapperObj4.ThresholdValue = 52;
        
        thresholdWrapperObj4.show5054CellFlag = FALSE;
        thresholdWrapperObj4.show5559CellFlag = FALSE;
        thresholdWrapperObj4.show6064CellFlag = FALSE;
        thresholdWrapperObj4.show6569CellFlag = FALSE;
        thresholdWrapperObj4.show7074CellFlag = FALSE;
            
        thresholdWrapperObj4.show7579CellFlag = TRUE;
                thresholdWrapperObj4.show7579RightArrowFlag = TRUE;
            thresholdWrapperObj4.show7579LeftArrowFlag = FALSE;
            thresholdWrapperObj4.show7579TopArrowFlag = FALSE;
        thresholdWrapperObj4.show8084CellFlag = FALSE;
        thresholdWrapperObj4.show8589CellFlag = FALSE;
        thresholdWrapperObj4.show90CellFlag = FALSE;
           
        
        thresholdWrapperObj4.show5054ContinousRightArrowFlag = TRUE;
        thresholdWrapperObj4.show5054ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj4.show5559ContinousRightArrowFlag = TRUE;
        thresholdWrapperObj4.show5559ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj4.show6064ContinousRightArrowFlag = TRUE;
        thresholdWrapperObj4.show6064ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj4.show6569ContinousRightArrowFlag = TRUE;
        thresholdWrapperObj4.show6569ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj4.show7074ContinousRightArrowFlag = TRUE;
        thresholdWrapperObj4.show7074ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj4.show7579ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj4.show7579ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj4.show8084ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj4.show8084ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj4.show8589ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj4.show8589ContinousLeftArrowFlag = FALSE;
        //--------------------------------------------------5------------------------------------------------------------
        ThresholdWrapper thresholdWrapperObj5 = new ThresholdWrapper();
        
        thresholdWrapperObj5.weekstartDate = System.Today() + 28;
        thresholdWrapperObj5.ThresholdValue = 52;
        
        thresholdWrapperObj5.show5054CellFlag = FALSE;
        thresholdWrapperObj5.show5559CellFlag = FALSE;
        thresholdWrapperObj5.show6064CellFlag = FALSE;
        thresholdWrapperObj5.show6569CellFlag = FALSE;
        thresholdWrapperObj5.show7074CellFlag = FALSE;
            
        thresholdWrapperObj5.show7579CellFlag = FALSE;
        thresholdWrapperObj5.show8084CellFlag = FALSE;
        thresholdWrapperObj5.show8589CellFlag = FALSE;
        thresholdWrapperObj5.show90CellFlag = TRUE;
            thresholdWrapperObj5.show90RightArrowFlag = TRUE;
            thresholdWrapperObj5.show90LeftArrowFlag = FALSE;
            thresholdWrapperObj5.show90TopArrowFlag = FALSE;
        
        thresholdWrapperObj5.show5054ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj5.show5054ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj5.show5559ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj5.show5559ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj5.show6064ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj5.show6064ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj5.show6569ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj5.show6569ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj5.show7074ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj5.show7074ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj5.show7579ContinousRightArrowFlag = FALSE;
        thresholdWrapperObj5.show7579ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj5.show8084ContinousRightArrowFlag = TRUE;
        thresholdWrapperObj5.show8084ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperObj5.show8589ContinousRightArrowFlag = TRUE;
        thresholdWrapperObj5.show8589ContinousLeftArrowFlag = FALSE;
        
        thresholdWrapperList.add(thresholdWrapperObj1);
        thresholdWrapperList.add(thresholdWrapperObj2);
        thresholdWrapperList.add(thresholdWrapperObj3);
        thresholdWrapperList.add(thresholdWrapperObj4);
        thresholdWrapperList.add(thresholdWrapperObj5);
        
        
          
        return null;
    }
*/