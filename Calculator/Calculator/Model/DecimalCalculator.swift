//
//  DecimalCalculator.swift
//  Calculator
//
//  Created by Neph on 2021/03/23.
//
import Foundation

final class DecimalCalculator: Computable {
    
    static func add(firstNumber: String, secondNumber: String) -> String {
        do {
            let first = try formattedInput(of: firstNumber)
            let second = try formattedInput(of: secondNumber)
            let result = round(Double(first + second) * 1e9) / 1e9
            return try formattedResult(of: result)
        } catch {
            //FIXME: 에러 받으면? 어떻게 할건지
            return "-1"
        }
    }
    
    static func subtract(firstNumber: String, secondNumber: String) -> String {
        do {
            let first = try formattedInput(of: firstNumber)
            let second = try formattedInput(of: secondNumber)
            let result = round(Double(first - second) * 1e9) / 1e9
            return try formattedResult(of: result)
        } catch {
            return "-1"
        }
    }
    
    static func multiply(firstNumber: String, secondNumber: String) -> String {
        do {
            let first = try formattedInput(of: firstNumber)
            let second = try formattedInput(of: secondNumber)
            let result = round(Double(first * second) * 1e9) / 1e9
            return try formattedResult(of: result)
        } catch {
            return "-1"
        }
    }
    
    static func divide(firstNumber: String, secondNumber: String) -> String {
        
        do {
            let first = try formattedInput(of: firstNumber)
            let second = try formattedInput(of: secondNumber)
            let result = round(Double(first / second) * 1e9) / 1e9
            return try formattedResult(of: result)
        } catch {
            return "-1"
        }
        
    }
    
    static func formattedInput(of userInput: String) throws -> Double {
        guard let input = Double(userInput) else {
            throw CalculatorError.formatError
        }
        return input
    }
    
    static func formattedResult(of result: Double) throws -> String {
        var result = result
        
        if result >= 1e9 {
            result = result.truncatingRemainder(dividingBy: 1e9)
        }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 9
        
        guard let formattedResult = formatter.string(from: NSNumber(value: result)) else {
            throw CalculatorError.formatError
        }

        return formattedResult
    }
    
}
