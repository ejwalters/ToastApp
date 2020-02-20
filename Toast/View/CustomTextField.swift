//
//  CustomTextField.swift
//  Toast
//
//  Created by Eric Walters on 2/17/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

open class CustomTextField: MDCTextField {

    var controller: MDCTextInputControllerOutlined?
    lazy var themeColor = hexStringToUIColor(hex: PRIMARY_THEME_COLOR)
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        controller = MDCTextInputControllerOutlined(textInput: self)
        //emailController!.placeholderText = "Email"
        controller!.inlinePlaceholderColor = UIColor.label
        controller!.floatingPlaceholderActiveColor = themeColor
        controller!.activeColor = UIColor.systemGray3
        controller!.disabledColor = UIColor.systemGray3
        controller!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }


}
