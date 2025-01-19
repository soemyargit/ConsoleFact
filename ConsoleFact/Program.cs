using System;

class Program
{
    public static string? strFactText = string.Empty;    
    static void Main()
    {
        Console.WriteLine("Please enter a number for factorial!"); 
        // here need to check empty , string or digit
        string strNumber = Console.ReadLine();
        strFactText = strNumber.ToString() + "! = " + strNumber.ToString();
        int number = int.Parse(strNumber);

        Console.WriteLine($"Factorial of {number} is {Factorial(number)}");
        Console.WriteLine(strFactText);
        Console.ReadLine();
    }

    static int Factorial(int n)
    {
        
        // Base case: factorial of 0 or 1 is 1
        if (n == 0 || n == 1)
        {
            return 1;
        }
        // Recursive case: n! = n * (n-1)!
        else
        {
            int num = n - 1;
            strFactText += "X" + num.ToString();            
            return n * Factorial(n - 1);
        }

        





    }
}
