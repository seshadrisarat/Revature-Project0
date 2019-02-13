//////////////////////////////////////////
//
// NewTransaction Trigger
// Created By: Ian Blanchard
// Date: 2 Feb 2019
// Description: Trigger for New Transaction Creation
//
//////////////////////////////////////////

trigger NewTransaction on Transaction__c (after insert) {
    //store the Transaction that set the trigger
    Transaction__c t = Trigger.new[0];

    //Run the updateAccount method on the Account associated with the transaction
    Project0Banking.updateAccount(t.Account__c);
}