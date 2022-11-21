//
//  AddNewKeeperViewController.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

class AddNewKeeperViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    
    var zoo: Zoo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.isHidden = false
        configureTextFields()
    }
    
    func configureTextFields() {
        nameTextField.delegate = self
        idTextField.delegate = self
        ageTextField.delegate = self
        salaryTextField.text = ""
        salaryTextField.isEnabled = false
    }
    
    
    @IBAction func createKeeperButtonClicked(_ sender: Any) {
        guard nameTextField.text != "",
              idTextField.text != "",
              ageTextField.text != ""
        else {
            alert(titleInput: "Alert", messageInput: "Please make sure you fill in the blanks correctly.")
            return
        }
        
        guard let name = nameTextField.text,
              let id   = idTextField.text,
              let age  = ageTextField.text,
              let idInt  = Int(id),
              let ageInt = Int(age)
        else {
            alert(titleInput: "Alert", messageInput: "Please make sure you fill in the blanks correctly.")
            return
        }
        
        zoo?.hireZooKeeper(keeper: .init(name: name, keeperId: idInt, age: ageInt), completion: { error in
            if let error = error {
                alert(titleInput: "Alert", messageInput: error)
            }
        })
        navigationController?.popViewController(animated: true)
    }
}

extension AddNewKeeperViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let _  = nameTextField.text,
              let id    = idTextField.text,
              let age   = ageTextField.text,
              nameTextField.text != "",
              idTextField.text != "",
              ageTextField.text != ""
        else {
            salaryTextField.text = ""
            return
        }
        
        if let ageInt = Int(age), let _ = Int(id) {
            salaryTextField.text = "\(ZooKeeper.calculateSalary(age: ageInt).formattedWithSeparator)₺"
        } else {
            alert(titleInput: "Alert", messageInput: "Age and id should be integer.")
            return
        }
    }
}
