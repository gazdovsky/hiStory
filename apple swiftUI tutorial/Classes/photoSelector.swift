//
//  photoSelector.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 12.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI


struct photoSelector: Identifiable, Hashable {
    let id: UUID = UUID()
    var isShowingImagePicker:Bool = false
    var imageInBlackBox:UIImage = UIImage()

    var imageSelected:Bool = false
    var imageZIndex:Double = 0
    var redactorActive:Bool = false
    var transform:transformContainer = transformContainer()
}

struct transformContainer:Codable, Hashable {
    var currentPosition: CGSize = .zero
    var currentScale: CGFloat = 1.0
    var rotate: Double = .zero
    func hash(into hasher: inout Hasher) {
        hasher.combine(currentPosition.width)
        hasher.combine(Double(currentScale))
        hasher.combine(rotate)
    }
}



struct textFieldContainer: Identifiable, Hashable, Codable {
    var id = UUID()
    var fieldText: String = "hello fr"
    var fontSize: CGFloat = 80
    var fontName: String = "Helvetica"
    var fontColor: String = "ecc9af"
    var backgroundColor: String = "00ffffff"
    var shadowColor: String = "00cccccc"
    var textAlign: Int = 1
    var index: Int = -1
    var activeTextContainer: Int = -1
    var isActive: Bool = false
    var isFirstResponder: Bool = false
    var x: CGFloat = 500
    var y: CGFloat = 750
    var containerW: CGFloat = 500 //w 485 h 168
    var containerH: CGFloat = 180
    var z: Int = 0
    var transform: transformTextContainer = transformTextContainer()
    var style: styleTextContainer = styleTextContainer()
    var kern: CGFloat = 1
    
    mutating func setWeight(_ weight: fontWeights){
//        let fontWeights: fontWeights = weight
        if fontName.contains("-"){
            if let dotRange = fontName.range(of: "-") {
                fontName.removeSubrange(dotRange.lowerBound..<fontName.endIndex)
            }
        }
        let fontsList = fontsNamesGlobal
        switch weight {
        case .regular: fontName += fontsList.names[fontName]?.regular ?? ""
        case .bold: fontName += fontsList.names[fontName]?.bold ?? "-Bold"
        case .italic: fontName += fontsList.names[fontName]?.italic ?? "-Italic"
        case .boldItalic:
            fontName += fontsList.names[fontName]?.bolditalic ?? "-BoldItalic"
        }

    }
}

struct transformTextContainer:Codable, Hashable {
    var currentPosition: CGSize = .zero
    var currentContainerW: CGFloat = 100
    var rotate: Double = .zero
    func hash(into hasher: inout Hasher) {
        hasher.combine(currentPosition.width)
        hasher.combine(rotate)
    }
}

struct styleTextContainer: Codable, Hashable {
    var kern: CGFloat = 1
    var obliqueness: CGFloat = 0
    var strokeWidth: CGFloat = 0
    var shadowBlurRadius: CGFloat = 0
    var shadowOffsetHorizontal: CGFloat = 0
    var shadowOffsetVertical: CGFloat = 0
    var underlineStyle: CGFloat = 0 //1 - regular, 2 - bold, 10 - double
    var strikethroughStyle: CGFloat = 0
}


struct textFieldContainerTest: Identifiable, Codable, Hashable {
    var id = UUID()
    var fieldText: String = "Your text"
    var fontSize: CGFloat = 20
    var fontName: String = "Arial"
//    var fontColor: Color = Color(hex: "ecc9af")
    var fontColor: String = "ecc9af"
//    var textAlign: NSTextAlignment = .center
    var index: Int = -1
    var activeTextContainer: Int = -1
    var isActive: Bool = false
    var transform: transformTextContainer = transformTextContainer()
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(currentPosition.width)
//        hasher.combine(Double(currentScale))
//        hasher.combine(rotate)
//        hasher.combine()
//    }
}
