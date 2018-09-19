/**
 * Author: Creation Technology
 * Date: 18/09/2018
 * Description: 
 */
public class AccountQueueable implements Queueable {

    public CreateOrderParser newCreateOrderParser;
    public AccountQueueable(CreateOrderParser newCreateOrderParser) {
        this.newCreateOrderParser = newCreateOrderParser;
    } 
    /**
     * [execute - Insert an new account if it doesn't exist and chaining jobs]
     * @param context [QueueableContext]
     */
    public void execute(QueueableContext context){
        Boolean doesAccountExist = createOrderHelper.doesAccountExist(newCreateOrderParser.Account.companyid);
            if(!doesAccountExist) {
                Account newAccount           = new Account();
                newAccount.Name              = newCreateOrderParser.Account.Name;
                newAccount.companyid__c      = newCreateOrderParser.Account.companyid;
                newAccount.Address__c        = newCreateOrderParser.Account.address;
                newAccount.BillingState      = newCreateOrderParser.Account.state;
                newAccount.BillingCity       = newCreateOrderParser.Account.city;
                newAccount.BillingCountry    = newCreateOrderParser.Account.country;
                newAccount.BillingPostalCode = newCreateOrderParser.Account.postcode;
               
                try {
                    Insert newAccount;
                }
                catch (DmlException e) {
                    System.debug('The following exception has occurred: ' + e.getMessage());
                }
            }

        if(!Test.isRunningTest()) {
        	ContactQueueable newContactQueueable = new ContactQueueable(newCreateOrderParser);
            System.enqueueJob(newContactQueueable);
        }
    }
}