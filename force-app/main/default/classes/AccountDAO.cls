/**
 * Created by Kawtar 17/03/2022
 */

public  class AccountDAO {

    
    
    /**
     * 
     */
    public List<Account> getAccountsByCase(Case case){

        return [SELECT id FROM Account where id = : case.AccountId)];
    }

    public Account getContactByAccount(Account account){
        return [SELECT id,name, email FROM Contact where accountid =: account.id ];
    }

