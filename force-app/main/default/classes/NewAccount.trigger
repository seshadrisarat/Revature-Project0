//////////////////////////////////////////
//
// NewAccount Trigger
// Created By: Ian Blanchard
// Date: 2 Feb 2019
// Description: Trigger for New Account creation
// Rename
//////////////////////////////////////////

trigger NewAccount on Account (after insert) {
    //Store the account that set off the trigger
    Account a = Trigger.new[0];

    //If the account is created with a positive, nonzero initial balance, generate a new Deposit transaction for that amount
    if (a.AccountBalance__c > 0)
        Project0Banking.newTransaction(a.ID,'Deposit',a.AccountBalance__c);

    //if the account is created with a negative, nonzero initial balance (which shouldnt be possible but still needs
    //to be accounted for), generate a new Withdrawal transaction for that amount
    if (a.AccountBalance__c < 0)
        Project0Banking.newTransaction(a.ID,'Withdrawal',a.AccountBalance__c);

    //If the account is created with no initial balance, run updateAccount on the method
    if (a.AccountBalance__c == 0)
        Project0Banking.updateAccount(a.ID);
}