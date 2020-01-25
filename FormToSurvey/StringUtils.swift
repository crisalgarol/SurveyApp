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
        let rule = "^[a-zA-z]$"
        return NSPredicate(format: "SELF MATCHES %@", rule).evaluate(with: rule)
    }
    
}