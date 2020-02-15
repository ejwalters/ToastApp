//
//  Helpers.swift
//  Toast
//
//  Created by Eric Walters on 2/15/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//

import Foundation



func isPasswordValid(_ password : String) -> Bool{
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}
