//
//  SurveyPresenterProtocol.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 25/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

protocol SurveyPresenterProtocol {
    func saveToDB(name: String, lastName: String, lastNameMother: String, email: String, cellphoneNumber: String)
}
