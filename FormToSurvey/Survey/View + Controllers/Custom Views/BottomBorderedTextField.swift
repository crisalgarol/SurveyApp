//
//  BottomBorderedTextField.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 24/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

class BottomBorderedTextField: UITextField {
    
    var bottomBorder: UIView?
    var type: textFieldType = .name

    override func awakeFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .none
        self.backgroundColor = .clear
        self.text = nil
        self.placeholder = nil
        self.textColor = .black
        bottomBorder = UIView.init(frame: CGRect(x:0, y: 0, width: 0, height: 0))
        
        guard let bottomBorder = bottomBorder else {return}
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = UIColor.placeholderText
        
        addSubview(bottomBorder)
        
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func changeBorderColor(withColor color: UIColor) {
        self.bottomBorder?.backgroundColor = color
    }
    
    func changeTextColor(withColor color: UIColor) {
        self.textColor = color
    }
    
    func changeTypeOfTextField(type: textFieldType) {
        self.type = type
    }
    
    func setPlaceholder(withText ph: String) {
        self.attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText])
    }
  

}
