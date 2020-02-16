//
//  PostProfileView.swift
//  Toast
//
//  Created by Eric Walters on 2/16/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import UIKit

class PostProfileView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.height/2
        /*layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)*/
        /*
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 5)*/
        layer.applySketchShadow(
        color: .white,
        alpha: 1,
        x: 0,
        y: 3,
        blur: 1,
        spread: 0)
        
        
    }

}

extension CALayer {
  func applySketchShadow(
    color: UIColor = .white,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 5,
    blur: CGFloat = 1,
    spread: CGFloat = 0)
  {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
