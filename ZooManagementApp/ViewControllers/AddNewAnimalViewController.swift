//
//  AddNewAnimalViewController.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

class AddNewAnimalViewController: UIViewController {

    var zoo: Zoo?
    @IBOutlet weak var animalBreedTextField: UITextField!
    @IBOutlet weak var waterConsumptionTextField: UITextField!
    @IBOutlet weak var keeperTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var createAnimalButton: UIButton!
    @IBOutlet weak var increaseCountButton: UIButton!
    var selectedAnimal: Animal?
    var selectedKeeper: ZooKeeper?
    var animalArray = DefinedAnimals.animalArray
    
    var keeperArray: [ZooKeeper] {
        if let zoo = zoo {
            return zoo.keepers ?? [ZooKeeper]()
        }
        return [ZooKeeper]()
    }
    
    var animalsInZoo: [Animal] {
        if let zoo = zoo {
            guard let animals = zoo.animals else {
                return [Animal]()
            }
            return animals
        }
        return [Animal]()
    }
    
    var animalBreedPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 0
        return picker
    }()
    
    var keeperPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 1
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePickers()
        configureTextFields()
        hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.isHidden = false
        waterConsumptionTextField.isEnabled = false
        animalBreedTextField.delegate = self
        keeperTextField.delegate = self
    }
    
    func configurePickers() {
        animalBreedPickerView.delegate      = self
        animalBreedPickerView.dataSource    = self
        keeperPickerView.delegate           = self
        keeperPickerView.dataSource         = self
    }
    
    func configureTextFields() {
        animalBreedTextField.inputView = animalBreedPickerView
        keeperTextField.inputView = keeperPickerView
        animalBreedTextField.tintColor = .clear
        keeperTextField.tintColor = .clear
    }
    
    @IBAction func createAnimalButtonClicked(_ sender: Any) {
        
        guard let breed = animalBreedTextField.text, breed != "",
              let consumption = waterConsumptionTextField.text, consumption != "",
              let keeper = keeperTextField.text, keeper != "",
              let count = countTextField.text, count != ""
        else {
            alert(titleInput: "Alert", messageInput: "Please make sure you fill in the blanks.")
            return
        }
        
        guard let selectedAnimal = selectedAnimal,
              let selectedKeeper = selectedKeeper,
              let countInt = Int(count)
        else { return }
        
        zoo?.getNewAnimal(animalBreed: selectedAnimal.animalBreed, waterConsumption: selectedAnimal.waterConsumption, sound: selectedAnimal.sound, keeper: selectedKeeper, count: countInt, image: selectedAnimal.image) { error in
            if let error = error {
                alert(titleInput: "Alert", messageInput: error)
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func increaseAnimalCountButtonClicked(_ sender: Any) {
        guard let breed = animalBreedTextField.text, breed != "",
              let consumption = waterConsumptionTextField.text, consumption != "",
              let keeper = keeperTextField.text, keeper != "",
              let count = countTextField.text, count != ""
        else {
            alert(titleInput: "Alert", messageInput: "Please make sure you fill in the blanks.")
            return
        }
        
        guard let selectedAnimal = selectedAnimal,
              let _ = selectedKeeper,
              let countInt = Int(count)
        else { return }
        
        zoo?.addToExisting(animalBreed: selectedAnimal.animalBreed, count: countInt, completion: { error in
            if let error = error {
                alert(titleInput: "Alert", messageInput: error)
            } else {
                navigationController?.popViewController(animated: true)
            }
        })
    }
    
}

extension AddNewAnimalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return animalArray.count
        } else {
            return keeperArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 1 && animalBreedTextField.text!.count == 0 {
            
        }
        if pickerView.tag == 0 {
            return animalArray[row].animalBreed
        } else {
            return keeperArray[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            animalBreedTextField.text = animalArray[row].animalBreed
            waterConsumptionTextField.text = String(animalArray[row].waterConsumption.formattedWithSeparator)
            selectedAnimal = animalArray[row]
            
            configureAnimalPicker()
            
        } else {
            keeperTextField.text = keeperArray[row].name
            selectedKeeper = keeperArray[row]
        }
    }
    
    func configureAnimalPicker() {
        for animal in animalsInZoo {
            if animal.animalBreed == selectedAnimal?.animalBreed {
                keeperTextField.text = animal.keeper?.name
                keeperTextField.isEnabled = false
                selectedKeeper = animal.keeper
                return
            } else {
                keeperTextField.isEnabled = true
                keeperTextField.text = ""
            }
        }
    }
}


extension AddNewAnimalViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == animalBreedTextField {
            animalBreedTextField.text = animalArray[0].animalBreed
            waterConsumptionTextField.text = String(animalArray[0].waterConsumption.formattedWithSeparator)
            selectedAnimal = animalArray[0]
            configureAnimalPicker()
            print("hello")
        } else if textField == keeperTextField {
            keeperTextField.text = keeperArray[0].name
            selectedKeeper = keeperArray[0]
        }
    }
}
