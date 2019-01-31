//////////////////////////////////////////
//
// ApexP0Exercises
// Created By: Ian Blanchard
// Date: 30 Jan 2019
// Description: Solutions to the exercises 
//          connected to Project 0.
//
///////////////////////////////////////////jdfkljdflkkldkekidlndaskljadfslkadfskl


public with sharing class ApexP0Exercises {

    /*
     * 1. Return the nth Fibonacci number
     * Test Cases:
     * Input: 0 	Output: 0
     * Input: 1 	Output: 1
     * Input: 2 	Output: 1
     * Input: 10	Output: 55
     */

    public static Integer nFibonacci(Integer n){
        //Recursion base case: returns 0 when n reaches 0, and return 1 when n = 1
        if (n <= 0){
            return 0;
        } else if (n == 1){
            return 1;
        } else {
            //Recursively calls for the previous two fibonacci numbers
            return nFibonacci(n-1) + nFibonacci(n-2);
        }
    }

    /*
     * 2. Sort an array of integers.
     * Test Cases: 
     * Input: [2,4,5,1,3,1] 	Output: [1,1,2,3,4,5]
     * Input: [5,4,3,2,1] 	    Output: [1,2,3,4,5]
     *
     * Don't use the sort() method... that would be lame.
     */

    public static Integer[] sortArray(Integer[] intList){
        //Store the length of the list
        Integer len = intList.size();

        //Nested for loops check progressively smaller sections of the list to sort.
        //After first pass through the list, the last integer is correctly placed at the end.
        //After the second pass, the second to last integer is correctly placed, and so on.
        for (Integer i = 0; i < len; i++){
            for (Integer j = 0; j < len - i - 1; j++){
                //Check if the current item in the list is greater than the one after it. If it is, swap them.
                if (intList[j] > intList[j + 1]){
                    //use temp to hold one value so that the two can be swapped without loss
                    Integer temp = intList[j];
                    intList[j] = intList[j+1];
                    intList[j+1] = temp;
                }
            }
        }

        //Return sorted list
        return intList;
    }

    /*
     * 3. Return the factorial of n.
     * Test Cases: 
     * Input: 0	Output: 1 
     * Input: 1	Output: 1 
     * Input: 3	Output: 6
     */

    public static Integer nFactorial(Integer n){
        //If n is 0 or 1, the answer is 1. For loop would not work properly if these values were allowed to go through it/
        if (n <= 1){
            return 1;
        }

        Integer result = n;
        //Iteratively multiplies by decreasing integers down to but not including the integer 1, since this
        //would not affect the result, anyway.
        for (Integer i = n - 1; i > 1; i--){
            result = result * i;
        }
        return result;
    }

    /*
     * 4. Rotate left
     * Given an array, array, and an integer, n, rotate the values in array left n times and return array
     * Test Cases:
     * Input: [1,2,3,4,5], 1	Output: [2,3,4,5,1]
     * Input: [1,2,3,4,5], 6	Output: [2,3,4,5,1]
     * Input: [1,2,3,4,5], 3	Output: [4,5,1,2,3]
     */

    public static Integer[] rotateLeftNTimes(Integer[] nList, Integer n){
        //Create new list to store integers in as their new positions are found
        List<Integer> newList = new List<Integer>(nList.size());

        //Cycle through all positions to find their new position one at a time
        for (Integer i = 0; i < nList.size(); i++){
            //create a temporary integer to hold the original position to be manipulated
            Integer temp = i;

            //subtract the intended number of moves from the position to find (potentially) its new position
            //Potentially because if it is negative, it will have to be adjusted in the while loop below.
            temp = temp - n;

            //If the new position is negative, add the list size until it becomes a positive number
            while (temp < 0){
                temp = temp + nList.size();
            }

            //Put the integer in its new position in the new list
            newList[temp] = nList[i];
        }

        return newList;
    }

    /*
     * 5. Balanced Brackets
     * A bracket is any one of the following: (, ), {, }, [, or ]
     * 
     * The following are balanced brackets:
     *    ( )
     *    ( ) ( )
     *    ( ( ) )
     *    ( { [ ] } )
     *
     * The following are NOT balanced brackets:
     *   (
     *   )
     *   ( ( )
     *   ( [ ) ]
     *
     * Return true if balanced
     * Return false if not balanced
     */

    public static Boolean bracketsAreBalanced(String s){
        List<Integer> brackets = new List<Integer>(s.length()+2);
        Integer i = 0;

        for (Integer j = 0; j < s.length(); j++){
            switch on s.charAt(j){
                //When next character is ( { or [
                when 40, 91, 123 {
                    brackets[i] = s.charAt(j);
                    i++;
                }
                //When next character is )
                when 41 {
                    //if list is empty, ) has no (, so terminate. It is not balanced.
                    if (i <= 0){
                        return false;
                    }
                    //If the preceding character was (, remove it as they are balanced.
                    if (brackets[i - 1] == 40){
                        i--;
                        brackets[i] = null;
                    } else {
                        //If its anything else, it is not balanced. Terminate.
                        return false;
                    }
                }
                //When next character is ]
                when 93 {
                    //if list is empty, ] has no [, so terminate. It is not balanced.
                    if (i <= 0){
                        return false;
                    }
                    //If the preceding character was [, remove it as they are balanced.
                    if (brackets[i - 1] == 91){
                        i--;
                        brackets[i] = null;
                    } else {
                        //If its anything else, it is not balanced. Terminate.
                        return false;
                    }
                }
                //When next character is }
                when 125 {
                    //if list is empty, } has no {, so terminate. It is not balanced.
                    if (i <= 0){
                        return false;
                    }
                    //If the preceding character was {, remove it as they are balanced.
                    if (brackets[i - 1] == 123){
                        i--;
                        brackets[i] = null;
                    } else {
                        //If its anything else, it is not balanced. Terminate.
                        return false;
                    }
                }
            }
        }
        //Last check to make sure the list is now empty
        if (i > 0){
            return false;
        }
        return true;
    }

    /* 
     * 6. Create a method that retrieves a list of all accounts and updates those accounts.
     *    Create a custom field on the Account standard object called Size__c that will be a 
     *        picklist containing small/medium/large.
     *    Create a method that retrieves a list of all accounts. 
     * 	        - If an account has between 1-1000 employees then it is classified as small.
     * 	        - If an account has between 1001-10000 employees it is classified as medium.
     * 	        - If an account has more than 10000 employees it is classified as large.
     *    Update the Size__c field on each account to reflect the amount of employees in the Account.
     */

    public static void updateAccountSize(){
        //create a list to put all accounts into
        List<Account> accounts = new List<Account>();

        //load the list with all the accounts
        for (Account a : [SELECT id, size__c, NumberOfEmployees FROM Account]){
            //if number of employees falls within 0 and 1000, it is Small
            if (a.NumberOfEmployees > 0 && a.NumberOfEmployees <= 1000){
                a.Size__c = 'Small';

            //if number of employees falls within 1000 and 10000, it is Medium
            } else  if (a.NumberOfEmployees > 1000 && a.NumberOfEmployees <= 10000){
               a.Size__c = 'Medium';

            //if number of employees is over 10000, it is Large
            } else if (a.NumberOfEmployees > 10000) {
               a.Size__c = 'Large';
            }
            //append account to the list
            accounts.add(a);
        }

        //update the accounts on the org with new Size__c values
        update accounts;
    }

    /* 
     * 7. Create a method that will find all leads that contain 'ca' in their fields. 
     * 	If a lead is located in California(CA), change their Lead Status field to 'Closed - Not 
     *  Converted' and their description should display the message, "We are no longer doing 
     *  business in California."
     */

    public static void updateCALeads(){
        List<Lead> leads = new List<Lead>();

        //Get all leads from California
        for (Lead l : [SELECT Id, status, description, address FROM Lead WHERE state = 'CA']){
            //Change CA Leads to Closed status and change description to explain why they are being closed
            l.status = 'Closed - Not Converted';
            l.description = 'We are no longer doing business in California';

            //add leads to the list to be updated later
            leads.add(l);
        }

        //Send updates to the leads on org
        update leads;
    }

    /*
     * 8. Create a method that will find all Opportunities which have already passed their Close Date 
     * and have a Stage field that is not 'Closed Won'. Since they have passed their Close Date and 
     * they are not marked as 'Closed Won', they should be marked as 'Closed Lost'.
     */

    public static void closePastDueOpportunities(){
        List<Opportunity> opps = new List<Opportunity>();

        //set variable for today's date
        Date today = Date.today();

        //get all Opportunities not Closed Won
        for (Opportunity o: [SELECT id, stagename, closedate FROM Opportunity WHERE stagename != 'Closed Won']){
            //If the closed date was in the past, mark the opportunity closed lost
            if (o.closedate < today){
                o.stagename = 'Closed Lost';
            }

            //add opportunity to the list to be updated later
            opps.add(o);
        }
        
        //Update the Opportunities in the Org
        update opps;
    }
}
