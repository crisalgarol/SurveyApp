//
//  XIBView.swift
//  FormToSurvey
//
//  Created by Cristian Olmedo on 23/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

@IBDesignable
class XIBView: UIView {

    var contentView: UIView?
    @IBInspectable var nibName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else {return}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else {return nil}
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setPresenterReference(presenter: PresenterProtocol){
        guard var cv = self.contentView as? TextFieldProtocol else {return}
        cv.presenter = presenter
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }

}


