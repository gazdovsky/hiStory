//
//  ToolbarButton.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 22.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI
struct buttons: View{
    @State var buttonBackgroundOpacity: CGFloat = 0.1
    var body: some View{
        ZStack{
            Color(hex: "a98162")
        VStack{
            HStack{
                ToolbarButton(isSelected: true)
                ToolbarButton()
            }
            HStack{
                textStyleButton(icon: "bold", isSelected: true)
                textStyleButton(icon: "italic", isSelected: true)
                textStyleButton(icon: "underline", isSelected: true)
                textStyleButton(icon: "text.alignleft", isSelected: true)
                textStyleButton(icon: "strikethrough", isSelected: true)
                textStyleButton(icon: "a", isSelected: true)
            }
            HStack{
                textStyleButton(icon: "bold", isSelected: false)
                textStyleButton(icon: "italic", isSelected: false)
                textStyleButton(icon: "underline", isSelected: false)
                textStyleButton(icon: "text.alignleft", isSelected: false)
                textStyleButton(icon: "strikethrough", isSelected: false)
                textStyleButton(icon: "a", isSelected: false)
            }
        }
    }
    }
}
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
                    .contentShape(Rectangle())
            }
        }
    }
}

struct textStyleButton: View{
    var icon = "textformat"
    var isSelected = false
    var size:CGFloat = 40
    var color: String =  "f4d8c8"
    var disabled: Bool = false
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
        })
        {
            HStack {
                img
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .padding(size * 0.2)
                    .foregroundColor(disabled ? Color.gray : Color(hex: color))
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(disabled ? Color.gray : Color(hex: color))
                            .background(Color(hex: color)
                                            .cornerRadius(5)
                                            .opacity(isSelected ? 0.5 : 0))
                    )
            }
            
        }
        .disabled(disabled)
    }
}

struct ToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        
        buttons()
    }
}
