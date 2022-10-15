//
//  ViewController.swift
//  Calculator
//
//  Created by Aagontuk on 10/15/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblDisplay: UILabel?
    
    var userIsMiddleOf = false
    
    @IBAction func btnTouchDigit(_ sender: UIButton){
        
        //var digit = sender.currentTitle ?? "4"
        var digit = sender.currentTitle ?? "4"
        print("\(digit) was touched")
        let textCurrentDisplay = lblDisplay!.text!
        if userIsMiddleOf ==  false{
            lblDisplay!.text = digit
            userIsMiddleOf = true
        }
        else{
            lblDisplay!.text = textCurrentDisplay + digit
            
        }
        
        
    }
    
    var displayValue: Double{
        get{
            
            return Double(lblDisplay!.text!)!
            
        }
        set{
            lblDisplay!.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    @IBAction func btnPerformOperations(_ sender: UIButton){
        if userIsMiddleOf {
            brain.setOperand(displayValue)
            userIsMiddleOf = false
        }
        
        if let mathmeticalSymbole = sender.currentTitle {
            brain.performOperation(mathmeticalSymbole)
        }
        
        if let result = brain.result{
            displayValue = result
        }
    }


}

