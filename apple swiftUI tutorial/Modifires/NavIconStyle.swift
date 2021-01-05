//
//  NavIconStyle.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 21.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI
struct NavIconStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 20, height: 20).foregroundColor(Color.black)
    }
}
