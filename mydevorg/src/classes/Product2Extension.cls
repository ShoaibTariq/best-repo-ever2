public class Product2Extension {

    public List<ProductWrapper> productsToInsert {get;set;}

    public Product2Extension(ApexPages.StandardController controller){
	    productsToInsert = new List<ProductWrapper>();
        addRows();
    }

    public void AddRows(){
        for ( Integer i=0; i<Constants.DEFAULT_ROWS; i++ ){
            productsToInsert.add( new ProductWrapper() );
        }
    }
    
    public List<SelectOption> GetFamilyOptions() {
       List<SelectOption> ProductFamliy = new List<SelectOption>();
       ProductFamliy.add(new SelectOption(Constants.SELECT_ONE, Constants.SELECT_ONE));
       for( PickListEntry  f : Constants.PRODUCT_FAMILY)
   		{
      		ProductFamliy.add(new SelectOption(f.getValue(), f.getLabel()));
   		}    
        return ProductFamliy;
    }

    public List<ChartHelper.ChartData> GetInventory(){
        return ChartHelper.GetInventory();
    }

    public PageReference Save(){
        Savepoint sp = Database.setSavepoint();
        try {
            List<Product2>    productList           = new List<Product2>();
            List<PriceBookEntry> PriceBookEntryList = new List<PriceBookEntry>();
            
            for(ProductWrapper wrap :productsToInsert) {
                if(wrap.productRecord.Name != null && wrap.productRecord.Family != Constants.SELECT_ONE
                   && wrap.productRecord.Initial_Inventory__c != null && wrap.pricebookEntryRecord.UnitPrice!= null
                   && wrap.productRecord.Family != null) {
                      productList.add(wrap.productRecord);
                      PriceBookEntryList.add(new PriceBookEntry(priceBook2Id =Constants.STANDARD_PRICEBOOK_ID,unitPrice =wrap.pricebookEntryRecord.UnitPrice));
                   }
            }
            insert productList;
            
            for(integer i=0;i<PriceBookEntryList.size();i++) {
               PriceBookEntryList[i].product2Id = productList[i].Id;
            }
            insert PriceBookEntryList;
            
            //If successful clear the list and display an informational message
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,productsToInsert.size()+' Inserted'));
            productsToInsert.clear();   //Do not remove
            addRows();  //Do not remove
        } catch (Exception e){
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,Constants.ERROR_MESSAGE));
			Database.rollback(sp);
        }
        return null;
    }
    
    public class ProductWrapper {
        public Product2 productRecord {get;set;}
        public PriceBookEntry pricebookEntryRecord  {get;set;}
        
        public ProductWrapper() {
            productRecord = new Product2();
            pricebookEntryRecord  = new PriceBookEntry();
        }
        
    }

}