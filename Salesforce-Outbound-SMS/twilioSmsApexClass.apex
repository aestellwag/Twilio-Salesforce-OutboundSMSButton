public with sharing class twilioSmsApexClass {
    @AuraEnabled
        public static Map < String,
        Object > sendSmsApexRequest(String id, String message) { 
        List<Contact> details;
        String name;
        String phone;
        String mobile;
        
        system.debug('========message========='); 
        system.debug(message);
        
        // get contact details
        Contacts cont = new Contacts(); 
        details = cont.getContactDetails(id); 
        if(details.size()==1)
        {
            name = details[0].name; 
            phone = details[0].phone;
            mobile = details[0].mobilephone;
            message = 'Hello ' + name + ' ' + message;
        }
        
        String accountSid = 'ACXXXXXXXXXXXXXXXXXX';  // Update with Account Sid
        String apiKey = 'XXXXXXXXXXXXXXXXXXX';  // Update with API Key
        String apiSecret = 'XXXXXXXXXXXXXXXXXXX'; // Update with API Secret
        String fromNumber = '+XXXXXXXXXXX'; // Update to the Twilio Number, can look to enhance later
            
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/' + accountSid + '/Messages.json');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(apiKey + ':' + apiSecret)));
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody('To=' + EncodingUtil.urlEncode(phone, 'UTF-8') +
                        '&From=' + EncodingUtil.urlEncode(fromNumber, 'UTF-8') +
                        '&Body=' + EncodingUtil.urlEncode(message, 'UTF-8'));

        Http http = new Http();
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 201) {
            System.debug('SMS sent successfully to ' + phone);
        } else {
            System.debug('Error sending SMS to ' + phone + ': ' + response.getBody());
        }
        
        // Deserialize the JSON string into collections of primitive data types.
        Map < String,
        Object > resultsMap = (Map < String, Object > ) JSON.deserializeUntyped(response.getBody()); 
        system.debug('resultsMap-->'+ resultsMap);
        
        return resultsMap;
    }
}
