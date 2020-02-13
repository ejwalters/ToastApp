//
//  ProfileImage.swift
//  Toast
//
//  Created by Eric Walters on 2/12/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit

class ProfileImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.height/2
    }

}
