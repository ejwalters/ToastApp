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

class SignInViewController: UIViewController {

    @IBOutlet weak var emailAddressField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    @IBOutlet weak var signUpButton: UIButton!
    var emailController: MDCTextInputControllerOutlined?
    var passwordController: MDCTextInputControllerOutlined?
    lazy var themeColor = hexStringToUIColor(hex: PRIMARY_THEME_COLOR)
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextBoxes()
        
        //stackView.setCustomSpacing(8.0, after: signUpButton)

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
