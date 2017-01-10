global class ReportExporter implements System.Schedulable {
    global void execute(SchedulableContext sc) {
        ApexPages.PageReference report = new ApexPages.PageReference('/00O90000008q76c?csv=1');
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('FurnisherNotificationReport.csv');
        attachment.setBody(report.getContent());
        attachment.setContentType('text/csv');
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
        message.setSubject('Furnisher Notification Report');
        message.setPlainTextBody('The report is attached.');
        message.setToAddresses( new String[] { 'balaji.bondar@firstdata.com' } );
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
    }
}