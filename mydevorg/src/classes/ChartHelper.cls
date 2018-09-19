public without sharing class ChartHelper {
    @AuraEnabled
    public static List<chartData> GetInventory(){
        List<chartData> cht = new List<chartData>();
        for(AggregateResult ag : [SELECT Family family, Sum(Quantity_Remaining__c) total 
									 FROM Product2 
                                     WHERE isActive = true 
                                     AND Quantity_Remaining__c > 0 
                                     Group By Family]){
            cht.add(new ChartData((string)ag.get('family') , Integer.valueOf(ag.get('total'))));
        }
        
        //ToDo: Perform a calculation that aggregates active Products that have a positive Quantity_Remaining__c
        //  And return a list of chartData
        //  Where the name is the Product Family and the Qty is the sum of the Quantity_Remaining__c
        return cht;
    }

    public class ChartData {
        public String name {get;set;}
        public Decimal val {get;set;}

        public ChartData(String name, Decimal val){
            this.name = name;
            this.val = val;
        }
    }

}