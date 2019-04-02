@isTest public class ExercisesTest{

    @isTest static void isTest(){

        System.assertEquals(ApexP0Exercises.nFibonacci(0),0);
        System.assertEquals(ApexP0Exercises.nFibonacci(1),1);
        System.assertEquals(ApexP0Exercises.nFibonacci(2),1);
        System.assertEquals(ApexP0Exercises.nFibonacci(10),55);


        List<Integer> test = new List<Integer>{1,1,2,3,4,5};
        System.assertEquals(ApexP0Exercises.sortArray(new List<Integer>{2,4,5,1,3,1}),test);
        test = new List<Integer>{1,2,3,4,5};
        System.assertEquals(ApexP0Exercises.sortArray(new List<Integer>{5,4,3,2,1}),test);
        

        System.assertEquals(ApexP0Exercises.nFactorial(0),1);
        System.assertEquals(ApexP0Exercises.nFactorial(1),1);
        System.assertEquals(ApexP0Exercises.nFactorial(3),6);

        test = new List<Integer>{2,3,4,5,1};
        System.assertEquals(ApexP0Exercises.rotateLeftNTimes(new List<Integer>{1,2,3,4,5},1),test);
        test = new List<Integer>{2,3,4,5,1};
        System.assertEquals(ApexP0Exercises.rotateLeftNTimes(new List<Integer>{1,2,3,4,5},6),test);
        test = new List<Integer>{4,5,1,2,3};
        System.assertEquals(ApexP0Exercises.rotateLeftNTimes(new List<Integer>{1,2,3,4,5},3),test);


        System.assertEquals(ApexP0Exercises.bracketsAreBalanced('()'),true);
        System.assertEquals(ApexP0Exercises.bracketsAreBalanced('()()'),true);
        System.assertEquals(ApexP0Exercises.bracketsAreBalanced('(())'),true);
        System.assertEquals(ApexP0Exercises.bracketsAreBalanced('({[]})'),true);
        System.assertEquals(ApexP0Exercises.bracketsAreBalanced('('),false);
        System.assertEquals(ApexP0Exercises.bracketsAreBalanced(')'),false);
        System.assertEquals(ApexP0Exercises.bracketsAreBalanced('(()'),false);
        System.assertEquals(ApexP0Exercises.bracketsAreBalanced('([)]'),false);

    }

}