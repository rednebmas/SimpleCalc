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

func stringToInt(incoming:String) -> Int?
{
    return Int(incoming)
}

func getNumberFromInput() -> Int
{
    var numInt : Int? = nil
    while numInt == nil
    {
        let numString = input()
        numInt = stringToInt(numString)
        if numInt == nil
        {
            print("Not a number, try again")
        }
    }
    
    return numInt!
}

/****************************/
/*** Arithmetic functions ***/
/****************************/

func add(firstNumber:Int)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber + secondNumber)")
}

func subtract(firstNumber:Int)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber - secondNumber)")
}

func multiply(firstNumber:Int)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber * secondNumber)")
}

func divide(firstNumber:Int)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber / secondNumber)")
}

func mod(firstNumber:Int)
{
    let secondNumber = getNumberFromInput()
    print("= \(firstNumber % secondNumber)")
}

func factRecursive(number:Int) -> Int
{
    if number < 0
    {
        print("Factorial is not defined for negative integers")
    }
    
    // 0 factorial = 1
    if number < 2
    {
        return 1
    }
    
    return number * factRecursive(number - 1)
}

func average(numbers:[Int]) -> Int
{
    var sum = 0
    for number in numbers
    {
        sum += number
    }
    return sum / numbers.count
}

/**********************************/
/*** Start of program execution ***/
/**********************************/

print("Enter an expression seperated by returns")
let firstInput = getNumberFromInput()
let secondInput = input()
let secondInputIntOpt = stringToInt(secondInput)

// if the second input is a number, we just want to collect numbers until we reach an operation
// otherwise we want to apply the operation to the next input number
if secondInputIntOpt == nil
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
            print("\(factRecursive(firstInput))")
        default:
            print("Operator not supported, exiting.")
    }
}
else
{
    // begin accumulating numbers
    var numbers = [Int]()
    numbers.append(firstInput)
                
    while true
    {
        let inputString = input()
        let inputInt = stringToInt(inputString)
        if inputInt == nil
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
            numbers.append(inputInt!)
        }
    }
}
