//
//  ViewController.swift
//  CalculatorApp
//
//  Created by sunarc on 8/25/21.
//

import UIKit
enum Operation:String{
    case Plus = "+"
    case Minus = "-"
    case Multiply = "*"
    case Divide = "/"
    case Empty = "Empty"
}

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var currentNumber = ""
    var leftOperand = ""
    var rightOperand = ""
    var result = ""
    var currentOperation:Operation = .Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0"
    }

    @IBAction func backButton(_ sender: RoundButton) {
    
        guard
            let text =  outputLabel.text,
                !text.isEmpty
            else {
                return
            }
        outputLabel.text = String(text.dropLast())


            
        }
    
    @IBAction func numberPressedButton(_ sender: RoundButton) {
        if currentNumber.count <= 8 { //taki dot na aajay maximum 9 number hi screen pr dikhte hai
         currentNumber += "\(sender.tag)" //jo button ko tag diye button press krne pr current nmbr ko de dega
         outputLabel.text = currentNumber
        }
    }
    
    @IBAction func allClearPressedButton(_ sender: RoundButton) {
         currentNumber = ""
         leftOperand = ""
         rightOperand = ""
        currentOperation = .Empty
        outputLabel.text = "0"
        
    }
    
    @IBAction func decimalButton(_ sender: RoundButton) {
        if currentNumber.count <= 7 { //taki dot last me na aajay
            currentNumber += "."
        outputLabel.text = currentNumber
        }
        
    }
    @IBAction func equalButton(_ sender: RoundButton) {
        operation(operation: currentOperation)
    }
    @IBAction func plusButton(_ sender: RoundButton) {
        operation(operation: .Plus) //operation funtion ko call kia
    }
    @IBAction func minusButton(_ sender: RoundButton) {
        operation(operation: .Minus)
        
    }
    @IBAction func multiplyButton(_ sender: RoundButton) {
        operation(operation: .Multiply)
        
    }
    @IBAction func divideButton(_ sender: RoundButton) {
        operation(operation: .Divide)
        
    }
    
    func operation(operation: Operation){ //ye funtion enum lega aur accordingly operations perform karega
        if currentOperation != .Empty { //yani koi sign plus minus aur ka pehle press ho chuka hai to ye apn second nmbr hoga
            if currentNumber != "" { //matlb  koi sign press ho chuka aur ye apni second value hai agr currntnmber me kuchh store hai to
               rightOperand = currentNumber
                currentNumber = ""
                
                if currentOperation == .Plus {
                    result = "\(Double(leftOperand)! + Double(rightOperand)! )" //apn ne saare number string me store kiye calculation k kiye down type casting krni pdegi
                    
                } else if currentOperation == .Minus {
                    result = "\(Double(leftOperand)! - Double(rightOperand)! )"
                }else if currentOperation == .Multiply{
                    result = "\(Double(leftOperand)! * Double(rightOperand)! )"
                }else if currentOperation == .Divide {
                    result = "\(Double(leftOperand)! / Double(rightOperand)! )"
                }
                leftOperand = result
                if(Double(result)! .truncatingRemainder(dividingBy: 1)==0){ //agar answer int hai to decimal point nahi dikna chahiye//%  FLOAT k lie avaiable nahi hai
                    result = "\(Int(Double(result)!))"
                
                }
                outputLabel.text = result
            }
            currentOperation = operation //enum type k variable me jo operation perform kia hai vo dala hai..intially ye empty tha
            
        }
        else{ //yani isse pehle  koi plus minus   press nahi hua to ye apna first operand hoga yahi left operand to current value ko isme stor kr denge
            leftOperand = currentNumber
            currentNumber = "" //second perand ko store krane k liye currentnumber ko khaali krna pdega
            currentOperation = operation
            
            
        }
    }

}

