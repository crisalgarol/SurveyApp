//
//  PresenterProtocol.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 27/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

protocol PresenterProtocol {
    func evaluateString(forType type: textFieldType , string: String) -> Bool
    func getErrorMessage(forType type: textFieldType) -> String 
}
