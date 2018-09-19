trigger UpdateAccounts on Contact (before insert) {
 if(trigger.isAfter && trigger.isInsert){
       Map<Id,Account> accountMap = new Map<Id,Account>(); 
       Set<Id> accountIds = new Set<Id>();
          for(Contact thisContact : trigger.new) {
              if(thisContact.AccountId != null) {
                  accountIds.add(thisContact.AccountId);
                  //accountMap.put(thisContact.AccountId,);
              }
          }
     List<Account> lstAccount = [Select id,Industry from Account where Id in : accountIds];
     for(Account thisAccount : lstAccount) {
         accountMap.put(thisAccount.Id,thisAccount);
     }
     List<Account> acclst = new list<Account>();
     for(Contact thisContact : trigger.new) {
         if(accountMap.containsKey(thisContact.AccountId)) {
             Account acc  = accountMap.get(thisContact.AccountId);
			 acc.Industry = 'Chemicals';  
             acclst.add(acc);
         }
     }
     update acclst;
     
     }
}