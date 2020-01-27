//
//  CustomF.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 24/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

@IBDesignable
class FormTextField: UIView, TextFieldProtocol {
    
    var presenter: PresenterProtocol?

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

    @IBAction func onEditing(_ sender: BottomBorderedTextField) {
        guard let text = sender.text else {return}
        guard let presenter = presenter else {return}

        if presenter.evaluateString(forType: sender.type, string: text) {
            self.infoLabel.text = presenter.getErrorMessage(forType: sender.type)
            
            UIView.animate(withDuration: 0.5) {
                self.infoLabel.alpha = 0.0
                self.textField.changeBorderColor(withColor: UIColor.init(red: 102/255, green: 221/255, blue: 108/255, alpha: 1.0))

            }
            
          } else {
                self.infoLabel.text = presenter.getErrorMessage(forType: sender.type)
                
            UIView.animate(withDuration: 0.5) {
                self.infoLabel.alpha = 1.0
                self.textField.changeBorderColor(withColor: UIColor.init(red: 238/255, green: 82/255, blue: 53/255, alpha: 1.0))
            }
          }
    }
    
    func setPresenter(presenter: PresenterProtocol) {
        self.presenter = presenter
    }
}
