//
//  CustomTabBarController.swift
//  Toast
//
//  Created by Eric Walters on 2/15/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    @IBOutlet weak var measureTab: UITabBar!
    let button = UIButton.init(type: .custom)
    
    var feedViewController: FeedViewController!
    var profileViewController: ProfileViewController!
    var addPostViewController: AddPostViewController!
    var searchUsersViewController: SearchUsersViewController!
    var activityViewController: ActivityViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        
        feedViewController = FeedViewController()
        profileViewController = ProfileViewController()
        addPostViewController = AddPostViewController()
        searchUsersViewController = SearchUsersViewController()
        activityViewController = ActivityViewController()
        
        setTabs()
        

    }
    override func viewDidLayoutSubviews() {
        //button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 115, width: 64, height: 64)
        //button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.tabBar. - 115, width: 64, height: 64)
        
        let tabBarHeight = 64
        //let mainButton: UIButton = UIButton(type: .custom)
        button.frame = CGRect(origin: CGPoint(x: 0.0, y: self.view.frame.size.height),size: CGSize(width: tabBarHeight, height: tabBarHeight))
        button.center = CGPoint(x: self.view.center.x, y: self.view.frame.size.height - tabBar.layer.bounds.height)
    }
    func setTabs() {
        button.setTitle("", for: .normal)
        button.layer.cornerRadius = 32
        button.setImage(UIImage(named: "addWhite"), for: .normal)
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        button.addTarget(self, action: #selector(CustomTabBarController.menuButtonAction), for: UIControl.Event.touchUpInside)

    }
    
    @objc func menuButtonAction(sender: UIButton) {
       //self.selectedIndex = 2
        //print("ADD POST")
        performSegue(withIdentifier: "goToAddPost", sender: self)
       // console print to verify the button works
       //present(addPostViewController, animated: true)
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
