public with sharing class CaseTriggerHelper{
    public static void checkReservation(List<Case> cases){

        List<ID> accIds = new List<Id>();
        for(Case r : cases){
            accIds.add(r.AccountId);
        }
        Map<ID, Account> accounts = AccountDAO.getMapAccountByIDS(accIds);
        for(Case r : cases){
            if(r != null && r.AccountId != null){
                Account account = accounts.get(r.AccountId);
                if(account != null){
                    Integer s = account.Contacts.size();
                    if(s == 0){
                        r.addError('You cannot create a request for accounts without contacts');
                    }
                    else {
                        switch on r.Origin {
                            when 'Web' {
                                if(s >= 2 ){
                                    r.addError('Web request are only allowed to have one attendee');
                                }
                            }
                            when 'Phone'{
                                if(s >= 4 ){
                                    r.addError('Phone request are only allowed to have three attendee');
                                }
                            }
                        }
                    }
                }
                else{
                    r.addError('Invalid account');
                }

            }else {
                r.addError('You cannot create a request without attaching an account');
            }
        }

    }

    public static void notifyForReservation(List<Case> updatedCases, Map<Id, Case> oldMap){
        List<Id> accountIds = new List<Id>();
        for(Case updatedCase : updatedCases){
            Case OldCase = oldMap.get(updatedCase.Id);
            if(OldCase.Status != 'Closed' && updatedCase.Status == 'Closed'){
                accountIds.add(updatedCase.AccountId);
            }
        }
        if(accountIds.size() > 0) ExternalSystemService.registerAttendees(accountIds);
    }
}