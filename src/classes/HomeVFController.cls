public class HomeVFController {
public List<Case> getCaseList(){
return [select Id, caseNumber, Owner.Name from Case LIMIT 5];
}

// Return a list of data points for a chart
    public List<Data> getData() {
        return HomeVFController.getChartData();
    }
    
    // Make the chart data available via JavaScript remoting
    @RemoteAction
    public static List<Data> getRemoteData() {
        return HomeVFController.getChartData();
    }

    // The actual chart data; needs to be static to be
    // called by a @RemoteAction method
    public static List<Data> getChartData() {
        List<Data> data = new List<Data>();
        data.add(new Data('Jan', 30, 40, 45));
        data.add(new Data('Feb', 44, 15, 55));
        data.add(new Data('Mar', 25, 32, 65));
        data.add(new Data('Apr', 74, 28, 55));
        data.add(new Data('May', 65, 51, 65));
        data.add(new Data('Jun', 33, 45, 39));
        data.add(new Data('Jul', 52, 52, 30));
        data.add(new Data('Aug', 57, 53, 45));
        data.add(new Data('Sep', 34, 65, 55));
        data.add(new Data('Oct', 58, 66, 56));
        data.add(new Data('Nov', 60, 67, 73));
        data.add(new Data('Dec', 17, 60, 50));
        return data;
    }
    
    // Wrapper class
    public class Data {
        public String name { get; set; }
        public Integer data1 { get; set; }
        public Integer data2 { get; set; }
        public Integer data3 { get; set; }
        public Data(String name, Integer data1, Integer data2, Integer data3) {
            this.name = name;
            this.data1 = data1;
            this.data2 = data2;
            this.data3 = data3;
        }
    }
}