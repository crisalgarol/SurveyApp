//
//  ResultsViewController.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 24/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit
import CoreData

class ResultsViewController: UITableViewController {

    //MARK: - Properties
    var managedContext: NSManagedObjectContext?
    var userRecords: [User] = []
    var fetchRequest: NSFetchRequest<User>?
    var asyncFetchRequest: NSAsynchronousFetchRequest<User>?
    var mustBeWhite = true

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRecords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {return UITableViewCell()}
        let currentElement = userRecords[indexPath.row]
        
        cell.nameLabel.text = currentElement.name
        cell.lastNameFather.text = currentElement.lastnameFather
        cell.lastNameMother.text = currentElement.lastnameMother
        cell.email.text = currentElement.email
        cell.cellphone.text = currentElement.cellphone
        cell.contentView.backgroundColor = mustBeWhite ? UIColor.white : UIColor(red: 244/255, green: 245/255, blue: 245/255, alpha: 1.0)
        mustBeWhite = !mustBeWhite
        
        return cell
    }

    func fetchData() {
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest = userRequest
        
        asyncFetchRequest = NSAsynchronousFetchRequest<User>(fetchRequest: userRequest) {
            [unowned self] (result: NSAsynchronousFetchResult) in
            
            guard let userRecords = result.finalResult else {return}
            
            self.userRecords = userRecords
            self.tableView.reloadData()
        }
        
        do {
            guard let asyncFetchRequest = asyncFetchRequest else {
                return
            }
                        
            guard let managedContext = self.managedContext else {
                return
            }
            
            try managedContext.execute(asyncFetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch \(error): \(error.userInfo)")
        }
        
    }
    
}
