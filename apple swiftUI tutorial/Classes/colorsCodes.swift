//
//  colorsCodes.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

class uiColors: ObservableObject{
    init() {
    }
    static var shared = uiColors()
    @Published var chosableColors: [String] = [
        "FDAC53",
        "9BB7D4",
        "B55A30",
        "F5DF4D",
        "0072B5",
        "A0DAA9",
        "E9897E",
        "00A170",
        "926AA6",
        "D2386C",
        "9A8B4F",
        "E0B589",
        "EFE1CE",
        "939597",
        "363945",
    ]

}

struct colorsCodes: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct colorsCodes_Previews: PreviewProvider {
    static var previews: some View {
        colorsCodes()
    }
}
