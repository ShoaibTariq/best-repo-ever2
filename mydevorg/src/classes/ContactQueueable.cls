/**
 * Author: Creation Technology
 * Date: 18/09/2018
 * Description: 
 */
public class ContactQueueable implements Queueable {
    
    public CreateOrderParser newCreateOrderParser;
    public ContactQueueable(CreateOrderParser newCreateOrderParser) {
        this.newCreateOrderParser = newCreateOrderParser;
    } 
    /**
     * [execute - Insert an new Contact if it doesn't exist and chaining jobs]
     * @param context [QueueableContext]
     */
    public void execute(QueueableContext context){
        Boolean doesContactExist = createOrderHelper.doesContactExist(newCreateOrderParser.Contact.workuserid);
        if(!doesContactExist) {
            Contact newContact        = new Contact();
            newContact.FirstName      = newCreateOrderParser.Contact.firstname;
            newContact.LastName       = newCreateOrderParser.Contact.lastname;
            newContact.Salutation     = newCreateOrderParser.Contact.salutation;
            newContact.WorkUserId__c  = newCreateOrderParser.Contact.workuserid;
            newContact.Title          = newCreateOrderParser.Contact.jobtitle;
            newContact.Address__c     = newCreateOrderParser.Contact.address;
            newContact.Phone          = newCreateOrderParser.Contact.telephone;

            try {
                Insert newContact;
            }
            catch (DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        }
        if(!Test.isRunningTest()) {
            OpportunityQueueable newOpportunitytQueueable = new OpportunityQueueable(newCreateOrderParser);
            System.enqueueJob(newOpportunitytQueueable);
        }
    }
}