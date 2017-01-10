global class ReportScheduler1 implements System.Schedulable {
    global void execute(SchedulableContext sc) {
        ApexPages.PageReference report = new ApexPages.PageReference('/00O90000008qMOl?csv=1');
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('WMSReport.csv');
        attachment.setBody(report.getContent());
        attachment.setContentType('text/csv');
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
        message.setSubject('WMS Report');
        message.setPlainTextBody('The report is attached.');
        message.setToAddresses( new String[] { 'balajibondar@gmail.com','balajibondar@gmail.com' } );
        //message.setCcAddresses(new String[] { 'abc3@test.com'});
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
    }
}