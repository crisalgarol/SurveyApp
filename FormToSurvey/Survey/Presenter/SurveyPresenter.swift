//
//  SurveyPresenter.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 25/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation
import CoreData

class SurveyPresenter: SurveyPresenterProtocol, PresenterProtocol {
    
    var managedContext: NSManagedObjectContext?
    weak var delegate: SurveyViewProtocol?
    
    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func saveToDB(name: String, lastName: String, lastNameMother: String, email: String, cellphoneNumber: String) {
                
        guard let managedContext = managedContext else {return}
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext) else {return}
        
        let isValidName = StringUtils.evaluate(type: .name, string: name)
        let isValidLastName = StringUtils.evaluate(type: .name, string: lastName)
        let isValidLastNameMother = StringUtils.evaluate(type: .name, string: lastNameMother)
        let isValidMail = StringUtils.evaluate(type: .email, string: email)
        let isValidCellphone = StringUtils.evaluate(type: .phone, string: cellphoneNumber)

        if !(isValidName && isValidLastName && isValidLastNameMother && isValidMail && isValidCellphone) {
            delegate?.showAlertController(title: "¡Uy!", type: "destructive", message: "Debes completar todos los campos correctamente", actionTitle: "Vale", mustCleanUI: false)
            return
        }
        
        let user = User(entity: entity, insertInto: managedContext)
        user.name = name
        user.lastnameMother = lastNameMother
        user.lastnameFather = lastName
        user.cellphone = cellphoneNumber
        user.email = email
        
        
        do {
            try managedContext.save()
            delegate?.showAlertController(title: "Guardado", type: "cancel", message: "Se han guardado exitosamente tus datos", actionTitle: "Vale", mustCleanUI: false)
        } catch {
            delegate?.showAlertController(title: "Error", type: "destructive", message: "Hubo un error al almacenar tus datos", actionTitle: "Vale", mustCleanUI: true)
        }
    }
    
    func evaluateString(forType type: textFieldType, string: String) -> Bool {
        return StringUtils.evaluate(type: type, string: string)
    }
    
    func getErrorMessage(forType type: textFieldType) -> String {
        return StringUtils.getErrorMessage(forType: type)
    }
}
