public class FinancialController{

    // The year to be charted
    public String chartYear { 
        get {
            if (chartYear == Null) chartYear = '2013';
            return chartYear;
        }
        set;
    }
    
    // Years available to be charted, for <apex:selectList>
    public static List<SelectOption> getChartYearOptions() {
        List<SelectOption> years = new List<SelectOption>();
        years.add(new SelectOption('2013','2013'));
        years.add(new SelectOption('2012','2012'));
        years.add(new SelectOption('2011','2011'));
        years.add(new SelectOption('2010','2010'));
        return years;
    }
    
    public List<PieWedgeData> getPieData() {
        // Visualforce expressions can't pass parameters, so get from property
        return FinancialController.generatePieData(this.chartYear);
    }
    
    @RemoteAction
    public static List<PieWedgeData> getRemotePieData(String year) {
        // Remoting calls can send parameters with the call
        return FinancialController.generatePieData(year);
    }

    // Private data "generator"
    private static List<PieWedgeData> generatePieData(String year) {
        List<PieWedgeData> data = new List<PieWedgeData>();
        if(year.equals('2013')) {
            // These numbers are absolute quantities, not percentages
            // The chart component will calculate the percentages
            data.add(new PieWedgeData('Jan', 30));
            data.add(new PieWedgeData('Feb', 15));
            data.add(new PieWedgeData('Mar', 10));
            data.add(new PieWedgeData('Apr', 20));
            data.add(new PieWedgeData('May', 20));
            data.add(new PieWedgeData('Jun',  5));
        }
        else {
            data.add(new PieWedgeData('Jan', 20));
            data.add(new PieWedgeData('Feb', 35));
            data.add(new PieWedgeData('Mar', 30));
            data.add(new PieWedgeData('Apr', 40));
            data.add(new PieWedgeData('May',  5));
            data.add(new PieWedgeData('Jun', 10));
        }
        return data;
    }

    // Wrapper class
    public class PieWedgeData {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieWedgeData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
}