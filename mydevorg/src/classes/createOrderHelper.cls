/**
 * Author: Creation Technology
 * Date: 18/09/2018
 * Description: 
 */
public class createOrderHelper {
    /**
     * [doesAccountExist -Check whether account already exist]
     * @param  extAccountId [External Id]
     * @return              [Boolean]
     */
    public static Boolean doesAccountExist(String extAccountId) {
        return [SELECT Id,companyid__c 
                   From Account 
                   WHERE companyid__c =:extAccountId].size()== 1? true : false;
    }
    /**
     * [doesAccountExist -Check whether contact already exist]
     * @param  extAccountId [External Id]
     * @return              [Boolean]
     */
    public static Boolean doesContactExist(String extContactId) {
        return [SELECT Id,WorkUserId__c 
                   From Contact 
                   WHERE WorkUserId__c =:extContactId].size()== 1? true : false;
    }
    /**
     * [getAccount -return an account to be linked to opportunity]
     * @param  extContactId [External Id]
     * @return              [Account]
     */
    public static Account getAccount(String extContactId) {
        return [SELECT Id
                   From Account 
                   WHERE companyid__c =:extContactId];
    }
    /**
     * [getAccount -return an Contact to be linked to opportunity]
     * @param  extContactId [External Id]
     * @return              [Contact]
     */
    public static Contact getContact(String extContactId) {
        return [SELECT Id
                   From Contact 
                   WHERE WorkUserId__c =:extContactId];
    }
}