//////////////////////////////////////////
//
// ApexP0Exercises
// Created By: Ian Blanchard
// Date: 30 Jan 2019
// Description: Solutions to the exercises 
//          connected to Project 0.
//
/////////////////////////////////////////////


public with sharing class Project0Banking {

    private static final String singleID = '0121U000000htsSQAQ';
    private static final String jointID = '0121U000000htsXQAQ';

    public static void newTransaction(String ref, String type, Decimal amount){

        Account a = [SELECT id, name FROM Account WHERE AccountRefNumber__c = :ref];

        Transaction__c t = new Transaction__c(Name = a.Name + ' ' + type + ' of $' + amount,
                                              Amount__c = amount,
                                              Type__c = type,
                                              Account__c = a.id);
        insert t;
        updateAccount(ref);
    }

    public static void updateAccount(String ref){
        List<Transaction__c> trans = new List<Transaction__c>();
        double total = 0.0;

        for (Transaction__c t: [SELECT id, Type__c, Amount__c FROM Transaction__c WHERE Account__r.AccountRefNumber__c = :ref ]){
            if (t.Type__c == 'Deposit'){
                total = total + t.Amount__c;
            }
            if (t.Type__c == 'Withdrawal'){
                total = total - t.Amount__c;
            }
            trans.add(t);
        }

        
        Account acc = [SELECT id, name, AccountBalance__c, InitialBalance__c FROM Account WHERE Account.AccountRefNumber__c = :ref];
        acc.AccountBalance__c = total + acc.InitialBalance__c;

        update trans;
        update acc;
        checkOverdrawn();
    }

    public static void checkOverdrawn(){
        List<Account> accounts = new List<Account>();

        for (Account a: [SELECT id, AccountBalance__c, Status__c FROM Account]){
            if (a.AccountBalance__c < 0){
                a.Status__c = 'Overdrawn';
            }
            if (a.AccountBalance__c >= 0){
                a.Status__c = 'In Good Standing';
            }
            accounts.add(a);
        }

        update accounts;
    }

    public static void newAccount(String aName,String aType, String rNum, String aNum, Decimal aBal){
        Account a = new Account(Name = aName,
                                Type = aType,
                                RoutingNumber__c = rNum,
                                AccountNumber = aNum,
                                AccountBalance__c = aBal,
                                InitialBalance__c = aBal,
                                RecordTypeID = singleID);
        
        insert a;
        checkOverdrawn();
    }

    public static void newAccount(String aName, String primary, String secondary, String aType, String rNum, String aNum, Decimal aBal){
        Account a = new Account(Name = aName,
                                AccountHolder1__c = primary,
                                AccountHolder2__c = secondary,
                                Type = aType,
                                RoutingNumber__c = rNum,
                                AccountNumber = aNum,
                                AccountBalance__c = aBal,
                                InitialBalance__c = aBal,
                                RecordTypeID = jointID);
        insert a;
        checkOverdrawn();
    }
}
