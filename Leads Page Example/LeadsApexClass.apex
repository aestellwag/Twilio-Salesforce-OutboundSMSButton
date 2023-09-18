public with sharing class Leads
{
    public Id leadId;
    public List<Lead> lst_lead;
    // method to query leads and retrieve Phone, MobilePhone fields 
    public List<Lead> getLeadDetails(Id ledId) {
        leadId = ledId;
        string query ='select Id, Name, Phone, MobilePhone from Lead where id = :leadId';
        lst_lead = Database.query(query);
        return lst_lead;
    } 
}