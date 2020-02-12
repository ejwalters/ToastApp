//
//  Constants.swift
//  Toast
//
//  Created by Eric Walters on 2/11/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//


import Foundation
import UIKit

let SHADOW_GRAY: CGFloat = 120.0/255.0

let KEY_UID = "uid"
let PRIMARY_THEME_COLOR = "009C96"
let SECONDARY_THEME_COLOR = "016A6A"
let TERTIARY_THEME_COLOR = "FFC5F3"



@available(iOS 13.0, *)


extension UIViewController {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

