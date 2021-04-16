//
//  FetchStoryTemplatePreview.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 28.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

struct storyTemplate: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let containers: [container]?
//    let textfields: [textFieldContainer]?
}

struct container:  Codable, Identifiable, Hashable {
    let id: String
    let x:CGFloat
    let y:CGFloat
    let w:CGFloat
    let h:CGFloat
    var angle:Double = 0
    let z:Int
}

struct textfield: Codable, Identifiable, Hashable {
    let id: String
    let x:Double
    let y:Double
    let angle:Int
    let fontName:String
    let fieldText:String
    let fontSize:CGFloat
}
struct TestContainer: Codable, Identifiable, Hashable {
    let id: String
    let x:CGFloat
    let y:CGFloat
    let w:CGFloat
    let h:CGFloat
    let angle:Int
    let z:Int
}

struct StoryPreview_Previews: PreviewProvider {
    static var previews: some View {
        Text("df")
    }
}
