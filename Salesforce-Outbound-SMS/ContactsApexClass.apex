public with sharing class Contacts {
    public Id contactId;
    public List<Contact> lst_contact;
    // method to query contacts and retrieve Phone, MobilePhone fields 
    public List<contact> getContactDetails(Id cntcid) {
     contactid = cntcid;
        string query ='select Id, Name, Phone, MobilePhone from contact where id = :contactid';
    lst_contact = Database.query(query);
    return lst_contact;
    } 
}