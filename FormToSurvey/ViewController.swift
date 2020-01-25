//
//  ViewController.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 23/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: XIBView!
    @IBOutlet weak var lastNameFather: XIBView!
    @IBOutlet weak var lastNameMother: XIBView!
    @IBOutlet weak var mail: XIBView!
    @IBOutlet weak var cellphone: XIBView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: - Properties
    var managedContext: NSManagedObjectContext?
    var activeField: BottomBorderedTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func setupView() {
        guard let nameField = nameLabel.contentView as? FormTextField else {return}
        guard let lastNameFatherField = lastNameFather.contentView as? FormTextField else {return}
        guard let lastNameMotherField = lastNameMother.contentView as? FormTextField else {return}
        guard let mailField = mail.contentView as? FormTextField else {return}
        guard let cellphoneField = cellphone.contentView as? FormTextField else {return}
        
        self.activeField = BottomBorderedTextField()
        
        //Dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        //Add keyboard listeners
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)) , name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Set textFieldsType
        nameField.textField.type = .name
        lastNameFatherField.textField.type = .name
        lastNameMotherField.textField.type = .name
        mailField.textField.type = .email
        cellphoneField.textField.type = .phone
        
        //SetBackground
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //Set round corners of button
        saveButton.layer.cornerRadius = 5.0
        
        //Set icon
         nameField.setImage(imageName: "person")
         lastNameFatherField.icon.image = UIImage()
         lastNameMotherField.icon.image = UIImage()
         mailField.setImage(imageName: "email")
        cellphoneField.setImage(imageName: "phone")
         
        
        //Set textfield input type
        nameField.textField.keyboardType = .alphabet
        lastNameFatherField.textField.keyboardType = .alphabet
        lastNameMotherField.textField.keyboardType = .alphabet
        mailField.textField.keyboardType = .emailAddress
        cellphoneField.textField.keyboardType = .phonePad
        
        //Set placeholders
        nameField.textField.setPlaceholder(withText: "Nombre(s)")
        lastNameFatherField.textField.setPlaceholder(withText: "Apellido Paterno")
        lastNameMotherField.textField.setPlaceholder(withText: "Apellido Materno")
        mailField.textField.setPlaceholder(withText: "Correo electrónico")
        cellphoneField.textField.setPlaceholder(withText: "Teléfono")
 
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardInfo = notification.userInfo else {return}
        if let keyboardSize = (keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            let keyboardHeight = keyboardSize.height + 10
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.scrollView.contentInset = contentInsets
            var viewRect = self.view.frame
            viewRect.size.height -= keyboardHeight
            guard let activeField = self.activeField else {return}
            
            if !viewRect.contains(activeField.frame.origin) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardHeight)
                self.scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
    
    //MARK: - Model functions
    
    func saveUser() -> Bool {
        
        guard let nameT = (nameLabel.contentView as? FormTextField)?.textField.text else {return false}
        guard let lastNameFatherT = (lastNameFather.contentView as? FormTextField)?.textField.text else {return false}
        guard let lastNameMotherT = (lastNameMother.contentView as? FormTextField)?.textField.text else {return false}
        guard let mailT = (mail.contentView as? FormTextField)?.textField.text else {return false}
        guard let cellphoneT = (cellphone.contentView as? FormTextField)?.textField.text else {return false}
        
        
        
        guard let managedContext = managedContext else {return false}
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext) else {return false}
        
        let user = User(entity: entity, insertInto: managedContext)
        user.name = nameT
        user.lastnameMother = lastNameMotherT
        user.lastnameFather = lastNameFatherT
        user.cellphone = cellphoneT
        user.email = mailT
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
        print("Error at saving \(error): \(error.userInfo)")
            return false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "stats" else {return}
        guard let resultsVC = segue.destination as? ResultsViewController else {return}
        resultsVC.managedContext = managedContext
    }
    
    @IBAction func save(_ sender: Any) {
        
        var title = ""
        var msg = ""
        var action = UIAlertAction(title: "", style: .default, handler: nil)
        
        if saveUser() {
            title = "¡Guardado!"
            msg = "Se ha guardado tu información"
            action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        } else {
            title = "Error"
            msg = "Error al guardar"
            action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        }

        let ac = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        ac.addAction(action)
        
        present(ac, animated: true, completion: nil)
    }
    
}

