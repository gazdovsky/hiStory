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

struct customImageDataHolder: Identifiable, Hashable {
    var id: UUID = UUID()
    var isShowingImagePicker:Bool = false
    var imageSelected:Bool = false
    var imageInBlackBox:UIImage = UIImage()
    var isActive: Bool = false
    var imageZIndex:Int = 0
    var height: CGFloat = 500
    var width: CGFloat = 500
    var transform: transformContainer = transformContainer()
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


enum textFieldStatus {
    case new
    case invisible
}
struct textFieldContainer: Identifiable, Hashable, Codable {
    var id = UUID()
    var fieldText: String = "Your text"
    var isUppercased: Bool = false
    var fontSize: CGFloat = 80
    var fontName: String = "Helvetica"
    var fontColor: String = "f4d8c8"
    var backgroundColor: String = "00000000"
    var frameCornerRadius: CGFloat = 0
    var shadowColor: String = "00000000"
    var glowColor: String = "00000000"
    var strokeColor: String = "00000000"
    var textAlign: Int = 1
    var index: Int = -1
    var activeTextContainer: Int = -1
    var isActive: Bool = false
    var isFirstResponder: Bool = false
    var x: CGFloat = 1080 / 2
    var y: CGFloat = 1920 / 4
    var containerW: CGFloat = 500 //w 485 h 168
    var containerH: CGFloat = 300
    var z: Int = 0
    var transform: transformTextContainer = transformTextContainer()
    var style: styleTextContainer = styleTextContainer()
    
    
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
    
    func getWeight() -> fontWeights{
        let fontsList = fontsNamesGlobal
//        let name = getFontFamily()
        
        if fontName.contains(fontsList.names[fontName]?.bolditalic ?? "-BoldItalic") {
            return .boldItalic
        }
        if fontName.contains(fontsList.names[fontName]?.italic ?? "-Italic") {
            return .italic
        }
        if fontName.contains(fontsList.names[fontName]?.bold ?? "-Bold") {
            return .bold
        }
        return .regular
    }
    
    func getFontFamily() -> String {
        var name = fontName
        if fontName.contains("-"){
            if let dotRange = fontName.range(of: "-") {
                name.removeSubrange(dotRange.lowerBound..<fontName.endIndex)
            }
        }
        return name
    }
    
    mutating func setTextFieldStatus( _ status: textFieldStatus){
        switch status {
        case .new:
            fieldText = "new text"
        case .invisible:
            fieldText = "invisibletextview"
            z = -1
        }


    }
}

struct transformTextContainer:Codable, Hashable {
    var currentPosition: CGSize = .zero
//    var currentContainerW: CGFloat = 100
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
//    var backgroundBlur: Int = -1 //  0 - 16
}


struct textFieldContainerTest: Identifiable, Codable, Hashable {
    var id = UUID()
    var fieldText: String = "Your text"
    var fontSize: CGFloat = 20
    var fontName: String = "Arial"
    var fontColor: String = "f4d8c8"
    var index: Int = -1
    var activeTextContainer: Int = -1
    var isActive: Bool = false
    var transform: transformTextContainer = transformTextContainer()
}
