//
//  Constants.swift
//  Toast
//
//  Created by Eric Walters on 2/11/20.
//  Copyright © 2020 Eric Walters. All rights reserved.
//


import Foundation
import UIKit
import MaterialComponents.MaterialTextFields

let SHADOW_GRAY: CGFloat = 120.0/255.0

let KEY_UID = "uid"
let PRIMARY_THEME_COLOR = "009C96"
let SECONDARY_THEME_COLOR = "016A6A"
let TERTIARY_THEME_COLOR = "FFC5F3"
let YEAR_LIST = (1950...2020).map { String($0) }
let CATEGORIES = ["Beer", "Wine", "Spirit", "Other"]

let BEER_SUB_CAT_ARRAY = ["Abbey","Altbier","Amber ale","American pale ale","American wild ale","Baltic porter","Barley wine","Berliner Weisse","Bière de Garde","Bitter","Blonde","Blonde Ale","Bock","Brown ale","Burton Ale","California Common/Steam Beer","Copper ale","Corn beer","Cream Ale","Doppelbock","Dortmunder Export","Dubbel","Dunkel","Dunkelweizen","Eisbock","Flanders red ale","Framboise","Golden/Summer ale","Gose","Grisette","Grodziskie/Grätzer","Gueuze","Hefeweizen","Helles","Imperial stout","India pale ale","Kellerbier","Kentucky common beer","Kölsch","Kriek","Lager","Lambic","Light ale","Light beer","Maibock/Helles bock","Malt liquor","Märzen","Mild","Mild ale","Millet beer","Oktoberfestbier/Märzenbier","Old ale","Oud bruin","Pale ale","Pale ale/Amber ale","Pale ale/Irish red ale","Pale ale/Scotch ale","Pale lager/Helles","Pale lager/Pilsner","Pilsener/Pilsner/Pils","Porter","Pumpkin ale","Quadrupel","Red ale","Roggenbier","Rye beer","Rye beer/Roggenbier","Sahti","Saison","Schwarzbier","Scotch ale","Small beer","Smoked beer","Sour beer","Steam beer","Steinbier","Stout","Trappist","Tripel","Vienna lager","Weissbier","Weizenbock","Wheat beer","Witbier","Zoigl","Zythum"]

let WINE_SUB_CAT_ARRAY = ["Albariño","Aligoté","Amarone","Arneis","Asti Spumante","Auslese","Banylus","Barbaresco","Bardolino","Barolo","Beaujolais","Blanc de Blancs","Blanc de Noirs","Blush","Boal or Bual","Brunello","Cabernet Franc","Cabernet Sauvignon","Carignan","Carmenere","Cava","Charbono","Champagne","Chardonnay","Châteauneuf-du-Pape","Chenin Blanc","Chianti","Chianti Classico","Claret","Colombard (French Colombard)","Constantia","Cortese","Dolcetto","Eiswein","Frascati","Fumé Blanc","Gamay","Gamay Beaujolais","Gattinara","Gewürztraminer","Grappa","Grenache","Johannisberg Riesling","Kir","Lambrusco","Liebfraumilch","Madeira","Malbec","Marc","Marsala","Marsanne","Mead","Meritage","Merlot","Montepulciano","Moscato","Mourvedre","Müller-Thurgau","Muscat","Nebbiolo","Petit Verdot","Petite Sirah","Pinot Blanc","Pinot Grigio/Pinot Gris","Pinot Meunier","Pinot Noir","Pinotage","Port","Retsina","Rosé","Roussanne","Sangiovese","Sauterns","Sauvignon Blanc","Sémillon","Sherry","Soave","Tokay","Traminer","Trebbiano","Ugni Blanc","Valpolicella","Verdicchio","Viognier","Zinfandel"]



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

extension MDCTextField {
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

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}


