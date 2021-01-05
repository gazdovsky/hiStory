//
//  TextEditorPanel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI
import UIKit

enum textRedactorToolType {
    case colorPicker
    case size
    case align
    case format
    case nothing
}

enum keyboardState {
    case show
    case hide
}

struct TextEditorPanel: View {
    @ObservedObject var settings: selectorContainerStore = .shared
    @ObservedObject var textData: textContainersFrameData = .shared
//    let gradientStep:CGFloat = 1/8
    let iconSize: CGFloat = 20
    var gradient:AngularGradient {
        let gradientStep:CGFloat = 1/8
        let colors: [Color] = [
            Color(hex: "ff42b5"),
            Color(hex: "6c34ff"),
            Color(hex: "0c7ffe"),
            Color(hex: "13fced"),
            Color(hex: "13e613"),
            Color(hex: "fefb13"),
            Color(hex: "ff9a11"),
            Color(hex: "fe2744")
        ]
       return AngularGradient(gradient: Gradient(
        stops: [.init(color: colors[0], location: 0),
                .init(color: colors[0], location: gradientStep),
                .init(color: colors[1], location: gradientStep),
                .init(color: colors[1], location: gradientStep * 2),
                .init(color: colors[2], location: gradientStep * 2),
                .init(color: colors[2], location: gradientStep * 3),
                .init(color: colors[3], location: gradientStep * 3),
                .init(color: colors[3], location: gradientStep * 4),
                .init(color: colors[4], location: gradientStep * 4),
                .init(color: colors[4], location: gradientStep * 5),
                .init(color: colors[5], location: gradientStep * 5),
                .init(color: colors[5], location: gradientStep * 6),
                .init(color: colors[6], location: gradientStep * 6),
                .init(color: colors[6], location: gradientStep * 7),
                .init(color: colors[7], location: gradientStep * 7),
                .init(color: colors[7], location: 0),
        ]
    ), center:.center)
    }
    @State var val: CGFloat = 0
    @State var aTool: textRedactorToolType = .nothing
    {
        didSet{
            if aTool != .nothing || settings.keyboardHeight > 0{
                settings.redactorOffset = -settings.supposedKeyboardHeight
            } else {
                settings.redactorOffset = 0
            }
            
            
        }
    }
    @State var keyboardState: keyboardState = .show
    {
        didSet{
            if aTool != .nothing || settings.keyboardHeight > 0{
                settings.redactorOffset = -settings.supposedKeyboardHeight
            } else {
                settings.redactorOffset = 0
            }
        }
    }
    var aContainer: Int{
        return settings.activeTextContainer
    }
    let fontList = ["Arial", "Cochin-BoldItalic", "Didot", "Georgia", "Helvetica", "Helvetica-Light", "HelveticaNeue-UltraLight", "HoeflerText-BlackItalic", "HoeflerText-Italic", "IowanOldStyle-BoldItalic", "MarkerFelt-Thin", "Noteworthy-Bold", "Palatino-BoldItalic"]
    @State  var selectedFontIndex = 0
    
    
    var body: some View {
        VStack{
            HStack(alignment: .center, content: {
                ToolbarButton(icon: "trash", isSelected: true, size: iconSize){ //icon_trashBusket
                    textData.textContainers[aContainer].fieldText = " "
                    textData.textContainers[aContainer].fontSize = 0.1
                    settings.deactivateAllTextContainers()
                    settings.redactorMode = .nothing
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading, .trailing])
                .opacity(aTool == .nothing || aTool == .size ? 1 : 0.2)
                Spacer()
                ToolbarButton(icon: "keyboard.chevron.compact.down", isSelected: true, size: iconSize){
                    if keyboardState == .show {
//                        UIApplication.shared.windows.forEach {
//                            $0.endEditing(false)
//                        }
                        textData.textContainers[aContainer].isFirstResponder = false
                        aTool = .nothing
                        keyboardState = .hide
                        settings.redactorOffset = 0
                    } else {
                        textData.textContainers[aContainer].isFirstResponder = true
                        keyboardState = .show
                        aTool = .nothing
                    }
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading,.trailing])
                .rotationEffect(keyboardState == .show ? Angle(degrees: 0) : Angle(degrees: 180))
                
//                Button(action: {
//                    if aTool == .colorPicker {
//                       aTool = .nothing
//                    } else {
//                      aTool = .colorPicker
//                       textData.textContainers[aContainer].isFirstResponder = false
//                        keyboardState = .hide
//                    }
////                    UIApplication.shared.windows.forEach {
////                        $0.endEditing(false)
////                    }
//                    textData.textContainers[aContainer].isFirstResponder = false
//                    keyboardState = .hide
//                }, label: {
//                                        Circle()
//                                            .stroke(lineWidth: 2.5)
//                                            .fill(Color(hex: "f4d8c8"))
//                                            .background(Circle()
//                                                            .fill(gradient)
//                                            )
//                                            .frame(width: iconSize - 2.5, height: iconSize - 2.5)
//                                            .opacity(self.aTool == .nothing || self.aTool == .colorPicker ? 1 : 0.2)
//                    Image("icon_colorPicker")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .opacity(aTool == .nothing || aTool == .colorPicker ? 1 : 0.2)
//                        .padding([.leading])
                    
                    
//                })
                ToolbarButton(icon: "drop", isSelected: true, size: iconSize-5){
                    if aTool == .colorPicker {
                       aTool = .nothing
                    } else {
                      aTool = .colorPicker
                       textData.textContainers[aContainer].isFirstResponder = false
                        keyboardState = .hide
                    }
//                    UIApplication.shared.windows.forEach {
//                        $0.endEditing(false)
//                    }
                    textData.textContainers[aContainer].isFirstResponder = false
                    keyboardState = .hide
                }
                    .foregroundColor(Color(hex: "f4d8c8"))
                    .padding([.leading,.trailing])
                .opacity(aTool == .nothing || aTool == .colorPicker ? 1 : 0.2)
//                ToolbarButton(icon: "textformat.size", isSelected: true, size: 30){ //icon_textSize
//                    if aTool == .size {
//                        aTool = .nothing
//                    } else {
//                        aTool = .size
//                    }
////                    UIApplication.shared.windows.forEach {
////                        $0.endEditing(false)
////                    }
//                    textData.textContainers[aContainer].isFirstResponder = false
//                 keyboardState = .hide
//
//                }
//                .foregroundColor(Color(hex: "f4d8c8"))
//                .padding([.leading])
//                .opacity(aTool == .nothing || aTool == .size ? 1 : 0.2)
                
                ToolbarButton(icon: "slider.horizontal.3", isSelected: true, size: iconSize){  //icon_textAligment
                    if aTool == .align {
                        aTool = .nothing
                    } else {
                        aTool = .align
                    }
//                    UIApplication.shared.windows.forEach {
//                        $0.endEditing(false)
//                    }
                    textData.textContainers[aContainer].isFirstResponder = false
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading,.trailing])
                .opacity(aTool == .nothing || aTool == .align ? 1 : 0.2)
                
                ToolbarButton(icon: "textformat", isSelected: true, size: iconSize){ //icon_textStyle
                    if aTool == .format {
                        aTool = .nothing
                    } else {
                        aTool = .format
                    }
//                    UIApplication.shared.windows.forEach {
//                        $0.endEditing(false)
//                    }
                    textData.textContainers[aContainer].isFirstResponder = false
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading,.trailing])
                .opacity(aTool == .nothing || aTool == .format ? 1 : 0.2)
                
