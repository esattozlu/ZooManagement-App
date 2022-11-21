//
//  CreateZooViewController.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

class CreateZooViewController: UIViewController {

    @IBOutlet weak var zooLogoImageView: UIImageView!
    @IBOutlet weak var zooNameTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var waterLimitTextField: UITextField!
    var zoo: Zoo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
        configureLogoImageViewGestureRecognizer()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let zooDetailVC = segue.destination as? ZooDetailsViewController
        zooDetailVC?.zoo = zoo
    }
    

    @IBAction func createButtonClicked(_ sender: Any) {
        if let name = zooNameTextField.text, let budget = budgetTextField.text, let waterLimit = waterLimitTextField.text {
            guard let budgetDouble      = Double(budget) else { return zooCreationAlert() }
            guard let waterLimitDouble  = Double(waterLimit) else { return zooCreationAlert() }
            zoo = Zoo(zooName: name, waterLimit: waterLimitDouble, budget: budgetDouble, logo: zooLogoImageView.image)
            performSegue(withIdentifier: "toZooDetailPage", sender: nil)
        } else {
            zooCreationAlert()
        }
    }
    
    
    func zooCreationAlert() {
        alert(titleInput: "Check Input Fields", messageInput: "Please make sure you fill in the blanks correctly.")
    }
    
    
    func configureLogoImageViewGestureRecognizer() {
        zooLogoImageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        zooLogoImageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
}

extension CreateZooViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        zooLogoImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
