//////////////////////////////////////////
//
// Project0Banking Class
// Created By: Ian Blanchard
// Date: 30 Jan 2019
// Description: Methods that interact with the Banking 
//          Data Model/Org made for Project 0.
//
//////////////////////////////////////////


public with sharing class Project0Banking {

    //Constants for recordtype ID's, Account.status strings, and Transaction.Type strings
    private static final String SINGLE_ID = '0121U000000htsSQAQ';
    private static final String JOINT_ID = '0121U000000htsXQAQ';
    private static final String OVERDRAWN = 'Overdrawn';
    private static final String GOOD_STANDING = 'In Good Standing';
    private static final String DEPOSIT = 'Deposit';
    private static final String WITHDRAW = 'Withdrawal';

    //Account ID for an Account. Used for testing/demo
    public static final ID evanID = '0011U00000Ayo6hQAB';

    /* newTransaction(ID,String,Decimal)
     * Takes in an Account ID, a String representing Deposit or Withdrawal, and a Decimal dollar amount.
     * Creates and inserts a new Transaction to the Org for the Account
     * Upon completion, executes the updateAccount method
     */

    public static void newTransaction(ID aID, String type, Decimal amount){
        //SOQL query to pull the account associated with the ID passed in the parameters
        Account a = [SELECT id, name FROM Account WHERE id = :aID];

        //Create a new Transaction sObject associated with that account
        Transaction__c t = new Transaction__c(Name = a.Name + ' ' + type + ' of $' + amount,
                                              Amount__c = amount,
                                              Type__c = type,
                                              Account__c = a.id);

        //add the Transaction to the Org
        insert t;

        //Run the updateAccount method on the account
        updateAccount(aID);
    }

    /* updateAccount(ID)
     * Takes in an Account ID and verifies the Account balance by recalculating the Transactions
     * attached to the account.
     * Upon completion, runs the checkOverdrawn method
     */

    public static void updateAccount(ID aID){

        //Create a list of transactions, and a counter double variable to keep track of the running total for transaction amounts
        List<Transaction__c> trans = new List<Transaction__c>();
        double total = 0.0;

        //loop through all transactions tied to the account
        for (Transaction__c t: [SELECT id, Type__c, Amount__c FROM Transaction__c WHERE Account__r.id = :aID ]){
            //if the transaction is a deposit, add the amount to the total
            if (t.Type__c == DEPOSIT){
                total = total + t.Amount__c;
            }

            //if the transaction is a withdrawal, subtract the amount from the total
            if (t.Type__c == WITHDRAW){
                total = total - t.Amount__c;
            }

            //add the transaction to the list to be updated later
            trans.add(t);
        }

        //create an account sobject and query for the account from the method parameters
        Account acc = [SELECT id, name, AccountBalance__c, InitialBalance__c FROM Account WHERE Account.ID = :aID];
        
        //if the initial balance exists, set account balance to the total found above plus the initial balance
        if (acc.InitialBalance__c != null)
            acc.AccountBalance__c = total + acc.InitialBalance__c;

        /*the initial balance will be null if and only if this method was called by the NewAccount trigger
         *this else statement will account for this situation by using the current value of the AccountBalance__c
         *field instead
         */
        else
            acc.AccountBalance__c = total + acc.AccountBalance__c;
        

        //update transactions and the account on the org
        update trans;
        update acc;

        //run checkOverdrawn method
        checkOverdrawn();
    }

    /* checkOverdrawn()
     * Takes in no parameters. Checks all accounts balances, if they are negative or non-negative and sets the Account.Status
     * to Overdrawn or In Good Standing, respectively
     */

    public static void checkOverdrawn(){
        //Create a List of Accounts to receive accounts from SOQL call
        List<Account> accounts = new List<Account>();

        //SOQL query for all accounts
        for (Account a: [SELECT id, AccountBalance__c, Status__c FROM Account]){
            //If account balance is negative, set status to Overdrawn
            if (a.AccountBalance__c < 0){
                a.Status__c = OVERDRAWN;
            }
            //If account balance is zero or positive, set status to In Good Standing
            if (a.AccountBalance__c >= 0){
                a.Status__c = GOOD_STANDING;
            }
            //Add account to the list
            accounts.add(a);
        }

        //Update all accounts in the list on the org
        update accounts;
    }

    /* newAccount(String,String,String,String,Decimal)
     * Overloaded method.
     * Takes in a name, type, routing number, account number, and currency amount and creates and 
     * inserts a new Account record  with RecordType SINGLE with those values.
     * Upon completion, runs the checkOverdrawn method.
     */

    public static void newAccount(String aName,String aType, String rNum, String aNum, Decimal aBal){

        //Creates an Account sObject with the values from the method parameters and RecordType SINGLE
        Account a = new Account(Name = aName,
                                Type = aType,
                                RoutingNumber__c = rNum,
                                AccountNumber = aNum,
                                AccountBalance__c = aBal,
                                InitialBalance__c = aBal,
                                RecordTypeID = SINGLE_ID);

        //Insert account to the Org
        insert a;

        //Run checkOverdrawn method to set Account.status
        checkOverdrawn();
    }

    /* newAccount(String,String,String,String,String,String,Decimal)
     * Overloaded method.
     * Takes in a name, type, routing number, account number, and currency amount and creates and 
     * inserts a new Account record  with RecordType JOINT with those values.
     * Upon completion, runs the checkOverdrawn method.
     */

    public static void newAccount(String aName, String primary, String secondary, String aType, String rNum, String aNum, Decimal aBal){
        
        //Creates anAccount sObject with the values from the method parameters and RecordType JOINT
        Account a = new Account(Name = aName,
                                AccountHolder1__c = primary,
                                AccountHolder2__c = secondary,
                                Type = aType,
                                RoutingNumber__c = rNum,
                                AccountNumber = aNum,
                                AccountBalance__c = aBal,
                                InitialBalance__c = aBal,
                                RecordTypeID = JOINT_ID);

        //Insert account to the Org
        insert a;

        //Run checkOverdrawn method to set Account.status
        checkOverdrawn();
    }
}
