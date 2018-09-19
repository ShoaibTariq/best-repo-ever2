public class Product2Helper {

    /**
     * @name COLLABORATION_GROUP
     * @description List of CollaborationGroup used in both business and test logic
    **/
    static List<CollaborationGroup> COLLABORATION_GROUP = [
        SELECT Id
        FROM CollaborationGroup
        WHERE Name =:Constants.INVENTORY_ANNOUNCEMENTS 
        OR Name = :('TEST'+ Constants.INVENTORY_ANNOUNCEMENTS )
        LIMIT 1
    ];

    /**
     * @name afterUpdate
     * @description called by product2 Trigger on After Update
     * @param List<Product2> newList
     * @param List<Product2> oldList
    **/
    public static void AfterUpdate(List<Product2> newList){
	    List<Product2> needsAnnouncement = new  List<Product2>();
        Map<String,Inventory_Setting__mdt> invertoryMetaDataMap = new  Map<String,Inventory_Setting__mdt>();
        For(Inventory_Setting__mdt thisInventorySetting :[SELECT DeveloperName,Low_Quantity_Alert__c 
                                                          FROM Inventory_Setting__mdt ]) {
            invertoryMetaDataMap.put(thisInventorySetting.DeveloperName,thisInventorySetting);
                                                              
          }
        for(product2 prd:newList) {
            if(invertoryMetaDataMap.containsKey(prd.Family) 
               && prd.Quantity_Remaining__c 
               < invertoryMetaDataMap.get(prd.Family).Low_Quantity_Alert__c){
                needsAnnouncement.add(prd);
            }
            PostAlerts(needsAnnouncement);
        }

        //ToDo: Pass records to the postAlerts method
    }

    /**
     * @name postAlerts
     * @description called by product2 Trigger on After Update
     * @param List<Product2> productList
    **/
    public static void PostAlerts(List<Product2> productList){
            List<ConnectApi.AnnouncementInput> toPost = new List<ConnectApi.AnnouncementInput>();
        for ( Product2 p : productList ){
            // ToDo: Construct a new AnnouncementInput for the Chatter Group so that it:
            // expires in a day
            // does not notify users via email.
            // and has a text body that includes the name of the product followed by the INVENTORY_LEVEL_LOW constant
            ConnectApi.MessageBodyInput mbi = new ConnectApi.MessageBodyInput();
            ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
            mbi.messageSegments = new List<ConnectApi.MessageSegmentInput>();
            textSegmentInput.text = p.Name + Constants.INVENTORY_LEVEL_LOW;
            mbi.messageSegments.add(textSegmentInput);
            
        	ConnectApi.AnnouncementInput ai = new ConnectApi.AnnouncementInput();
            ai.expirationDate = Date.today().addDays(1);
            ai.sendEmails = true;
            ai.parentId = COLLABORATION_GROUP[0].Id;
            ai.body = mbi;
            
            toPost.add(ai);
        }
        // ToDo: Create and enqueue an instance of the announcementQueuable class with the list of Products
        AnnouncementQueueable q = new AnnouncementQueueable();
        q.toPost = toPost;
        System.enqueueJob(q);
    }
}