//
//  ToolbarButton.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 22.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct ToolbarButton: View{
    var icon = "textformat"
    var isSelected = false
    var isPlus = false
    var size:CGFloat = 40
    var color: String =  "f4d8c8"
    var action: (()->()) = {}
    var body: some View{
        var img: Image
        if UIImage(systemName: "\(self.icon)") == nil {
            img = Image(self.icon)
        } else {
            img = Image(systemName: "\(self.icon)")
        }
        return Button(action: {
            self.action()
        }) {
            HStack {
                img
                    .resizable()
                  .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundColor(isSelected ? Color(hex: color) : Color.gray)
            }
        }
    }
}


struct ToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarButton()
    }
}
