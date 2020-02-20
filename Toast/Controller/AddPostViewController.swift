//
//  AddPostViewController.swift
//  Toast
//
//  Created by Eric Walters on 2/15/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var newPostImage: UIImageView!
    @IBOutlet weak var postCategory: CustomTextField!
    //@IBOutlet weak var typeDropDown: DropDown!
    @IBOutlet weak var postName: CustomTextField!
    //@IBOutlet weak var postYear: CustomDropDown!
    @IBOutlet weak var postSubCategory: CustomTextField!
    @IBOutlet weak var postYear: CustomTextField!
    var imageSelected = false
    
    @IBOutlet weak var postPrice: CustomTextField!
    @IBOutlet weak var viewOutline: UIView!
    var postNameController: MDCTextInputControllerOutlined?
    var postTypeController: MDCTextInputControllerOutlined?
    var postPriceController: MDCTextInputControllerOutlined?
    let myColor = UIColor.systemGray3
    let clearColor = UIColor.clear
    let imagePicker = UIImagePickerController()
    
    
    lazy var themeColor = hexStringToUIColor(hex: PRIMARY_THEME_COLOR)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //AddPostViewController.hidesBottomBarWhenPushed = true
        
        //postCategory.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        //self.tabBarController?.tabBar.isHidden = true
        imagePicker.delegate = self
        viewOutline.layer.borderColor = myColor.cgColor
        viewOutline.layer.borderWidth = 1.0
        viewOutline.layer.cornerRadius = 2.0
        setupTextBoxes()
        //setupDropDown()
        print("POST HEIGHT - \(postName.frame.height)")
    }
    
   /* @objc func myTargetFunction(textField: CustomTextField) {
        
        if isOpen == false {
            
        } else {
            
        }
        
    }*/
    
    @IBAction func addImageTapped(_ sender: UIButton) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            newPostImage.image = image
            newPostImage.contentMode = UIView.ContentMode.scaleAspectFill
            newPostImage.layer.cornerRadius = 2.0
            //newPostImage.clipsToBounds = true
            newPostImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            newPostImage.layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
            newPostImage.layer.shadowOpacity = 0.5
            newPostImage.layer.shadowRadius = 20
            newPostImage.layer.shadowOffset = CGSize(width: 0, height: 10)
            imageSelected = true
            cameraButton.setImage(nil, for: .normal)
            viewOutline.layer.borderColor = clearColor.cgColor
            
            //viewOutline.layer.borderWidth = nil
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setupTextBoxes() {
        postName.placeholder = "Name"
        postPrice.placeholder = "Price"
        postCategory.placeholder = "Category"
        postSubCategory.placeholder = "Type"
        postYear.placeholder = "Year"
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

