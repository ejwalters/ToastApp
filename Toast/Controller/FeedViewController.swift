//
//  FeedViewController.swift
//  Toast
//
//  Created by Eric Walters on 2/15/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    var posts = [Post]()
    
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid

    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        print("IN FEED VC")
        //setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell{
            cell.configureCell()
            return cell
        } else {
            return PostCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    

    
    //Check if the user's image was downloaded and cached already. If not, Download the user's profile image



}
