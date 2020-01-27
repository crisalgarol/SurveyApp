//
//  ViewController.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 23/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit
import CoreData

class SurveyViewController: UIViewController, SurveyViewProtocol {
    
    @IBOutlet weak var nameLabel: XIBView!
    @IBOutlet weak var lastNameFather: XIBView!
    @IBOutlet weak var lastNameMother: XIBView!
    @IBOutlet weak var mail: XIBView!
    @IBOutlet weak var cellphone: XIBView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    var activeField: BottomBorderedTextField?
    var presenter: SurveyPresenter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    //MARK: UISetup
    func setupView() {
        guard let nameField = nameLabel.contentView as? FormTextField else {return}
        guard let lastNameFatherField = lastNameFather.contentView as? FormTextField else {return}
        guard let lastNameMotherField = lastNameMother.contentView as? FormTextField else {return}
        guard let mailField = mail.contentView as? FormTextField else {return}
        guard let cellphoneField = cellphone.contentView as? FormTextField else {return}
        guard let presenter = presenter else {return}
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
        
        //Set the delegate to TextFields
        nameField.presenter = self.presenter
        lastNameMotherField.presenter = self.presenter
        lastNameFatherField.presenter = self.presenter
        mailField.presenter = self.presenter
        cellphoneField.presenter = self.presenter
        
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

    //MARK: -Keyboard Management
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "stats" else {return}
        guard let resultsVC = segue.destination as? ResultsViewController else {return}
        resultsVC.managedContext = self.presenter?.managedContext 
    }
    
    func showAlertController(title: String, type: String, message: String, actionTitle: String, mustCleanUI: Bool) {
        let action = UIAlertAction(title: actionTitle, style: type == "cancel" ? .cancel : .destructive, handler: nil)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
             ac.addAction(action)
             
        present(ac, animated: true) { [unowned self] in
            if mustCleanUI {
                guard let nameTF = self.nameLabel.contentView as? BottomBorderedTextField else {return}
                guard let lastNameTF = self.lastNameFather.contentView as? BottomBorderedTextField else {return}
                guard let lastNameMotherTF = self.lastNameMother.contentView as? BottomBorderedTextField else {return}
                guard let emailTF = self.mail.contentView as? BottomBorderedTextField else {return}
                guard let cellphoneNumberTF = self.cellphone.contentView as? BottomBorderedTextField else {return}

                nameTF.text = ""
                lastNameTF.text = ""
                lastNameMotherTF.text = ""
                emailTF.text = ""
                cellphoneNumberTF.text = ""
            }
        }
            
        }
            
        
    @IBAction func save(_ sender: Any) {
        guard let presenter = presenter else {return}
        guard let nameT = (nameLabel.contentView as? FormTextField)?.textField.text else {return}
        guard let lastNameFatherT = (lastNameFather.contentView as? FormTextField)?.textField.text else {return}
        guard let lastNameMotherT = (lastNameMother.contentView as? FormTextField)?.textField.text else {return}
        guard let mailT = (mail.contentView as? FormTextField)?.textField.text else {return}
        guard let cellphoneT = (cellphone.contentView as? FormTextField)?.textField.text else {return}
        
        presenter.saveToDB(name: nameT, lastName: lastNameFatherT, lastNameMother: lastNameMotherT, email: mailT, cellphoneNumber: cellphoneT)
                
    }
    
}
