//
//  UiColor to Color.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 11.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    func uiColor() -> UIColor {
        if #available(iOS 14.0, *) {
            return UIColor(self)
        }
        
let descriptColor = description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let scanner = Scanner(string: descriptColor)
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        
        let result = scanner.scanHexInt64(&hexNumber)
        
        if result {
            r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000FF) / 255
        }
//print(description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted), scanner, "alpha", a)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension Color {
    func uiColor2() -> UIColor{
        let descripoion: String = self.description
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        
        
        //    let str = String(decoding: data, as: UTF8.self)
            let keys = matches(for: #"(\d+\.\d+|\d+)"#, in: descripoion )
//        if keys {
            r = CGFloat( Scanner.init(string: keys[0]).scanFloat() ?? 0 ) //keys[0]
            g = CGFloat( Scanner.init(string: keys[1]).scanFloat() ?? 0 )
            b = CGFloat( Scanner.init(string: keys[2]).scanFloat() ?? 0 )
            a = CGFloat( Scanner.init(string: keys[3]).scanFloat() ?? 0 )
//        }
        //    print(keys)
        
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"%06x", rgb) as String //return NSString(format:"#%06x", rgb) as String
    }

    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

}
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        
        
        let offset = hex.hasPrefix("#") ? 1 : 0
//        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: offset)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
//        }

        return nil
    }
}
