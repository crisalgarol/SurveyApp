//
//  userCell.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 24/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameFather: UILabel!
    @IBOutlet weak var lastNameMother: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var cellphone: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
