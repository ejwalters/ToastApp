//
//  SignUpViewController.swift
//  Toast
//
//  Created by Eric Walters on 2/12/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import Firebase
import SwiftKeychainWrapper
import PopupDialog

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var firstName: MDCTextField!
    @IBOutlet weak var lastName: MDCTextField!
    @IBOutlet weak var emailAddress: MDCTextField!
    @IBOutlet weak var password: MDCTextField!
    @IBOutlet weak var validatePassword: MDCTextField!
    @IBOutlet weak var profileImage: ProfileImage!
    @IBOutlet weak var cameraButton: UIButton!
    
    var firstNameController: MDCTextInputControllerOutlined?
    var lastNameController: MDCTextInputControllerOutlined?
    var emailController: MDCTextInputControllerOutlined?
    var passwordController: MDCTextInputControllerOutlined?
    var validatePasswordController: MDCTextInputControllerOutlined?
    
    lazy var themeColor = hexStringToUIColor(hex: PRIMARY_THEME_COLOR)
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    let imagePicker = UIImagePickerController()
    var imageSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextBoxes()
        configureKeyboard()
        imagePicker.delegate = self
        profileImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
            profileImage.contentMode = UIView.ContentMode.scaleAspectFill
            imageSelected = true
            
            cameraButton.setImage(nil, for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        print("BUTTON WORKED!")
        imagePicker.allowsEditing = true
        //imagePicker.sourceType = .photoLibrary
        
        let refreshAlert = UIAlertController(title: "Photo Selection", message: "Select Photo Source", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))

        present(refreshAlert, animated: true, completion: nil)
        
    }
    /*
    func updateFirebase(imgUrl: String) {

        db.collection("users").document(uid!).setData([ "firstname": firstNameTextField.text!, "lastname": lastNameTextField.text!, "email": emailTextField.text!, "profileImage": imgUrl], merge: true)

    }*/
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if profileImage.image != nil && firstName.text != "" && lastName.text != "" && emailAddress.text != "" && password.text != "" && validatePassword.text != ""  {
            if self.password.text == self.validatePassword.text {
                if let imageData = profileImage.image!.jpegData(compressionQuality: 0.2) {
                        
                        let imgUid = NSUUID().uuidString
                        let metadata = StorageMetadata()
                        metadata.contentType = "image/jpeg"
                        let storageItem = STORAGE_BASE.child(imgUid)
                        print("STORAGE ID: \(storageItem)")
                        
                        
                        DataService.ds.REF_PROFILE_IMAGES.child(imgUid).putData(imageData, metadata: metadata) { (metadata, error) in
                            if error != nil {
                                print("ERIC: Unable to upload image to Firebasee torage")
                            } else {
                                print("ERIC: Successfully uploaded image to Firebase storage")
                                DataService.ds.REF_PROFILE_IMAGES.child(imgUid).downloadURL(completion: { (url, error) in
                                    if error != nil {
                                        print("ERROR in image \(error!)")
                                        print("Error URL for image: \(String(describing: url))")
                                        return
                                    }
                                    if url != nil {
                                        //self.updateFirebase(imgUrl: url!.absoluteString)
                                        //print("URL for image: \(String(describing: url))")
                                             //Passwords match, create user
                                             print("password match!")
                                            if let email = self.emailAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = self.password.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                                                 
                                                let firstNameAdd = self.firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                                let lastNameAdd = self.lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                                let emailAddressAdd = self.emailAddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                                                        
                                                 Auth.auth().createUser(withEmail: email, password: password) { user, error in
                                                     if error != nil {
                                                        self.presentDialogBox(errorCategory: "Error creating account", errorMessage: "There was an error creating your account. Verify that you do not already have an account with the email provided.")
                                                         print(error!)
                                                     }
                                                     else {
                                                         let cleanPassword = self.password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                                         
                                                         if isPasswordValid(cleanPassword) == false {
                                                            self.presentDialogBox(errorCategory: "Password Error", errorMessage: "Password does not meet the requirements! Please revise." )
                                                             return
                                                         } else {
                                                             
                                                             //Create cleaned versions of data
                                                            
                                                             print("ERIC: Successfully authenticated with Firebase")
                                                             if let user = user {
                                                                 let userData = ["provider": user.user.providerID]
                                                                 let uid = user.user.uid
                                                                 self.completeSignIn(id: uid, userData: userData)
                                                                 let db = Firestore.firestore()
                                                                db.collection("users").document("\(uid)").setData(["lastname":lastNameAdd,"firstname":firstNameAdd,"email":emailAddressAdd,"uid":uid,"profileImage":url!.absoluteString])

                                                             }
                                                         }
                                                         
                                                     }
                                                 }
                                             
                                             }
                                             
                                        
                                    }
                                })
                            }
                        }
                    }
                }
                else {
                    self.presentDialogBox(errorCategory: "Password Error", errorMessage: "Your passwords do not match! Try again.")
                }
            } else {
                self.presentDialogBox(errorCategory: "All fields required", errorMessage: "You must complete all fields, including profile image.")
            }
        
        //Create the user
        
        
    }
    
    
    func presentDialogBox(errorCategory: String, errorMessage: String) {
        let title = errorCategory
        let message = errorMessage
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
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        //let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ERIC: Data saved to keychain \(keychainResult)")
        //performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
