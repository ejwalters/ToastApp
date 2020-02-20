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
import PopupDialog

class SignInViewController: UIViewController {

    //@IBOutlet weak var signUpLabel: FRHyperLabel!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var emailAddressField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    var emailController: MDCTextInputControllerOutlined?
    var passwordController: MDCTextInputControllerOutlined?
    lazy var themeColor = hexStringToUIColor(hex: PRIMARY_THEME_COLOR)
    
    @IBOutlet weak var stackView: UIStackView!
    var textArray = [String]()
    var colorArray = [UIColor]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboard()
        setupTextBoxes()
        setupSignUpButton()
    }
    
    //Function to move the view so the fields aren't hidden by keyboard
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    //Function to move fields to original position when keyboard is dismissed
    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    //Clicking outside of the keyboard dismisses the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Check if the user is signed in already
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            print("ERIC: ID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    //Adding observers to keyboard so we know when to adjust view for keyboard
    func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //User pressed sign in so we will check if the credentials are good and then sign in
    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailAddressField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd) { [weak self] user, error in
                guard self != nil else { return }
                if let user = user {
                    let uid = user.user.uid
                    let userData = ["provider": user.user.providerID]
                    self!.completeSignIn(id: uid, userData: userData)
                } else {
                    self!.presentDialogBox()
                }
            }
        }
    }
    
    //Building the dialog box to display sign in error
    func presentDialogBox() {
        let title = "Email/Password Incorrect"
        let message = "The username/password combination is incorrect. Try again."
        //let image = UIImage(named: "pexels-photo-103290")

        // Create the dialog
        let popup = PopupDialog(title: title, message: message)

        // Create buttons
        let buttonOne = CancelButton(title: "Try Again") {
            print("You canceled the car dialog.")
        }

        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    //Helper function to sign in the user and add to keychain
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ERIC: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    //Setting up the material design text fields
    func setupTextBoxes() {
        emailAddressField.placeholder = "Email"
        passwordField.placeholder = "Password"
    }
    
    //Creating the label for creating an account where only Sign Up is clickable
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
    
    //Get the string that should be clickable
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

    //See if the attributed string was clicked on
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.signUpLabel.text else { return }
        let conditionsRange = (text as NSString).range(of: "Sign Up")
        //let cancellationRange = (text as NSString).range(of: "the cancellation policies")
        
        if gesture.didTapAttributedTextInLabel(label: self.signUpLabel, inRange: conditionsRange) {
            
            self.performSegue(withIdentifier: "goToSignUp", sender: self)
            
        }
    }
    

}
