global class ExporterCSV implements System.Schedulable {
    global void execute(SchedulableContext sc) {
    /*
    List<Account> acclist = [Select id , name , CreatedDate , lastModifiedDate from Acocunt limit 10];
    string header = 'Record Id , Name , Created Date , Modified Date \n';
    string finalstr = header ;
    for(Account a: acclist)
    {
       string recordString = a.id + ',' + a.Name + ',' + a.CreatedDate + ',' + a.LastModifiedDate + '\n';
       finalstr = finalstr + recordString;
    }
    Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
    blob csvBlob = Blob.valueOf(finalstr);
    string csvname= 'Invoice.csv';
    csvAttc.setFileName(csvname);
    csvAttc.setBody(csvBlob);
    Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
    String[] toAddresses = new list<string> {'test@salesforce.com'};
    String subject = 'Merchandise Report CSV';
    email.setSubject(subject);
    email.setToAddresses( toAddresses );
    email.setPlainTextBody('The Merchandise report is attached here.');
    email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    */
    }
}