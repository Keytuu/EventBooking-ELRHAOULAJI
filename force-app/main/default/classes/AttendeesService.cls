
public class AttendeesService{

    public void registerAttendees(Case case){
        HttpResponse registerContact(Contact c)

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(this.webServiceURL);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Set the body as a JSON object
        request.setBody('{"name":"'+ c.name + '-' + c.email  +'}');
        HttpResponse response = http.send(request);
        return response;
    }
}