                Spacer()
                
                ToolbarButton(icon: "checkmark.circle", isSelected: true, size: iconSize){
                    //                        UIApplication.shared.windows.forEach { $0.endEditing(false) }
//                    self.textData.textContainers[aContainer].activeTextContainer = 0
                    textData.textContainers[aContainer].isFirstResponder = false
                    textData.textContainers[aContainer].isActive = false
                    settings.deactivateAllTextContainers()
                    settings.redactorOffset = 0
                    aTool = .nothing
                    settings.redactorMode = .nothing
                    keyboardState = .show
                }
                .padding([.leading,.trailing])
            })
            
            Group{ () -> AnyView in
                switch aTool{
                case .colorPicker: return AnyView(
                    VStack(alignment: .center, content: {
                    colorPickerHexWithSaturation(chosenColor: $textData.textContainers[aContainer].fontColor)
                    TextField("hex:" , text:  $textData.textContainers[aContainer].fontColor)
                        .fixedSize()
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                        .background(Color.white)
                        .cornerRadius(5)
                    })
                )
                case .size: return AnyView(
                    Slider(
                    value: $textData.textContainers[aContainer].fontSize,
                        in: 0...100
                )
                    
                .padding([.leading, .trailing])
                )
                case .align: return AnyView(
                    VStack{
                    HStack{
                    ToolbarButton(icon: "text.alignleft", isSelected: true, size: 30){
                        textData.textContainers[aContainer].textAlign = 0
                    }
                    .foregroundColor(Color(hex: "f4d8c8"))
                    .padding([.leading])
                    ToolbarButton(icon: "text.aligncenter", isSelected: true, size: 30){
                        textData.textContainers[aContainer].textAlign = 1
                    }
                    .foregroundColor(Color(hex: "f4d8c8"))
                    .padding([.leading])
                    ToolbarButton(icon: "text.alignright", isSelected: true, size: 30){
                        textData.textContainers[aContainer].textAlign = 2
                    }
                    .foregroundColor(Color(hex: "f4d8c8"))
                    .padding([.leading])
                }
                        Slider(
                        value: $textData.textContainers[aContainer].fontSize,
                        in: 0...100
                    )
                    .padding()
                        Slider(
                            value: $textData.textContainers[aContainer].style.kern,
                        in: 0...10
                    )
                    .padding()
                    }
                )
                case .format: return AnyView(
                    VStack(alignment: .center, content: {
                    pickerFonts()
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        
                     
                        })
                )
                    
                case .nothing: return AnyView(EmptyView())
                }
            }
            .frame(width: nil, height: CGFloat(settings.supposedKeyboardHeight))
        }
    }
}

struct TextEditorPanel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(hex: "#bb8a62")
            TextEditorPanel()
        }
        
    }
}
