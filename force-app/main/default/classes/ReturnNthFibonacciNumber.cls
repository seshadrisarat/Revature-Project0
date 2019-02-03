public class ReturnNthFibonacciNumber
{
    // This method returns the 'nTH' Fibonacci of any number you input.

    public static Integer nFibonacci(Integer nTH)
    {
        // If 'nTH' number is less than or equal to 1, return just that input value passed through.
        // Otherwise, if any 'nTH' number is greater than 1, calculate and return the Fibonacci
        // number for that input value passed through.

        if (nTH <= 0)
        {
            system.debug('Input: ' + nTH + '     ' + 'Output: ' + nTH);
            return nTH;
        }

        if (nTH == 1)
        {
            system.debug('Input: ' + nTH + '     ' + 'Output: ' + nTH);
            return nTH;
        }

        else
        {
            system.debug('Input: ' + nTH + '     ' + 'Output: ' + nTH);
            return nFibonacci(nTH - 1) + nFibonacci(nTH - 2);
        }
    }
}