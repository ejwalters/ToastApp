//
//  PostProfileImage.swift
//  Toast
//
//  Created by Eric Walters on 2/16/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit

class PerfectCircle: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.height/2
    }

}
