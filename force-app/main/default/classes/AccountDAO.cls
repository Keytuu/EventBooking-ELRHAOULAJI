/**
 * Created by Kawtar 17/03/2022
 */

public class AccountDAO {


    public static List<Account> getListAccountByIDS(List<Id> AccountIds ){
    return [SELECT id,name, email FROM Contact WHERE AccountId in :AccountIds];
    }

    public static Map<ID, Account> getMapAccountByIDS(List<Id> accIds ){
    return new Map<ID, Account>([SELECT Id, Name, (SELECT Id FROM Contacts) FROM Account WHERE Id in :accIds]);
    }


    }

