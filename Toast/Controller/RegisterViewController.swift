//
//  RegisterViewController.swift
//  Toast
//
//  Created by Eric Walters on 2/11/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    @IBAction func signUpPressed(_ sender: Any) {
        if let email = emailAddressField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
                                   
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error != nil {
                    print("ERIC: Unable to authenticate with Firebase using email")
                    let alert = UIAlertController(title: "Error", message: "There was an error creating your account. Verify that you do not already have an account with the email provided.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(error!)
                }
                else {
                    
                    if let user = user {
                        let userData = ["provider": user.user.providerID]
                        let uid = user.user.uid
                        self.completeSignIn(id: uid, userData: userData)
                        //let db = Firestore.firestore()
                    //db.collection("users").document("\(uid)").setData(["lastname":lastName,"firstname":firstName,"email":emailAddress,"uid":uid])

                    }
                    //print(error)
                    
                }
            }
        
        }
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
