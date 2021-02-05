//
//  textEditorFormat.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 17.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI
enum toggler {
    case on
    case off
}

enum textAlignToggler: String {
    case left = "text.alignleft"
    case center = "text.aligncenter"
    case right = "text.alignright"
    case justify = "text.justify"
}

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
    var aFont: String{
        return textContainers.textContainers[aContainer].fontName
    }
    @State var bold: toggler = .off
    @State var italic: toggler = .off
    @State var underline: toggler = .off
    @State var strikethrough: toggler = .off
    @State var textAlign: textAlignToggler = .left
    var body: some View {
        ZStack{
            Color(hex: "a98162")
                .shadow(radius: 10 )
            HStack{
                VStack{
                    HStack(alignment: .top, spacing: 26, content: {
                        textStyleButton(icon: "bold", isSelected: bold == .on ? true : false, size: iconSize, disabled: textContainers.isBoldFontWeightEnable ? false : true){
                            if bold == .on && italic == .on{
                                bold = .off
                                textContainers.textContainers[aContainer].setWeight(.italic)
                            } else if bold == .on && italic == .off{
                                bold = .off
                                textContainers.textContainers[aContainer].setWeight(.regular)
                            } else if bold == .off && italic == .on{
                                bold = .on
                                textContainers.textContainers[aContainer].setWeight(.boldItalic)
                            } else if bold == .off && italic == .off{
                                bold = .on
                                textContainers.textContainers[aContainer].setWeight(.bold)
                            }
                        }
                        textStyleButton(icon: "italic", isSelected: italic == .on ? true : false, size: iconSize, disabled: textContainers.isItalicFontWeightEnable ? false : true){
                            if bold == .on && italic == .on{
                                italic = .off
                                textContainers.textContainers[aContainer].setWeight(.bold)
                            } else if bold == .on && italic == .off{
                                italic = .on
                                textContainers.textContainers[aContainer].setWeight(.boldItalic)
                            } else if bold == .off && italic == .on{
                                italic = .off
                                textContainers.textContainers[aContainer].setWeight(.regular)
                            } else if bold == .off && italic == .off{
                                italic = .on
                                textContainers.textContainers[aContainer].setWeight(.italic)
                            }
                        }
                        textStyleButton(icon: "underline", isSelected: underline == .on ? true : false, size: iconSize){
                            if underline == .off {
                                underline = .on
                                textContainers.textContainers[aContainer].style.underlineStyle = 1
                            } else if underline == .on {
                                underline = .off
                                textContainers.textContainers[aContainer].style.underlineStyle = 0
                            }
                            
                        }
                        textStyleButton(icon: textAlign.rawValue, isSelected: false, size: iconSize){
                            if textAlign == .center {
                                textAlign = .right
                                textContainers.textContainers[aContainer].textAlign = 2
                            } else if  textAlign == .right {
                                textAlign = .left
                                textContainers.textContainers[aContainer].textAlign = 0
                            } else if  textAlign == .left {
                                textAlign = .justify
                                textContainers.textContainers[aContainer].textAlign = 3
                            } else if  textAlign == .justify {
                                textAlign = .center
                                textContainers.textContainers[aContainer].textAlign = 1
                            }
                        }
                        textStyleButton(icon: "strikethrough", isSelected: strikethrough == .on ? true : false, size: iconSize){
                            if strikethrough == .off {
                                strikethrough = .on
                                textContainers.textContainers[aContainer].style.strikethroughStyle = 1
                            } else if strikethrough == .on {
                                strikethrough = .off
                                textContainers.textContainers[aContainer].style.strikethroughStyle = 0
                            }
                            
                        }
                        textStyleButton(icon: "a", isSelected: false, size: iconSize)
                    })
                    .padding([.leading, .trailing])
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
