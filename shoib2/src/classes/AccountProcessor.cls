public class AccountProcessor {
    @future
    public Static void  countContacts(Set<Id> ids)
    {
       List<Account> acc=[select id,Number_of_Contacts__c,(Select Id from Contacts) from Account where Id in:Ids];
        for(Account accn:acc)
        {
           List<Contact> conList=accn.Contacts;
           accn.Number_of_Contacts__c=conList.size();            
        }
        update acc;
       
    }

}