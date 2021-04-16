//
//  fontsNames.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 23.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

enum fontWeights {
    case regular
    case bold
    case italic
    case boldItalic
}

class fontCases {
    var regular: String
    var bold: String
    var italic: String
    var bolditalic: String
    internal init(regular: String, bold: String, italic: String) {
        self.regular = regular
        self.bold = bold != "" ? "-" + bold : ""
        self.italic = italic != "" ? "-" + italic : ""
        self.bolditalic = bold != "" && italic != "" ? "-" + bold + italic : ""
    }
    internal init(regular: String, bold: String, italic: String, bolditalic: String) {
        self.regular = regular
        self.bold = bold != "" ? "-" + bold : ""
        self.italic = italic != "" ? "-" + italic : ""
        self.bolditalic = bolditalic != "" ? "-" + bolditalic : ""
    }
    convenience init(){
        self.init(regular: "", bold: "Bold", italic: "Italic")
    }
}


class fonts {
    func regularNames() -> [ [String]] {
       var regnames = names.map {
            [$0.key, $0.key + $0.value.regular]
        }
        regnames.sort{
            $0[0] < $1[0]
        }
        return regnames
    }
    init() {
    }
    
    var names: [String : fontCases] = [
        "AmericanTypewriter" : fontCases(regular: "", bold: "Bold", italic: ""),
        "Arial" : fontCases(regular: "", bold: "BoldMT", italic: "ItalicMT", bolditalic: "BoldItalicMT"),
        "Bradley Hand" : fontCases(regular: "", bold: "", italic: ""),
        "ChalkboardSE" : fontCases(regular: "-Regular", bold: "Bold", italic: ""),
        "Cochin" : fontCases(),
        "Copperplate" : fontCases(regular: "", bold: "Bold", italic: ""),
        "Courier" : fontCases(regular: "", bold: "Bold", italic: "Oblique"),
        "DINCondensed" : fontCases(regular: "-Bold", bold: "", italic: ""),
        "Didot" : fontCases(regular: "", bold: "Bold", italic: "Italic", bolditalic: ""),
        "Georgia" : fontCases(),
        "GillSans" : fontCases(regular: "", bold: "UltraBold", italic: "BoldItalic", bolditalic: ""),
        "Helvetica" : fontCases(regular: "", bold: "Bold", italic: "Oblique"),
        "HoeflerText": fontCases(regular: "-Regular", bold: "Black", italic: "Italic"),
        "Menlo" : fontCases(),
        "MarkerFelt" : fontCases(regular: "-Thin", bold: "Wide", italic: "", bolditalic: ""),
        "Noteworthy" : fontCases(regular: "-Light", bold: "Bold", italic: "", bolditalic: ""),
        "Palatino" : fontCases(regular: "-Roman", bold: "", italic: ""),
        "PingFangHK" : fontCases(regular: "-Regular", bold: "Semibold", italic: "", bolditalic: ""),
        "SavoyeLet" : fontCases(regular: "Plain", bold: "", italic: ""),
        "SnellRoundhand" : fontCases(),
        "Verdana" : fontCases(),
        "Zapfino" : fontCases(regular: "", bold: "", italic: ""),
        // JOVANNY FONTS
        "20db" : fontCases(regular: "", bold: "", italic: ""),
        "Accuratist" : fontCases(regular: "", bold: "", italic: ""),
        "Ardeco" : fontCases(regular: "", bold: "", italic: ""),
        "Bender" : fontCases(),
        "Cuprum" : fontCases(regular: "-Regular", bold: "Bold", italic: "Italic"),
        "Days" : fontCases(regular: "", bold: "", italic: ""),
        "DitaSweet" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "EleventhSquare" : fontCases(regular: "", bold: "", italic: ""),
        "Flow" : fontCases(regular: "", bold: "Bold", italic: "", bolditalic: ""),
        "Freeride" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Frenchpress" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Hitchhike" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Imperial One" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Kazmann Sans" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "LemonTuesday" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "London" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Lumberjack" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Magnolia Script" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Matias" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Metro" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Molot" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Neucha" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "NixieOne" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Oranienbaum" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "PeaceSans" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Philosopher" : fontCases(),
        "Prosto" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Romochka" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "RussoOne" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Stig" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Underdog" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "USSR STENCIL" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Wes" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "YesevaOne" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        
        //fontesk
        "Bombardier" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        "Northrup" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
//        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        //        "" : fontCases(regular: "", bold: "", italic: "", bolditalic: ""),
        
        
        
    ]
    
}
