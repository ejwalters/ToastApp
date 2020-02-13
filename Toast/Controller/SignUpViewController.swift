//
//  SignUpViewController.swift
//  Toast
//
//  Created by Eric Walters on 2/12/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class SignUpViewController: UIViewController {

   
    @IBOutlet weak var firstName: MDCTextField!
    @IBOutlet weak var lastName: MDCTextField!
    @IBOutlet weak var emailAddress: MDCTextField!
    @IBOutlet weak var password: MDCTextField!
    @IBOutlet weak var validatePassword: MDCTextField!
    
    var firstNameController: MDCTextInputControllerOutlined?
    var lastNameController: MDCTextInputControllerOutlined?
    var emailController: MDCTextInputControllerOutlined?
    var passwordController: MDCTextInputControllerOutlined?
    var validatePasswordController: MDCTextInputControllerOutlined?
    
    lazy var themeColor = hexStringToUIColor(hex: PRIMARY_THEME_COLOR)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextBoxes()
        // Do any additional setup after loading the view.
    }
    
    
    func setupTextBoxes() {
        
        emailController = MDCTextInputControllerOutlined(textInput: emailAddress)
        emailController!.placeholderText = "Email"
        emailController!.inlinePlaceholderColor = UIColor.label
        emailController!.floatingPlaceholderActiveColor = themeColor
        emailController!.activeColor = UIColor.systemGray6
        emailController!.disabledColor = UIColor.systemGray6
        emailController!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        firstNameController = MDCTextInputControllerOutlined(textInput: firstName)
        firstNameController!.placeholderText = "First Name"
        firstNameController!.inlinePlaceholderColor = UIColor.label
        firstNameController!.floatingPlaceholderActiveColor = themeColor
        firstNameController!.activeColor = UIColor.systemGray6
        firstNameController!.disabledColor = UIColor.systemGray6
        firstNameController!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        lastNameController = MDCTextInputControllerOutlined(textInput: lastName)
        lastNameController!.placeholderText = "Last Name"
        lastNameController!.inlinePlaceholderColor = UIColor.label
        lastNameController!.floatingPlaceholderActiveColor = themeColor
        lastNameController!.activeColor = UIColor.systemGray6
        lastNameController!.disabledColor = UIColor.systemGray6
        lastNameController!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        passwordController = MDCTextInputControllerOutlined(textInput: password)
        passwordController!.placeholderText = "Password"
        passwordController!.inlinePlaceholderColor = UIColor.label
        passwordController!.floatingPlaceholderActiveColor = themeColor
        passwordController!.activeColor = UIColor.systemGray6
        passwordController!.disabledColor = UIColor.systemGray6
        passwordController!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        validatePasswordController = MDCTextInputControllerOutlined(textInput: validatePassword)
        validatePasswordController!.placeholderText = "Confirm Password"
        validatePasswordController!.inlinePlaceholderColor = UIColor.label
        validatePasswordController!.floatingPlaceholderActiveColor = themeColor
        validatePasswordController!.activeColor = UIColor.systemGray6
        validatePasswordController!.disabledColor = UIColor.systemGray6
        validatePasswordController!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
