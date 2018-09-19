trigger AccountDuplicates on Account (before insert,after insert,after update) {
    if(trigger.isBefore && trigger.isInsert) {
        Set<String> duplicateSet = new Set<String>();
           for(Account thisAccount : [Select id,Name from Account]) {
               duplicateSet.add(thisAccount.Name);
       }
      for(Account thisAccount : trigger.new) {
        if(duplicateSet.contains(thisAccount.Name)) {
            thisAccount.addError('failed duplicate exist');
        }
      }
    }
    if(trigger.isAfter && trigger.isInsert){
       List<Contact> contactToInsert = new  List<Contact>();
       integer i = 0;
       for(Account thisAccount : trigger.new) {
           Contact con = new Contact();
           con.LastName = 'sona' +i;
           con.AccountId = thisAccount.id;
           contactToInsert.add(con);
           i++;
        }
        insert contactToInsert;
      }
     if(trigger.isAfter && trigger.isInsert){
       Map<Id,Account> accountMap = new Map<Id,Account>();  
     }
}