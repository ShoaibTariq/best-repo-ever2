/**
 * Author: Creation Technology
 * Date: 18/09/2018
 * Description: 
 */
global  class CreateOrderParser {
    public cls_opportunity opportunity;
	public cls_billto billto;
	public cls_account account;
	public cls_contact contact;
	public class cls_opportunity {
		public String transactionid;	//133232
		public String orderid;	//45454
		public String amount;	//2000
		public String currencs;	//GBP
		public String companyid;	//35434343
		public String companyname;	//X-Men
		public String licenses;	//5
		public cls_product product;
	}
	public class cls_product {
	}
	public class cls_billto {
		public String name;	//Professor X
		public String address;	//1407 Graymalkin Lane
		public String state;	//New York
		public String city;	//North Salem
		public String postcode;	//10560
	}
	public class cls_account {
		public String companyid;	//35434343
		public String name;	//X-Men
		public String address;	//1407 Graymalkin Lane
		public String state;	//New York
		public String city;	//North Salem
		public String postcode;	//10560
		public String country;	//America
	}
	public class cls_contact {
		public String workuserid;	//434343
		public String salutation;	//Mr
		public String firstname;	//Charles
		public String lastname;	//Xavier
		public String jobtitle;	//Head X-Man
		public String address;	//1407 Graymalkin Lane
		public String state;	//New York
		public String city;	//North Salem
		public String postcode;	//10560
		public String telephone;	//134434343
		public String country;	//America
	}
}