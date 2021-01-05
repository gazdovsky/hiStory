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
    {
        didSet{
//            var settings: selectorContainerStore = .shared
//            selectorContainerStore.shared.saveTransformToFolder()
//            selectorContainerStore.shared.saveContainerImage(index: 0)
//            selectorContainerStore.shared.saveContainerImage(index: 1)
            print("image is set")
        }
    }
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
    var fieldText: String = "Your text"
    var fontSize: CGFloat = 20
    var fontName: String = "Arial"
    var fontColor: String = "ecc9af"
    var textAlign: Int = 1
    var index: Int = -1
    var activeTextContainer: Int = -1
    var isActive: Bool = false
    var isFirstResponder: Bool = false
    var transform: transformTextContainer = transformTextContainer()
    var style: styleTextContainer = styleTextContainer()
    var kern: CGFloat = 1
}

struct transformTextContainer:Codable, Hashable {
    var currentPosition: CGSize = .zero
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
