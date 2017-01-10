public with sharing class DataSort 
{
    //This variable stores the column header which is clicked and data should be sorted according to that column 
    public string sortColumn {get; set;}
    
    //This variable stores column according to which data is already sorted in the table.
    public String sColumnValue;
    
    public Boolean isAscending {get; set;}
    public Boolean isDescending {get; set;}
    
    public List<SObject> lstObj = new List<Sobject>();
    public static Boolean isSorted = TRUE;
    public final string OrderAsc = 'ASC';
    public final String OrderDesc = 'DESC';
    
    //Parameterized constructor 
    public DataSort(String firstSort)
    {
        //Identifies the column which should be sorted on table load.
        sortColumn = firstSort;
        sColumnValue = firstSort;        
    }
    
    //This method when called sorts the table data according to the parameter passed.
    public List<SObject> LoadSort(String sortOrder)
    {
        if(sortOrder == OrderAsc)
        {
            setAllVariablesToFalse();
            isAscending = TRUE;   
            lstObj = sortProcess(lstObj,sortColumn,OrderAsc);
        }
        else if(sortOrder == OrderDesc)
        {
            setAllVariablesToFalse();
            isDescending = TRUE;
            lstObj = sortProcess(lstObj,sortColumn,OrderDesc);
        }
        return lstObj;
    }
    
    //This method initialized the list of SObjects in the class that is to be sorted.
    public void initializeData(List<SObject> tempList)
    {
        lstObj = new List<Sobject>();
        lstObj.addAll(tempList);
    }
    
    //Method is invoked when clicked table column Header
    public List<SObject> sortData(String ColToSort)
    {
        sortColumn = ColToSort;
        
        if(sortColumn != sColumnValue) //A different column header is clicked.  
        {
            setAllVariablesToFalse();
            isDescending = TRUE;
        }
            
        //Data is alredy in Ascending order, sort it in descending order
        if(isAscending == TRUE)
        {
            setAllVariablesToFalse();
            isDescending = TRUE;
            lstObj = sortProcess(lstObj,sortColumn,OrderDesc);                 
        }
        //Data is alredy in descending order, sort it in Ascending order
        else if(isDescending == TRUE)
        {
            setAllVariablesToFalse();
            isAscending = TRUE;         
            lstObj = sortProcess(lstObj,sortColumn,OrderAsc);                   
        }
        
        sColumnValue = sortColumn;
        return lstObj;
    }
    
    //Method that actually sorts data
    List<SObject> sortProcess(List<SObject> lstUnSorted,String sortCol,string Ord)
    {
        List<SObject> tempList = new List<SObject>();
        Map<Object,List<SObject>> tempMap = new Map<Object,List<SObject>>();
        
        if(Ord == OrderDesc)
        {
            for (SObject recObj : lstUnSorted)
            {
                Object value = recObj.get(sortCol);
                List<SObject> tmpLst = new List<SObject>();
                if(tempMap.containsKey(value))
                {
                    tmpLst = tempMap.get(value);                      
                }
                tmpLst.add(recObj); 
                tempMap.put(value,tmpLst);                            
            }
            
            List<Object> lstDtim = new List<Object>();
            lstDtim.addAll(tempMap.keyset());
            lstDtim.sort();
            
            for(Integer tmp = lstDtim.size()-1 ; tmp >= 0; tmp --)
            {
                tempList.addAll(tempMap.get(lstDtim[tmp]));
            }       
        }
        else if(Ord == OrderAsc)
        {
            for (SObject recObj : lstUnSorted)
            {
                Object value = recObj.get(sortCol);
                List<SObject> tmpLst = new List<SObject>();
                if(tempMap.containsKey(value))
                {
                    tmpLst = tempMap.get(value);                      
                }
                tmpLst.add(recObj); 
                tempMap.put(value,tmpLst);                     
            }
                        
            List<Object> lstDtim = new List<Object>();
            lstDtim.addAll(tempMap.keyset());
            lstDtim.sort();
            
            for(Object recDtim : lstDtim)
            {
                tempList.addAll(tempMap.get(recDtim));
            }
        }
        return tempList;  
    }
    /*
    public void setVariables()
    {
        system.debug('Before______'+isSorted);
        if(isSorted == TRUE)
        {
            isAscending = TRUE;
            isDescending = FALSE;
            isSorted = FALSE;
        }
        system.debug('After______'+isSorted);
    }
    */
    void setAllVariablesToFalse()
    {
        isAscending = FALSE;
        isDescending = FALSE; 
    }
}