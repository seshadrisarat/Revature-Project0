trigger NewTransaction on Transaction__c (after insert) {
    Transaction__c t = Trigger.new[0];
    Project0Banking.updateAccount(t.Account__c);
}