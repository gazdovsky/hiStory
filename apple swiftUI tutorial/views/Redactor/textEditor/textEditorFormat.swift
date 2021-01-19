//
//  textEditorFormat.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 17.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

class textEditorFormat_Data: ObservableObject{
    init(){}
    static var shared = textEditorFormat_Data()
    @Published var colorPickerTarget: colorPickerTarget = .nothing
    @Published var isFontSizeEditing: Bool = false
    @Published var isFontKernEditing: Bool = false
}

struct textEditorFormat: View {
    
    @ObservedObject var textContainers: textContainersFrameData = .shared
    @ObservedObject var data: textEditorFormat_Data = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    let border: CGFloat = 0
    let iconSize: CGFloat = 20
    var aContainer: Int{
        return redactor.textFields.activeTextContainer
    }
    
    var body: some View {
        ZStack{
            Color(hex: "a98162")
                                .shadow(radius: 10 )
        HStack{
            VStack{
                
                HStack(alignment: .top, content: {
                    ToolbarButton(icon: "bold", isSelected: true, size: iconSize)
                    ToolbarButton(icon: "italic", isSelected: true, size: iconSize)
                    ToolbarButton(icon: "underline", isSelected: true, size: iconSize * 1.2)
                })
                .padding([.leading, .trailing])
                HStack{
                    ToolbarButton(icon: "text.alignleft", isSelected: true, size: iconSize)
                    ToolbarButton(icon: "strikethrough", isSelected: true, size: iconSize)
                    ToolbarButton(icon: "a", isSelected: true, size: iconSize)
//                    ToolbarButton(icon: "a", isSelected: true, size: iconSize)
//                    .offset(x: -iconSize * 0.69, y: 0)
                }
                .padding([.leading, .trailing])
                .hideCondition(isHidden: $data.isFontSizeEditing)
            }
            VStack{
                HStack{
                    ToolbarButton(icon: "arrow.up.and.down", isSelected: true, size: iconSize)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: border)
                    Slider(
                        value: $redactor.textFields.textContainers[aContainer].fontSize,
                        in: 15...300
                    )
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: border)
                    .accentColor(Color(hex: "f4d8c8"))
                    TextField("000", value: $redactor.textFields.textContainers[aContainer].fontSize, formatter: NumberFormatter(), onEditingChanged: {_ in
                        data.isFontSizeEditing.toggle()
                    }
                    )
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: border)
                    .fixedSize()
                    .keyboardType(.numbersAndPunctuation)
                }
                HStack{
                    ToolbarButton(icon: "arrow.left.and.right", isSelected: true, size: iconSize)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: border)
                    Slider(
                        value: $redactor.textFields.textContainers[aContainer].style.kern,
                        in: 0...15
                    )
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: border)
                    .accentColor(Color(hex: "f4d8c8"))
                    TextField("000", value: $redactor.textFields.textContainers[aContainer].style.kern, formatter: NumberFormatter(), onEditingChanged: {_ in
                        data.isFontKernEditing.toggle()
                    }
                    )
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: border)
                    .fixedSize()
                    .keyboardType(.numbersAndPunctuation)
                }
            }
        }
        
    }
    }
}

struct textEditorFormat_Previews: PreviewProvider {
    static var previews: some View {
        textEditorFormat()
    }
}
