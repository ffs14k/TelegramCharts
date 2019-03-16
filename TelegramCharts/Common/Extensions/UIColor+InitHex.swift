//
//  UIColor+InitHex.swift
//  TelegramCharts
//
//  Created by Eugene on 13/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgbHex: UInt32, alpha: CGFloat = 1) {
        
        let r =  CGFloat((rgbHex & 0xFF0000) >> 16) / 255.0
        let g =  CGFloat((rgbHex & 0xFF00) >> 8) / 255.0
        let b =  CGFloat(rgbHex & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String, alpha: CGFloat, defaultColor: UIColor = .black) {
        
        var hexString = hex
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hex.startIndex)
        }
        
        guard hexString.count == 6 else {
            self.init(red: defaultColor.ciColor.red, green: defaultColor.ciColor.green,
                      blue: defaultColor.ciColor.green, alpha: defaultColor.ciColor.alpha)
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgbValue)
        
        self.init(rgbHex: rgbValue)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }
    
}

