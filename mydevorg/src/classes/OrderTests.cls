@isTest (SeeAllData=false)
private class OrderTests {
    @testSetup
    public static void SetupTestData() {
		TestDataFactory.InsertTestData(5);        
    }
    static testMethod void  OrderUpdate_UnitTest(){
        Order ord        = [Select Id,Name from Order Where Name ='Order1'];
        OrderItem ordItm = [Select Id,PriceBookEntryId From OrderItem Where orderId =: ord.Id];
        Id prd           = [Select Id,product2Id from PriceBookEntry where Id =:ordItm.PriceBookEntryId].product2Id;
        Product2 prod    = [Select Id,Quantity_Ordered__c from Product2 Where Id =:prd];
       
        ord.Status    =Constants.ACTIVATED_ORDER_STATUS;
        test.startTest();
        update ord;
        OrderItem ordItm2 = [Select Id,PriceBookEntryId From OrderItem Where orderId =: ord.Id];
        Id prd2           = [Select Id,product2Id from PriceBookEntry where Id =:ordItm2.PriceBookEntryId].product2Id;
        Product2 prod2   = [Select Id,Quantity_Ordered__c from Product2 Where Id =:prd2];
        TestDataFactory.VerifyQuantityOrdered(prod,prod2,2);
        test.stopTest();
        
    }
    @isTest static void OrderExtension_UnitTest() {
        PageReference pageRef = Page.OrderEdit;
        Test.setCurrentPage(pageRef);
        Order ord        = [Select Id,Name from Order Where Name ='Order1' LIMIT 1];
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(ord);        
        OrderExtension ext = new OrderExtension(stdcontroller);        
       	System.assertEquals(Constants.DEFAULT_ROWS, ext.orderItemList.size());
        ext.OnFieldChange();
        ext.SelectFamily();
        ext.Save();
        ext.First();
        ext.Next();
        ext.Previous();
        ext.Last();
        ext.GetHasPrevious();
        ext.GetHasNext();
        ext.GetTotalPages();
        ext.GetPageNumber();
        List<SelectOption> options = ext.GetFamilyOptions();
    }
}