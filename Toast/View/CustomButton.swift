//
//  CustomButton.swift
//  Toast
//
//  Created by Eric Walters on 2/11/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 2.0
    }


}
