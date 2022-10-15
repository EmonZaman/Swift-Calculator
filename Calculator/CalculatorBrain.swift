//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Aagontuk on 10/15/22.
//

import Foundation
func changedSign(operand: Double) -> Double{
    return -operand
}
func multiply(op1: Double, op2: Double) -> Double
{
    return op1 * op2
    
}
struct CalculatorBrain{
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOpertions((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> =
    [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation(changedSign),
        //"*": Operation.binaryOpertions({(op1, op2) in return op1 * op2}), // we can write this
       // "*": Operation.binaryOpertions({(op1, op2) in  op1 * op2}), we can write this also
        "*": Operation.binaryOpertions({ $0 * $1 }),
        "÷": Operation.binaryOpertions({ $0 / $1 }),
        "-": Operation.binaryOpertions({ $0 - $1 }),
        "+": Operation.binaryOpertions({ $0 + $1 }),
        "=": Operation.equals
    
    ]
    
    mutating func performOperation(_ symbole: String){
        if let operation = operations[symbole]{
            switch operation {
            case .constant(let value):
                accumulator = value
                break
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOpertions(let function):
                if accumulator != nil{
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                
                break
            case .equals:
                performPendingBinaryOperation()
            
            }
            
            
        }
//        switch symbole{
//        case "π":
//            accumulator = Double.pi
//        case "√":
//            if let operand = accumulator{
//                accumulator = sqrt(operand)
//            }
//        default:
//            break
//
//        }
//
    }
    private mutating func performPendingBinaryOperation(){
        if pbo != nil && accumulator != nil{
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    private var pbo: PendingBinaryOperation!
    
    private struct PendingBinaryOperation{
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double{
            return function(firstOperand,secondOperand)
        }
    }
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    var result: Double? {
        get{
            return accumulator
        }
    }
}
