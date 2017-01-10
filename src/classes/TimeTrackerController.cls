public class TimeTrackerController {
    public PageReference NextWeek() {
        return null;
    }


    public PageReference PreviousWeek() {
        return null;
    }


public date todayDate = date.today();
public date weekStart = todayDate.toStartofWeek();
public date weekEnd;
public string currentMonthStr{get;set;}
List<string> weekDaysList = new string[]{'MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY'};
List<Integer> weekDateList = new List<Integer>();
public date todayStr{get;set;}

public List<Integer> getweekDateList(){
return weekDateList;
}

public date gettodayStr(){
return todayStr;
}

public List<string> getweekDaysList(){
return weekDaysList;
}

public string getcurrentMonthStr(){
return currentMonthStr;
}

     
    public PageReference InitFunction() {
    weekStart = weekStart.adddays(1);
    weekDateList = CurrentWeekDates(weekStart);
    currentMonthStr = CurrentMonth(weekStart.month());
    todayStr = date.today();
    return null;
    }

    public List<Integer> CurrentWeekDates(date weekStart){
    for(Integer i=0;i<=6;i++){
    Integer weekday = weekStart.day();
    weekDateList.add(weekday);
    weekStart = weekStart.adddays(1);
    }    
    return weekDateList;
    }

    public string CurrentMonth(Integer cMonthInt){
    string cMonthStr;
    if(cMonthInt==1)
    cMonthStr = 'Jan';
    else if(cMonthInt==2)
    cMonthStr = 'Feb';
    else if(cMonthInt==3)
    cMonthStr = 'Mar';
    else if(cMonthInt==4)
    cMonthStr = 'Apr';
    else if(cMonthInt==5)
    cMonthStr = 'May';
    else if(cMonthInt==6)
    cMonthStr = 'June';
    else if(cMonthInt==7)
    cMonthStr = 'July';
    else if(cMonthInt==8)
    cMonthStr = 'Aug';
    else if(cMonthInt==9)
    cMonthStr = 'Sep';
    else if(cMonthInt==10)
    cMonthStr = 'Oct';
    else if(cMonthInt==11)
    cMonthStr = 'Nov';
    else if(cMonthInt==11)
    cMonthStr = 'Dec';
    
    return cMonthStr;
    }



}