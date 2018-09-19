/**
 * Author: Creation Technology
 * Date: 18/09/2018
 * Description: 
 */
public class OpportunityQueueable implements Queueable{

	public CreateOrderParser newCreateOrderParser;
    public OpportunityQueueable(CreateOrderParser newCreateOrderParser) {
    	this.newCreateOrderParser = newCreateOrderParser;
    } 
    /**
     * [execute - Insert an new Opportunity chaining jobs]
     * @param context [QueueableContext]
     */
    public void execute(QueueableContext context){
        Account newAccount = createOrderHelper.getAccount(newCreateOrderParser.Account.companyid); 
        Contact newContact = createOrderHelper.getContact(newCreateOrderParser.Contact.workuserid);
        Opportunity newOpportunity    = new Opportunity();
        newOpportunity.Name           = newCreateOrderParser.Opportunity.companyname;
        newOpportunity.CloseDate      = System.today(); 
        newOpportunity.StageName      = '';
        newOpportunity.Contact__c     = newContact.Id;
        newOpportunity.AccountId      = newAccount.Id;
        newOpportunity.OrderNumber__c = newCreateOrderParser.Opportunity.orderid;
        try {
            Insert newOpportunity;
        }
        catch (DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        if(!Test.isRunningTest()) {

        }
    }
}