trigger P0Banking on Transaction__c (after insert) {
    Transaction__c t = Trigger.new[0];
    for (Account a :[SELECT id, AccountRefNumber__c FROM Account WHERE id = :t.Account__c]){
        Project0Banking.updateAccount(a.AccountRefNumber__c);
    }
}