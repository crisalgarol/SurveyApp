//
//  ViewController.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 23/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: XIBView!
    @IBOutlet weak var lastNameFather: XIBView!
    @IBOutlet weak var lastNameMother: XIBView!
    @IBOutlet weak var mail: XIBView!
    @IBOutlet weak var cellphone: XIBView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        

        
    }
    
    func setupView() {
        guard let nameField = nameLabel.contentView as? FormTextField else {return}
        guard let lastNameFatherField = lastNameFather.contentView as? FormTextField else {return}
        guard let lastNameMotherField = lastNameMother.contentView as? FormTextField else {return}
        guard let mailField = mail.contentView as? FormTextField else {return}
        guard let cellphoneField = cellphone.contentView as? FormTextField else {return}
        
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

    @IBAction func save(_ sender: Any) {
        
        let title = "Guardar"
        let msg = "Se ha guardado tu información."
        
        let ac = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let errorAction = UIAlertAction(title: "Entendido", style: .destructive, handler: nil)
        let normalAction = UIAlertAction(title: "¡Listo!", style: .cancel, handler: nil)
        
        //ac.addAction(errorAction)
        ac.addAction(normalAction)
        present(ac, animated: true, completion: nil)
    }
    
}

