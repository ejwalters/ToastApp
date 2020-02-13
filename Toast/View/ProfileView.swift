//
//  ProfileView.swift
//  Toast
//
//  Created by Eric Walters on 2/12/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.height/2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
        clipsToBounds = false
    }

}
