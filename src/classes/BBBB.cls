global class BBBB implements System.Schedulable {
global String mail{get;set;}
global String nmJob{get;set;}
global String request{get;set;}
global String schedule{get;set;}

global void execute(SchedulableContext sc) {
  newPublier();
}

global BBBB () {}


global BBBB (String mail, String request, String schedule) {
this.mail= mail;
this.request= request;
this.schedule= schedule;

}

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


global void schedulejob(){      
        String email = getMail();
        String req = getRequete();
        String sch = getSchedule();
                       
        String NomJobSchedulable = nmJob;
        BBBB p = new BBBB(email , req, sch);
        system.schedule(NomJobSchedulable , sch, p);
}

public void newPublier(){
   
  }   
}