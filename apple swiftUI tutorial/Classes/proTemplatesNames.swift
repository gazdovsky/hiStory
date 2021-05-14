//
//  proTemplatesNames.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 30.04.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation
class proTemplates:ObservableObject {
    init() {
        
    }
    static var shared = proTemplates()
    @Published var names: [String] = [
        "summer vibes 5",
        "summer vibes 10",
        "summer vibes 1",
        "boho4",
        "color splash 7",
        "color splash 8",
        "color splash 6",
        "color splash 2",
        "interface 6",
        "interface 1",
        "interface 2",
        "travel 7",
        "travel 5",
        "travel 2",
        "Abstract Shapes8",
        "Abstract Shapes9",
        "Abstract Shapes6",
        "Abstract Shapes3",
        "spring mood 1",
        "spring mood4",
        "spring mood10",
        "spring mood9",
        "bage aestetic 10",
        "bage aestetic 7",
        "bage aestetic 5",
        "color addict9",
        "color addict7",
        "color addict 6",
        "creative channel2",
        "creative channel4"
    ]
   
}
