//
//  BinaryCalculatorTests.swift
//  CalculatorTests
//
//  Created by 천수현 on 2021/03/29.
//

import XCTest

class BinaryCalculatorTests: XCTestCase {
    private var binaryCalculatorTest: BinaryCalculator?
    
    override func setUpWithError() throws {
        binaryCalculatorTest = BinaryCalculator()
    }

    override func tearDownWithError() throws {
        binaryCalculatorTest = nil
    }

    func test_add() {
        let result1 = binaryCalculatorTest?.add(firstNumber: 1, secondNumber: 2)
        XCTAssertEqual(result1, 3)

        let result2 = binaryCalculatorTest?.add(firstNumber: 100, secondNumber: 12)
        XCTAssertEqual(result2, 112)
    }

    func test_subtract() {
        let result1 = binaryCalculatorTest?.subtract(firstNumber: 1, secondNumber: 2)
        XCTAssertEqual(result1, -1)

        let result2 = binaryCalculatorTest?.subtract(firstNumber: 100, secondNumber: 12)
        XCTAssertEqual(result2, 88)
    }

    func test_AND() {
        let result1 = binaryCalculatorTest?.AND(firstNumber: 8, secondNumber: 7)
        XCTAssertEqual(result1, 0)

        let result2 = binaryCalculatorTest?.AND(firstNumber: 8, secondNumber: 9)
        XCTAssertEqual(result2, 8)
    }

    func test_NAND() {
        let result1 = binaryCalculatorTest?.NAND(firstNumber: 8, secondNumber: Int.max)
        XCTAssertEqual(result1, -9)
        
        let result2 = binaryCalculatorTest?.NAND(firstNumber: 13, secondNumber: Int.max)
        XCTAssertEqual(result2, -14)
    }

    func test_OR() {
        let result1 = binaryCalculatorTest?.OR(firstNumber: 8, secondNumber: 7)
        XCTAssertEqual(result1, 15)
        
        let result2 = binaryCalculatorTest?.OR(firstNumber: 0, secondNumber: 11)
        XCTAssertEqual(result2, 11)
    }

    func test_NOR() {
        let result1 = binaryCalculatorTest?.NOR(firstNumber: 8, secondNumber: 7)
        XCTAssertEqual(result1, -16)
        
        let result2 = binaryCalculatorTest?.NOR(firstNumber: 0, secondNumber: 11)
        XCTAssertEqual(result2, -12)
        
        let result3 = binaryCalculatorTest?.NOR(firstNumber: -8, secondNumber: -7)
        XCTAssertEqual(result3, 6)
    }

    func test_XOR() {
        let result1 = binaryCalculatorTest?.XOR(firstNumber: 8, secondNumber: 7)
        XCTAssertEqual(result1, 15)
        
        let result2 = binaryCalculatorTest?.XOR(firstNumber: 0, secondNumber: 130)
        XCTAssertEqual(result2, 130)
        
        let result3 = binaryCalculatorTest?.XOR(firstNumber: -8, secondNumber: -7)
        XCTAssertEqual(result3, 1)
    }

    func test_NOT() {
        let result1 = binaryCalculatorTest?.NOT(firstNumber: -1)
        XCTAssertEqual(result1, 0)
        
        let result2 = binaryCalculatorTest?.NOT(firstNumber: 8)
        XCTAssertEqual(result2, -9)
    }

    func test_shiftLeft() {
        let result1 = binaryCalculatorTest?.shiftLeft(firstNumber: 8, secondNumber: 2)
        XCTAssertEqual(result1, 32)
        
        let result2 = binaryCalculatorTest?.shiftLeft(firstNumber: 0, secondNumber: 2)
        XCTAssertEqual(result2, 0)
        
        // 부호를 유지한 채로 bit shift 진행 (shift logically)
        let result3 = binaryCalculatorTest?.shiftLeft(firstNumber: -8, secondNumber: 2)
        XCTAssertEqual(result3, -32)
    }

    func test_shiftRight() {
        let result1 = binaryCalculatorTest?.shiftRight(firstNumber: 8, secondNumber: 2)
        XCTAssertEqual(result1, 2)
        
        let result2 = binaryCalculatorTest?.shiftRight(firstNumber: 0, secondNumber: 2)
        XCTAssertEqual(result2, 0)
        
        // 부호를 유지한 채로 bit shift 진행 (shift logically)
        let result3 = binaryCalculatorTest?.shiftRight(firstNumber: -8, secondNumber: 2)
        XCTAssertEqual(result3, -2)
    }
    
    func test_formatInput() {
        let result1 = try? binaryCalculatorTest?.formatInput("1010")
        XCTAssertEqual(result1, 10)
    }
    
    func test_formatResult() {
        let result1 = try? binaryCalculatorTest?.formatResult(of: -1)
        XCTAssertEqual(result1, "11111111")
        
        // MSB(8개의 비트 중 가장 왼쪽의 비트)를 Sign-Bit로 사용
        let result2 = try? binaryCalculatorTest?.formatResult(of: -128)
        XCTAssertEqual(result2, "10000000")
        
        let result3 = try? binaryCalculatorTest?.formatResult(of: -13)
        XCTAssertEqual(result3, "11110011")
        
        let result4 = try? binaryCalculatorTest?.formatResult(of: 18)
        XCTAssertEqual(result4, "10010")
        
        // 양수의 최대 표현범위는 127까지이므로 그 이상의 입력이 들어오면 error를 throw
        XCTAssertThrowsError(try binaryCalculatorTest?.formatResult(of: 1023)) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.outOfRangeInput)
        }
    }

    func test_reset() {
        binaryCalculatorTest?.reset()
        XCTAssertTrue(binaryCalculatorTest?.stack.isEmpty == true)
    }
}
