//////////////////////////////////////////
//
// NewAccount Trigger
// Created By: Ian Blanchard
// Date: 2 Feb 2019
// Description: Trigger for New Account creation
//
//////////////////////////////////////////

trigger NewAccount on Account (after insert) {
    //Store the account that set off the trigger
    Account a = Trigger.new[0];

    //run the updateAccount method on the account
    Project0Banking.updateAccount(a.ID);
}