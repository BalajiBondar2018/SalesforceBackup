public class SendMessageController {

    public PageReference doSendEmail() {
       // Step 0: Create a master list to hold the emails we'll send
  List<Messaging.SingleEmailMessage> mails = 
  new List<Messaging.SingleEmailMessage>();
        // Step 1: Create a new Email
      Messaging.SingleEmailMessage mail = 
      new Messaging.SingleEmailMessage();
    
      // Step 2: Set list of people who should get the email
      List<String> sendTo = new List<String>();
      //sendTo.add('jigar5890@gmail.com');
      sendTo.add('balajibondar@gmail.com');
      mail.setToAddresses(sendTo);
    
      // Step 3: Set who the email is sent from
      mail.setReplyTo('emailconfirm@merchantacct.wellsfargobank.com');
      mail.setSenderDisplayName('emailconfirm@merchantacct.wellsfargobank.com');
    
      
      // Step 4. Set email contents - you can use variables!
      mail.setSubject('URGENT BUSINESS PROPOSAL');
      
      String body= 'I confess this will come as a surprise to you.';
      mail.setHtmlBody(body);
    
      // Step 5. Add your email to the master list
      mails.add(mail);
      
      // Step 6: Send all emails in the master list
      Messaging.sendEmail(mails);
        
        return null;
    }

}