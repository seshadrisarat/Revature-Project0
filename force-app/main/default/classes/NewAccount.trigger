trigger NewAccount on Account (after insert) {
    Account a = Trigger.new[0];
    Project0Banking.updateAccount(a.ID);
}