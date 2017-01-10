global class MyWebService {
    webService static string makeContact(List<InputParameter> InputParameterList) {
    return 'success';
    }
    
    global class InputParameter{
     webService String key;
     webService Integer value;
  }
}