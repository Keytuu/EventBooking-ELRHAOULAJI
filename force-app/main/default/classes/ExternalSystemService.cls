public  class ExternalSystemService {

    @future (callout=true)

    public static void registerAttendees(List<Id> AccountIds){
        List<Contact> attendees = getListAccountByIDS(AccountIds);
        List<Contact> contactsToMail = new List<Contact>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:ReservationExternalSystem');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        HttpResponse response;

        for(Contact c : attendees){
        String jsonBody = JSON.serialize(
        new Map<String, Object> {
        'name' => c.name,
        'email' => c.Email });
        request.setBody(jsonBody);
        response = http.send(request);
            if (response.getStatusCode() != 201) {
                System.debug('The status code returned was not expected: ' +response.getStatusCode() + ' ' + response.getStatus());
            }
            else {
                contactsToMail.add(c);
            }
        }
        notifyAttendeesByEmail(contactsToMail);
    }

    public static void notifyAttendeesByEmail(List<Contact> contacts){

        List<Messaging.SingleEmailMessage> lstMails = new List<Messaging.SingleEmailMessage>();
        for(Contact c : contacts){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = new String[] { c.Email };
            message.optOutPolicy = 'FILTER';
            message.subject = 'Hello ' + c.Name +' The is Event Booked';
            message.plainTextBody = 'Event Booked';
            lstMails.add(message);
        }

        Messaging.SendEmailResult[] results = Messaging.sendEmail(lstMails);

        for(Messaging.SendEmailResult result : results){
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: ' + results[0].errors[0].message);
            }
        }
    }

}