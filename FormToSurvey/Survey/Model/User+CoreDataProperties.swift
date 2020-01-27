//
//  User+CoreDataProperties.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 24/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastnameFather: String?
    @NSManaged public var lastnameMother: String?
    @NSManaged public var cellphone: String?
    @NSManaged public var email: String?

}
