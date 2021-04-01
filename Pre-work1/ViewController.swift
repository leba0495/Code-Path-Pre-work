//
//  ViewController.swift
//  Pre-work1
//
//  Created by Luis Brito on 3/31/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    @IBOutlet weak var inputStackView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss keyboard
        setUpViews()
        billAmountTextField.calculateButtonAction = {self.calculate()}
    }
    
    func calculate() {
        if self.billAmountTextField.isFirstResponder {
            self.billAmountTextField.resignFirstResponder()
        }
        // 1
        guard let billAmountText = self.billAmountTextField.text,
              let billAmount = Double(billAmountText)else { clear(); return }
        
        let roundedBillAmount = (100 * billAmount).rounded() / 100
        
        //2
        let tipPercentages = [0.10, 0.15, 0.18, 0.20]
        let tipAmount = roundedBillAmount * tipPercentages[tipPercentSegmentedControl.selectedSegmentIndex]
        let roundedTipAmount = (100 * tipAmount).rounded() / 100
        
        //3
        let totalAmount = roundedBillAmount + roundedTipAmount
        
        //Update UI
        self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
        self.tipAmountLabel.text = String(format: "%.2f", tipAmount)
        self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
    }
    func clear(){
        billAmountTextField.text = nil
        tipPercentSegmentedControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
    }
    func setUpViews(){
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        inputStackView.layer.cornerRadius = 8
        inputStackView.layer.masksToBounds = true
        
        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds  = true
        outputCardView.layer.borderWidth = 1
        outputCardView.layer.borderColor = UIColor.systemOrange.cgColor
        
        clearButton.layer.cornerRadius = 8
        clearButton.layer.masksToBounds = true
    }
    @IBAction func themeToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("switch toggled on")
        } else {
            print("switch toggled off")
        }
    }
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        calculate()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        clear()
    }
    
}

