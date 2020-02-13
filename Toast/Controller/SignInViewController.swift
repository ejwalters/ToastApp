//
//  SignInViewController.swift
//  Toast
//
//  Created by Eric Walters on 2/11/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper
import MaterialComponents.MaterialTextFields
import FRHyperLabel

class SignInViewController: UIViewController {

    //@IBOutlet weak var signUpLabel: FRHyperLabel!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var emailAddressField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    @IBOutlet weak var signUpButton: UIButton!
    var emailController: MDCTextInputControllerOutlined?
    var passwordController: MDCTextInputControllerOutlined?
    lazy var themeColor = hexStringToUIColor(hex: PRIMARY_THEME_COLOR)
    
    @IBOutlet weak var stackView: UIStackView!
    var textArray = [String]()
    var colorArray = [UIColor]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextBoxes()
        setupSignUpButton()
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        
        
        if let email = emailAddressField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd) { [weak self] user, error in
                guard self != nil else { return }
                if let user = user {
                    let uid = user.user.uid
                    let userData = ["provider": user.user.providerID]
                    self!.completeSignIn(id: uid, userData: userData)
                } else {
                    let alert = UIAlertController(title: "Email/Password Incorrect", message: "The username/password combination is incorrect. Try again.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self!.present(alert, animated: true, completion: nil)
                }
            }
        }

            
        
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ERIC: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    func setupTextBoxes() {
        
        emailController = MDCTextInputControllerOutlined(textInput: emailAddressField)
        emailController!.placeholderText = "Email"
        emailController!.inlinePlaceholderColor = UIColor.label
        emailController!.floatingPlaceholderActiveColor = themeColor
        emailController!.activeColor = UIColor.systemGray6
        emailController!.disabledColor = UIColor.systemGray6
        emailController!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        passwordController = MDCTextInputControllerOutlined(textInput: passwordField)
        passwordController!.placeholderText = "Password"
        passwordController!.inlinePlaceholderColor = UIColor.label
        passwordController!.floatingPlaceholderActiveColor = themeColor
        passwordController!.activeColor = UIColor.systemGray6
        passwordController!.disabledColor = UIColor.systemGray6
        passwordController!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    func setupTextField (field: MDCTextField, placeholder: String, themeColor: UIColor) {
        var controller: MDCTextInputControllerOutlined?
        controller = MDCTextInputControllerOutlined(textInput: field)
        controller!.placeholderText = placeholder
        controller!.inlinePlaceholderColor = UIColor.label
        controller!.floatingPlaceholderActiveColor = themeColor
        controller!.activeColor = UIColor.systemGray6
        controller!.disabledColor = UIColor.systemGray6
        controller!.textInsets(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    func setupSignUpButton() {
        textArray.append("Don't have an account?")
        textArray.append("Sign Up")
        
        colorArray.append(UIColor.label)
        colorArray.append(themeColor)
        
        self.signUpLabel.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray)
        
        self.signUpLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.signUpLabel.addGestureRecognizer(tapgesture)
    }
    
    
    
    func getAttributedString(arrayText:[String]?, arrayColors:[UIColor]?) -> NSMutableAttributedString {
        
        let finalAttributedString = NSMutableAttributedString()
        
        for i in 0 ..< (arrayText?.count)! {
            
            let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i]]
            let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key : Any]))
            
            if i != 0 {
                
                finalAttributedString.append(NSAttributedString.init(string: " "))
            }
            
            finalAttributedString.append(attributedStr)
        }
        
        return finalAttributedString
    }

    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.signUpLabel.text else { return }
        let conditionsRange = (text as NSString).range(of: "Sign Up")
        //let cancellationRange = (text as NSString).range(of: "the cancellation policies")
        
        if gesture.didTapAttributedTextInLabel(label: self.signUpLabel, inRange: conditionsRange) {
            
            self.performSegue(withIdentifier: "goToSignUp", sender: self)
            
        }
    }
    

}
