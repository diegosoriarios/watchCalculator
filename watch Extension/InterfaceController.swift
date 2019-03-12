//
//  InterfaceController.swift
//  watch Extension
//
//  Created by diego.rios on 12/03/19.
//  Copyright © 2019 diego.rios. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var label: WKInterfaceLabel!
    var currentValue: String = "0"
    var calculationExecuted = false
    var command: Command?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func bnt0() {
        numberPressed(value: 0)
    }
    
    @IBAction func btn1() {
        numberPressed(value: 1)
    }
    
    @IBAction func btn2() {
        numberPressed(value: 2)
    }
    
    @IBAction func btn3() {
        numberPressed(value: 3)
    }
    
    @IBAction func btn4() {
        numberPressed(value: 4)
    }
    
    @IBAction func btn5() {
        numberPressed(value: 5)
    }
    
    @IBAction func btn6() {
        numberPressed(value: 6)
    }
    
    @IBAction func btn7() {
        numberPressed(value: 7)
    }
    
    @IBAction func btn8() {
        numberPressed(value: 8)
    }
    
    @IBAction func btn9() {
        numberPressed(value: 9)
    }
    
    @IBAction func btndot() {
        if currentValue.range(of: ".") == nil {
            currentValue += "."
            label.setText(currentValue)
        }
    }
    
    @IBAction func btnEqual() {
        if command != nil {
            let answer = command!.executeWithNewValue(newValue: (currentValue as NSString).doubleValue)
            setDisplayValue(value: answer)
            command = nil
            calculationExecuted = true
        }
    }
    
    @IBAction func btnAdd() {
        commandTapped(type: .Add)
    }
    
    @IBAction func btnSub() {
        commandTapped(type: .Subtract)
    }
    
    @IBAction func btnMul() {
        commandTapped(type: .Multiply)
    }
    
    @IBAction func btnDiv() {
        commandTapped(type: .Divide)
    }
    
    @IBAction func btnClear() {
        command = nil
        currentValue = "0"
        label.setText(currentValue)
    }
    
    func numberPressed(value: Int){
        let newValue = "\(value)"
        
        if currentValue == "0" || calculationExecuted {
            calculationExecuted = false
            currentValue = newValue
        } else {
            currentValue += newValue
        }
        
        label.setText(currentValue)
    }
    
    func commandTapped(type: CommandType) {
        calculationExecuted = false
        if command != nil {
            command!.type = type
        } else {
            command = Command(type: type, oldValue: (currentValue as NSString).doubleValue)
            currentValue = "0"
        }
    }
    
    func setDisplayValue(value: Double) {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            currentValue = "\(Int(value))"
        } else {
            currentValue = "\(value)"
        }
        
        label.setText(currentValue)
    }
    
}
