/**
 * @name TestDataFactory
 * @description Contains methods to construct and/or validate commonly used records
**/
public with sharing class TestDataFactory {

    /**
     * @name ConstructCollaborationGroup
     * @description
    **/
    public static  CollaborationGroup ConstructCollaborationGroup(){
        //ToDo: Ensure this method returns a single Chatter CollaborationGroup
        //    whose Name starts with 'TEST' followed by the INVENTORY_ANNOUNCEMENTS constant
        //    and configured so anyone can join, see and post updates.
        CollaborationGroup ChatterGroup = new CollaborationGroup(
        Name = 'TEST'+Constants.INVENTORY_ANNOUNCEMENTS,  
        CollaborationType     = 'Public',
        IsArchived            = false,
        IsAutoArchiveDisabled = true
        );
        insert ChatterGroup;
        return ChatterGroup;
    }

    /**
     * @name CreateProducts
     * @description Constructs a list of Product2 records for unit tests
    **/
    public static List<Product2> ConstructProducts(Integer cnt){
        List<Product2> proList = new  List<Product2>();
        list<Schema.PicklistEntry> pEntries = Constants.PRODUCT_FAMILY;
        Integer pVal = 0;
 			for(Integer i=0;i<cnt;i++){
            Product2 pd2=new Product2();
            pd2.Name='Product-'+i;
            pd2.IsActive = true;
            pd2.Initial_Inventory__c = 10;
            if(pVal == 4){
                pVal = 0;
            }
            pd2.Family = pEntries.get(pVal).getValue();
            pVal++;
            proList.add(pd2);
        }
        return proList;
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Product2 records
        //  with all the required fields populated
        //  and IsActive = true
        //  an Initial Inventory set to 10
        //  and iterating through the product family picklist values throughout the list.
    }

    /**
     * @name CreatePricebookEntries
     * @description Constructs a list of PricebookEntry records for unit tests
    **/
    public static List<PricebookEntry> ConstructPricebookEntries(List<Product2> prods){
        List<PricebookEntry> pbList = new  List<PricebookEntry>();
        for(Product2 pd2: prods){
            PriceBookEntry pbe=new PriceBookEntry();
            pbe.isActive = true;
            pbe.Product2Id = pd2.id;
            pbe.PriceBook2Id = Constants.STANDARD_PRICEBOOK_ID;
            pbe.UnitPrice = 100;
            pbList.add(pbe);
        }
     
        return pbList;
        //ToDo: Ensure this method returns a corresponding list of PricebookEntries records
        //  related to the provided Products
        //  with all the required fields populated
        //  and IsActive = true
        //  and belonging to the standard Pricebook
    }

    /**
     * @name CreateAccounts
     * @description Constructs a list of Account records for unit tests
    **/
    public static List<Account> ConstructAccounts(Integer cnt){
        List<Account> accList = new  List<Account>();
       for(Integer i=0;i<cnt;i++){
            Account ac=new Account();
            ac.Name = 'Account'+i;
            accList.add(ac);
        }
     
        return accList;
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Account records
        //  with all of the required fields populated.
    }

    /**
     * @name CreateContacts
     * @description Constructs a list of Contacxt records for unit tests
    **/
    public static List<Contact> ConstructContacts(Integer cnt, List<Account> accts){
         List<Contact> conList = new  List<Contact>();
        for(Integer i=0;i<cnt;i++){
            contact con=new contact();
            con.LastName = 'Contact'+i;
            con.AccountId = accts.get(i).id;
            conList.add(con);
        }
         return conList;
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Contact records
        //  related to the provided Accounts
        //  with all of the required fields populated.
    }

    /**
     * @name CreateOrders
     * @description Constructs a list of Order records for unit tests
    **/
    public static List<Order> ConstructOrders(Integer cnt, List<Account> accts){
        List<Order> ordList = new List<Order>();
        for(Integer i=0;i<cnt;i++){
            Order ord=new Order();
            ord.Name = 'Order'+i;
            ord.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
            ord.AccountId = accts.get(i).Id;
            ord.EffectiveDate = Date.Today();
            ord.Status = Constants.DRAFT_ORDER_STATUS;
            ordList.add(ord);
            
        }
        return ordList;
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Order records
        //  related to the provided Accounts
        //  with all of the required fields populated.
    }

    /**
     * @name CreateOrderItems
     * @description Constructs a list of OrderItem records for unit tests
    **/
    public static List<OrderItem> ConstructOrderItems(integer cnt, list<pricebookentry> pbes, list<order> ords){
          List<OrderItem> orditemList = new  List<OrderItem>();
           for(Integer i=0;i<cnt;i++){
            OrderItem oItem=new OrderItem();
            oItem.OrderId = ords.get(i).Id;
            oItem.PriceBookEntryId = pbes.get(i).Id;
            oItem.UnitPrice = 100;
            oItem.Quantity = i+1;
            orditemList.add(oItem);
        }

          return orditemList;
        //ToDo: Ensure this method returns a list of size cnt of OrderItem records
        //  related to the provided Pricebook Entries
        //  and related to the provided Orders
        //  with all of the required fields populated.
        //  Hint: Use the DEFAULT_ROWS constant for Quantity as it will be used in the next challenge
    }

    /**
     * @name SetupTestData
     * @description Inserts accounts, contacts, Products, PricebookEntries, Orders, and OrderItems.
    **/
    public static void InsertTestData(Integer cnt){
        CollaborationGroup ChatterGroup = ConstructCollaborationGroup(); 
        List<Account> accList  = ConstructAccounts(cnt);
        insert accList;
        List<Contact> conList =ConstructContacts(cnt,accList);
        insert conList;
        List<Order> ordList =ConstructOrders(cnt,accList);
        insert ordList;
        List<Product2> proList = ConstructProducts(cnt);
        insert proList;
        List<pricebookentry> pbList = ConstructPricebookEntries(proList);
        insert pbList;
        List<OrderItem> ordItemList = ConstructOrderItems(cnt, pbList,ordList);
        insert ordItemList;
        
        //ToDo: Ensure this method calls each of the construct methods
        //  and inserts the results for use as test data.

    }
    public static void VerifyQuantityOrdered(Product2 originalProduct, Product2 updatedProduct, Integer qtyOrdered){
        system.assertEquals(updatedProduct.Quantity_Ordered__c,originalProduct.Quantity_Ordered__c +qtyOrdered);
    }

}