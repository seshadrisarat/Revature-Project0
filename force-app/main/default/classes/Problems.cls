public with sharing class Problems {
    public Problems() {
        
    }

    public static void problem6(){
        List<Account> accounts = new List<Account>();
        for (Account a : [SELECT id,RoutingNumber__c,AccountBalance__c,size__c,NumberOfEmployees FROM Account]){
            if (a.NumberOfEmployees > 0 && a.NumberOfEmployees <= 1000){
                a.Size__c = 'Small';
            } else  if (a.NumberOfEmployees > 1000 && a.NumberOfEmployees <= 10000){
               a.Size__c = 'Medium';
            } else if (a.NumberOfEmployees > 10000) {
               a.Size__c = 'Large';
            }
            accounts.add(a);
        }
        update accounts;

        System.debug(accounts);
    }
}