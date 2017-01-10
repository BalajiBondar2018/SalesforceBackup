global class JobEngineExtension implements System.Schedulable {
//variable decleration
global String mail{get;set;}
global String nmJob{get;set;}
global String request{get;set;}
global String schedule{get;set;}
global List<CronTrigger> CronTriggerList = new List<CronTrigger>();

global void setMail(String mail) {
    this.mail= mail;
}

global String getMail() {
    return mail;
}

global void setRequete(String request) {
    this.request= request;
}

global String getRequete() {
    return request;
}

global void setSchedule(String schedule) {
    this.schedule= schedule;
}

global String getSchedule() {
    return schedule;
}

global JobEngineExtension (String mail, String request, String schedule) {


}

public JobEngineExtension(ApexPages.StandardController controller) {
mail = 'balaji.bondar@firstdata.com';
request = 'select Id, Name , Owner From Account LIMIT 100';
Integer totalJobCount = [select count() from CronTrigger];
totalJobCount = totalJobCount  + 1 ; 
nmJob = 'Test Job ' + totalJobCount ;
schedule = '0 20 16 * * ?';

}

global void execute(SchedulableContext sc) {
  newPublier();
}


global List<CronTrigger> getCronTriggerList(){
    List<CronTrigger> CronTriggerList = [Select Id,CronJobDetailId,CronJobDetail.Name,StartTime,PreviousFireTime,NextFireTime,State,EndTime,TimeZoneSidKey,OwnerId,TimesTriggered from CronTrigger];
    return CronTriggerList;
}

global void  setCronTriggerList(List<CronTrigger> CronTriggerList ){
    this.CronTriggerList  = CronTriggerList ;
    
}




global Pagereference AbortJobClick(){
String JobId = System.currentPagereference().getParameters().get('JobId');
System.abortJob(JobId );
getCronTriggerList();
return null;
}


global void schedulejob(){      
        String email = getMail();
        String req = getRequete();
        String sch = getSchedule();
                       
        String NomJobSchedulable = nmJob;
        JobEngineExtension p = new JobEngineExtension(email , req, sch);
        system.schedule(NomJobSchedulable , sch, p);
}

public void newPublier(){
    request= 'select Id, Name, createddate, OwnerId from Account LIMIT 100';
    String query=request;
    
    System.debug('@@@@@@@@@@@query '+query);
    String premier=query.substringAfter('select ');   
    premier=  premier.substringBefore('from');
      
    string titre= premier+'\n';
    string contenuCSV = titre;

    string queryResultatString = '';
 
    list<sObject> queryResultat = (List<sObject>)database.query(request);
    for(sObject a: queryResultat)
    {
        queryResultatString = queryResultatString + string.valueof(a);  
    }
   
    list<string> queryLignes = queryResultatString.split('}');
  for(string s:queryLignes){
        list<string> queryColonnes = s.split(',');
        for(string st:queryColonnes){
            contenuCSV = contenuCSV + st.substringAfter('=') + ',';
        }
        contenuCSV = contenuCSV.substringBeforeLast(',').substringBeforeLast(',') + '\n';
    }

      Messaging.EmailFileAttachment csvPJ = new Messaging.EmailFileAttachment();
      blob csvBlob = Blob.valueOf(contenuCSV);
      string csvNom = 'WMS_Account_'+Date.today().format()+'.csv';
      csvPJ.setFileName(csvNom);
      csvPJ.setBody(csvBlob);
      Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
      String[] adressMail = new list<string> {'balaji.bondar@firstdata.com'};
      String subject = 'WMS Account Extract - '+Date.today().format();
      email.setSubject(subject);
      email.setToAddresses(adressMail);
      email.setPlainTextBody('Test Report Body....');   
      email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvPJ});
      Messaging.SendEmailResult [] envoyer = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});





}

}