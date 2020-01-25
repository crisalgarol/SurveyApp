//
//  CustomF.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 24/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

@IBDesignable
class FormTextField: UIView {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var textField: BottomBorderedTextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 10.0
    }
    
    func setImage(imageName: String) {
        self.icon.image = UIImage(named: imageName)
    }
    
    @IBAction func onEditingColor(_ sender: Any) {
        textField.changeBorderColor(withColor: UIColor.systemBlue)
    }
    
    @IBAction func onNotEditingColor(_ sender: Any) {
        textField.changeBorderColor(withColor: UIColor.gray)
    }
    
    
}
