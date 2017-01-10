public class pagingControllerForUser
{
    public List<User> AllSearchUsers
    {
        get
        {
            if(con != null)
                return (List<User>)con.getRecords();
            else
                return null ;
        }
        set;}
    
    public User usr {get; set;}
    
    //Controller
    public pagingControllerForUser()
    {
        AllSearchUsers = new List<User>() ;
        usr = new User() ;
    }
    
     public PageReference Search()
    {   
        if(usr.Name != null)
        {
            con = new ApexPages.StandardSetController(Database.getQueryLocator([select Id , name , email , phone, Department from User where name = :usr.Name]));
 
            // sets the number of records in each page set
            con.setPageSize(1);
        }
        else
        {
            con = null;
        }
        return null ;
    }
    
    //Instantiate the StandardSetController
    public ApexPages.StandardSetController con{get; set;}
    
    //Boolean to check if there are more records after the present displaying records
    public Boolean hasNext
    {
        get
        {
            return con.getHasNext();
        }
        set;
    }
 
    //Boolean to check if there are more records before the present displaying records
    public Boolean hasPrevious
    {
        get
        {
            return con.getHasPrevious();
        }
        set;
    }
 
    //Page number of the current displaying records
    public Integer pageNumber
    {
        get
        {
            return con.getPageNumber();
        }
        set;
    }

    //Returns the previous page of records
    public void previous()
    {
        con.previous();
    }
 
    //Returns the next page of records
    public void next()
    {
        con.next();
    }
}