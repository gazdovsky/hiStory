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
            Color.mainBeige
        VStack{
            HStack{
//                gradientButton()
            }
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

struct gradientButton: View{
    let gradient: [Color]
    let action: () -> ()
    init(_ gradient: [Color] = [.blue, .purple, .red, .orange, .yellow], action: @escaping () -> ()) {
        self.gradient = gradient
        self.action = action
    }
    var body: some View{
        colorCircleChoser3(color: "00ffffff"){
            action()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: gradient), startPoint: .bottomLeading, endPoint: .topTrailing)
                .mask(colorCircleChoser3(color: "ffffff"){})
                
        )
        
    }
}
struct ToolbarButton: View{
    var icon = "textformat"
    var isSelected = false
    var isPlus = false
    @State var activate: Bool = false
    var size:CGFloat = 40
    var minTappableArrea : CGFloat = 44
    var color: String =  "f4d8c8"
    var action: (()->()) = {}
    var body: some View{
        var img: Image
        var aspectSize: CGSize
        var scale: CGFloat = 1
        if UIImage(systemName: "\(self.icon)") == nil {
            if UIImage(named: "\(self.icon)") != nil {
                aspectSize = UIImage(named: "\(self.icon)")!.size
                scale = aspectSize.height > aspectSize.width ? size / aspectSize.height : size / aspectSize.width
            } else {
                print("dont find ", self.icon)
            }
            img = Image(self.icon)
        } else {
            aspectSize = UIImage(systemName: "\(self.icon)")!.size
            scale = aspectSize.height > aspectSize.width ? size / aspectSize.height : size / aspectSize.width
            img = Image(systemName: "\(self.icon)")
        }
        return Button(action: {
            
            self.action()
        }) {
//            HStack {
                img
//                    .resizable()
//                    .aspectRatio(CGFloat(ratio), contentMode: .fit)
//                    .aspectRatio(aspectSize, contentMode: .fit)

//                    .scaledToFit()
//                                        .frame(width: w, height: h)
                   
//                    .font(.system(size: 1, weight: .regular))
                    .scaleEffect(scale)
                    .frame(width: size, height: size)
                    .padding((minTappableArrea - size)/2 )
                    .foregroundColor(isSelected ? Color(hex: color) : Color.gray)
                    .contentShape(Rectangle())
//                    .fixedSize()
                    
                  
//            }
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
