//
//  ZooDetailsViewController.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

class ZooDetailsViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var zooNameLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var waterLimitLabel: UILabel!
    @IBOutlet weak var employeeCountLabel: UILabel!
    @IBOutlet weak var totalSalariesLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var remaininLimitTextField: UILabel!
    var zoo: Zoo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        navigationController?.navigationBar.isHidden = true
    }
    
    
    
    @IBAction func addIncomeButtonClicked(_ sender: Any) {
        guard let zoo = zoo,
              let income = amountTextField.text,
              let incomeDouble = Double(income),
              income != ""
        else {
            alert(titleInput: "Alert", messageInput: "Please make sure you enter a value. The value you enter must be numeric.")
            return
        }
        zoo.addIncome(amount: incomeDouble)
        reloadData()
        amountTextField.text = ""
        amountTextField.resignFirstResponder()
    }
    
    @IBAction func addExpenseButtonClicked(_ sender: Any) {
        guard let zoo = zoo,
              let expense = amountTextField.text,
              let expenseDouble = Double(expense),
              expense != ""
        else {
            alert(titleInput: "Alert", messageInput: "Please make sure you enter a value. The value you enter must be numeric.")
            return
        }
        zoo.addExpense(amount: expenseDouble, completion: { error in
            if let error = error {
                alert(titleInput: "Alert", messageInput: error)
            }
        })
        reloadData()
        amountTextField.text = ""
        amountTextField.resignFirstResponder()
    }
    
    @IBAction func changeWaterLimitButtonClicked(_ sender: Any) {
        guard let zoo = zoo,
              let newWaterLimit = amountTextField.text,
              let newWaterLimitDouble = Double(newWaterLimit),
              newWaterLimit != ""
        else {
            alert(titleInput: "Alert", messageInput: "Please make sure you enter a value. The value you enter must be numeric.")
            return
        }
        zoo.reviseWaterLimit(limit: newWaterLimitDouble)
        reloadData()
        amountTextField.text = ""
        amountTextField.resignFirstResponder()
    }
    
    @IBAction func increaseWaterLimitButtonClicked(_ sender: Any) {
        guard let zoo = zoo,
              let increasedAmount = amountTextField.text,
              let increasedAmountDouble = Double(increasedAmount),
              increasedAmount != ""
        else {
            alert(titleInput: "Alert", messageInput: "Please make sure you enter a value. The value you enter must be numeric.")
            return
        }
        zoo.increaseWaterLimit(amount: increasedAmountDouble)
        reloadData()
        amountTextField.text = ""
        amountTextField.resignFirstResponder()
    }
    
    @IBAction func newKeeperButtonClicked(_ sender: Any) {
            performSegue(withIdentifier: "toAddKeeper", sender: nil)
    }
    
    @IBAction func newAnimalButtonClicked(_ sender: Any) {
        if let _ = zoo?.keepers {
        performSegue(withIdentifier: "toAddAnimal", sender: nil)
        } else {
            alert(titleInput: "Alert", messageInput: "Before adding new animal you should add at least one keeper.")
        }
    }
    
    @IBAction func paySalariesButtonClicked(_ sender: Any) {
        guard let zoo = zoo else { return }
        zoo.paySalary(completion: { message in
            alert(titleInput: "Alert", messageInput: message)
        })
        reloadData()
        amountTextField.text = ""
        amountTextField.resignFirstResponder()
    }
    
    @IBAction func showListButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddKeeper" {
            let addKeeperVC = segue.destination as? AddNewKeeperViewController
            addKeeperVC?.zoo = zoo
        }
        
        if segue.identifier == "toAddAnimal" {
            let addAnimalVC = segue.destination as? AddNewAnimalViewController
            addAnimalVC?.zoo = zoo
        }
        
        if segue.identifier == "toList" {
            let listVC = segue.destination as? ListViewController
            listVC?.zoo = zoo
        }
    }
    
    
    func reloadData() {
        if let zoo = zoo {
            logoImageView.image = zoo.logo
            zooNameLabel.text = zoo.zooName
            waterLimitLabel.text = "\(zoo.waterLimit.formattedWithSeparator)"
            budgetLabel.text = "\(zoo.budget.formattedWithSeparator)₺"
            employeeCountLabel.text = "\(zoo.keepers?.count ?? 0)"
            totalSalariesLabel.text = "\(zoo.totalSalary.formattedWithSeparator)₺"
            remaininLimitTextField.text = "\(zoo.remainingLimit.formattedWithSeparator)"
        }
    }
}
