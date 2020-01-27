//
//  StringUtils.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 24/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

class StringUtils {
    
    static func isValidEmail(mail: String) -> Bool {
        let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: mail)
    }
    
    static func isValidCellphoneNumber(number: String) -> Bool {
        let rule = "[0-9]\\d{9}"
        return NSPredicate(format: "SELF MATCHES %@", rule).evaluate(with: number)
    }
    
    static func isValidNameOrLastname(name: String) -> Bool{

        for letter in name {
            
            let isValidLetter = letter == " " || letter == "Á" || letter == "á" || letter == "É" || letter == "é" || letter == "Í" || letter == "í" || letter == "Ó" || letter == "ó" || letter == "Ú" || letter == "ú" || letter == "Ñ" || letter == "ñ"
            
            
            if !letter.isLetter && !isValidLetter {
                return false
            }
        }
        
        return true
    }
    
    static func evaluate(type: textFieldType, string: String) -> Bool{
        switch type {
        case .phone:
            return isValidCellphoneNumber(number: string)
        case .email:
            return isValidEmail(mail: string)
        case .name:
            return isValidNameOrLastname(name: string)
        }
    }
    
    static func getErrorMessage(forType type: textFieldType) -> String {
        switch type {
        case .email:
            return "Email incorrecto"
        case .name:
            return "No debes usar caracteres"
        case .phone:
            return "Deben ser 10 digitos"
        }
    }
    
}
