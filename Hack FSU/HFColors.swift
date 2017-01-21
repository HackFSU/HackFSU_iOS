
//
//  HackFsuColors.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 10/26/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func _lightGrayColor() -> UIColor {
        return colorFromHex(0xD0D0D5)
    }
    
    class func _hackRed() -> UIColor {
        return colorFromHex(0x2F2934)
    }
    
    class func _hackBlue() -> UIColor {
        return colorFromHex(0xA8D3F1)
    }
    
    class func _hackGreen() -> UIColor {
        return colorFromHex(0x8BD1C9)
    }
    
    class func _hackTan() -> UIColor {
        return colorFromHex(0xeecdb5)
    }
    
    class func _hackPurp() -> UIColor {
        return colorFromHex(0x5E2F4F)
    }
    
    
    class func colorFromHex(rgbValue:UInt32) -> UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
