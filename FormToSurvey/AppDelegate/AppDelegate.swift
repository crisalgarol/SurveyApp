//
//  AppDelegate.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 23/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "Survey")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        guard let navController = window?.rootViewController as? UINavigationController else {return true}
        guard let firstView = navController.topViewController as? SurveyViewController else {return true}
                
        firstView.presenter = SurveyPresenter(managedContext: self.coreDataStack.managedContext)
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }


}

