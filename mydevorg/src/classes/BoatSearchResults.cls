public class BoatSearchResults {
    @AuraEnabled
    public static List<Boat__c> getBoats(String boatTypeId )
    {
        if(boatTypeId  != null && boatTypeId !='' ) {
            system.debug([SELECT Id, Name,Picture__c ,Contact__r.Name from Boat__c where BoatType__c =: boatTypeId] );
        	return [SELECT Id, Name,Picture__c ,Contact__r.Name from Boat__c where BoatType__c =: boatTypeId ];
        }
        else {
            return [SELECT Id, Name,Picture__c,Contact__r.Name from Boat__c];
        }
    }

}