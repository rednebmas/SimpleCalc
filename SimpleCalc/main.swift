//
//  main.swift
//  SimpleCalc
//
//  Created by Sam Bender on 10/8/15.
//  Copyright © 2015 Sam Bender. All rights reserved.
//

import Foundation

func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData,
    encoding:NSUTF8StringEncoding) as! String
    return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

func stringToDouble(incoming:String) -> Double?
{
    return Double(incoming)
}

func getNumberFromInput() -> Double
{
    var numDouble : Double? = nil
    while numDouble == nil
    {
        let numString = input()
        numDouble = stringToDouble(numString)
        if numDouble == nil
        {
            print("Not a number, try again")
        }
    }
    
    return numDouble!
}

/****************************/
/*** Arithmetic functions ***/
/****************************/

func add(firstNumber:Double)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber + secondNumber)")
}

func subtract(firstNumber:Double)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber - secondNumber)")
}

func multiply(firstNumber:Double)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber * secondNumber)")
}

func divide(firstNumber:Double)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber / secondNumber)")
}

func mod(firstNumber:Double)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber % secondNumber)")
}

func fact(number:Double)
{
    if number < 0 || floor(number) != number
    {
        print("Factorial is not defined for non-natural numbers")
        return
    }

    let result = factRecursive(number)
    print("= \(result)")
}

func factRecursive(number:Double) -> Double
{

    
    // remember:  0! = 1
    if number < 2
    {
        return 1
    }
    
    return number * factRecursive(number - 1)
}

func average(numbers:[Double]) -> Double
{
    var sum = 0.0
    for number in numbers
    {
        sum += number
    }
    return sum / Double(numbers.count)
}

/**********************************/
/*** Start of program execution ***/
/**********************************/

print("SimpleCalc by Sam Bender")
print("Implements extra credit opportunity for decimal values")
print("Enter an expression seperated by returns:")
let firstInput = getNumberFromInput()
let secondInput = input()
let secondInputDoubleOpt = stringToDouble(secondInput)

// if the second input is a number, we just want to collect numbers until we reach an operation
// otherwise we want to apply the operation to the next input number
if secondInputDoubleOpt == nil
{
    switch secondInput
    {
        case let operation where operation == "+" || operation == "add":
            add(firstInput)
        case let operation where operation == "-" || operation == "sub":
            subtract(firstInput)
        case let operation where operation == "*" || operation == "mul":
            multiply(firstInput)
        case let operation where operation == "/" || operation == "div":
            divide(firstInput)
        case let operation where operation == "%" || operation == "mod":
            mod(firstInput)
        case let operation where operation == "!" || operation == "fact":
            fact(firstInput)
        default:
            print("Operator not supported, exiting.")
    }
}
else
{
    // begin accumulating numbers
    var numbers = [Double]()
    numbers.append(firstInput)
    numbers.append(secondInputDoubleOpt!)
                
    while true
    {
        let inputString = input()
        let inputDouble = stringToDouble(inputString)
        if inputDouble == nil
        {
            switch inputString
            {
                case let operation where operation == "count":
                    print("count = \(numbers.count)")
                case let operation where operation == "avg":
                    print("avg = \(average(numbers))")
                default:
                    print("Operator not supported, exiting")
            }
                    
            break
        }
        else
        {
            numbers.append(inputDouble!)
        }
    }
}
