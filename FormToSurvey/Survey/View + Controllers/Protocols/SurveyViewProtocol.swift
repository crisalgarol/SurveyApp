//
//  SurveyViewProtocol.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 25/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

protocol SurveyViewProtocol: NSObject {
    func showAlertController(title: String, type: String, message: String, actionTitle: String, mustCleanUI: Bool) 
}
