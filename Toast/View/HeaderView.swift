//
//  HeaderView.swift
//  Toast
//
//  Created by Eric Walters on 2/15/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        //layer.cornerRadius = self.frame.height/2
        layer.shadowOpacity = 0.10
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        //clipsToBounds = false
    }

}
