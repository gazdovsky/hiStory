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
    case align
    case format
    case nothing
}

enum keyboardState {
    case show
    case hide
}

enum colorPickerTarget {
    case text, background, shadow, nothing
}

class textEditorPanelData: ObservableObject{
    init() {
    }
    static var shared = textEditorPanelData()
//    @ObservedObject var redactor: redactorViewData = .shared
    @Published var aTool: textRedactorToolType = .colorPicker
//    @Published var colorPickerTarget: colorPickerTarget = .nothing
    
    
    @Published var isFontSizeEditing: Bool = false
    @Published var isFontKernEditing: Bool = false
//    @Published var keyboardState: keyboardState = .show
  
}

class redactorProxy: ObservableObject{
    init() {
    }
    static var shared = redactorProxy()
    @ObservedObject var redactor: redactorViewData = .shared
}

struct TextEditorPanel: View {
    
//    @ObservedObject var textContainers: textContainersFrameData = .shared
    @ObservedObject var data: textEditorPanelData = .shared
    @ObservedObject var redactorProxy: redactorProxy = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    
    let iconSize: CGFloat = 20
    
    @State var keyboardState: keyboardState = .show
    {
        didSet{
            if data.aTool != .nothing || redactor.keyboardHeight > 0{
                redactor.redactorOffset = Int(-redactor.supposedKeyboardHeight)
            } else {
                redactor.redactorOffset = 0
            }
            print("87 aTool: \(data.aTool), keyboardState: \(keyboardState), redactor.keyboardHeight: \(redactor.keyboardHeight), redactor.redactorOffset: \(redactor.redactorOffset)")
        }
    }
    var aContainer: Int{
        return redactor.textFields.activeTextContainer
    }
    let fontList = ["CourierNewPSMT", "Arial", "Cochin-BoldItalic", "Didot", "Georgia", "Helvetica", "Helvetica-Light", "HelveticaNeue-UltraLight", "HoeflerText-BlackItalic", "HoeflerText-Italic", "IowanOldStyle-BoldItalic", "MarkerFelt-Thin", "Noteworthy-Bold", "Palatino-BoldItalic"]
//    @State  var selectedFontIndex = 0
    
    
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
            HStack(alignment: .center, content: {
                ToolbarButton(icon: "trash", isSelected: true, size: iconSize){ //icon_trashBusket
                    redactor.textFields.textContainers[aContainer].fieldText = " "
                    redactor.textFields.textContainers[aContainer].fontSize = 0.1
                    redactor.textFields.deactivateAllTextContainers()
                    redactor.redactorMode = .nothing
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading, .trailing])
                Spacer()
//                ToolbarButton(icon: "keyboard.chevron.compact.down", isSelected: true, size: iconSize){
//                    if keyboardState == .show {
//                        redactor.textFields.textContainers[aContainer].isFirstResponder = false
//                        data.aTool = .nothing
//                        keyboardState = .hide
//                        redactor.redactorOffset = 0
//                    } else {
//                        redactor.textFields.textContainers[aContainer].isFirstResponder = true
//                        keyboardState = .show
//                        data.aTool = .nothing
//                    }
//                }
//                .foregroundColor(Color(hex: "f4d8c8"))
//                .padding([.leading,.trailing])
//                .rotationEffect(keyboardState == .show ? Angle(degrees: 0) : Angle(degrees: 180))
                
                ToolbarButton(icon: "drop", isSelected: true, size: iconSize-5){
                    if data.aTool == .colorPicker {
                        data.aTool = .nothing
                    } else {
                        data.aTool = .colorPicker
                        redactor.textFields.textContainers[aContainer].isFirstResponder = false
                        keyboardState = .hide
                    }
                    redactor.textFields.textContainers[aContainer].isFirstResponder = false
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading,.trailing])
                .opacity(data.aTool == .nothing || data.aTool == .colorPicker ? 1 : 0.2)
                
                ToolbarButton(icon: "slider.horizontal.3", isSelected: true, size: iconSize){  //icon_textAligment
                    if data.aTool == .align {
                        data.aTool = .nothing
                    } else {
                        data.aTool = .align
                    }
                    redactor.textFields.textContainers[aContainer].isFirstResponder = false
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading,.trailing])
                .opacity(data.aTool == .nothing || data.aTool == .align ? 1 : 0.2)
                
                ToolbarButton(icon: "textformat", isSelected: true, size: iconSize){ //icon_textStyle
                    if data.aTool == .format {
                        data.aTool = .nothing
                    } else {
                        data.aTool = .format
                    }
                    redactor.textFields.textContainers[aContainer].isFirstResponder = false
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading,.trailing])
                .opacity(data.aTool == .nothing || data.aTool == .format ? 1 : 0.2)
                
                Spacer()
                
                ToolbarButton(icon: "checkmark.circle", isSelected: true, size: iconSize){
                    redactor.textFields.textContainers[aContainer].isFirstResponder = false
                    redactor.textFields.textContainers[aContainer].isActive = false
                    redactor.textFields.deactivateAllTextContainers()
                    redactor.redactorOffset = 0
                    data.aTool = .nothing
                    redactor.redactorMode = .nothing
                    keyboardState = .show
                }
                .padding([.leading,.trailing])
            })
            .padding([.top,.bottom])
            .background(Color(hex:"a98162")
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
            )
            Group{ () -> AnyView in
                switch data.aTool{
                case .colorPicker: return AnyView(
//                    VStack(alignment: .center, content: {
//                        HStack{
//                            ToolbarButton(icon: "a", isSelected: true, size: iconSize) { //text
//                                if data.colorPickerTarget == .text {
//                                    data.colorPickerTarget = .nothing
//                                } else {
//                                    data.colorPickerTarget = .text
//                                }
//                            }
//                            .opacity(data.colorPickerTarget == .text || data.colorPickerTarget == .nothing ? 1 : 0.2)
//                            ToolbarButton(icon: "a.square.fill", isSelected: true, size: iconSize) {
//                                if data.colorPickerTarget == .background {
//                                    data.colorPickerTarget = .nothing
//                                } else {
//                                    data.colorPickerTarget = .background
//                                }
//                            }
//                            .opacity(data.colorPickerTarget == .background || data.colorPickerTarget == .nothing ? 1 : 0.2)
//                            
//                            ToolbarButton(icon: "shadow", isSelected: true, size: iconSize) {
//                                if data.colorPickerTarget == .shadow {
//                                    data.colorPickerTarget = .nothing
//                                } else {
//                                    data.colorPickerTarget = .shadow
//                                }
//                            }
//                            .opacity(data.colorPickerTarget == .shadow || data.colorPickerTarget == .nothing ? 1 : 0.2)
//                            ForEach( 0..<6 ) { i in
//                                Circle()
//                                    .frame(width: iconSize, height: iconSize)
//                            }
//                        }
//                        switch data.colorPickerTarget {
//                        case .text:  AnyView( colorPickerHexWithSaturation(chosenColor:$redactor.textFields.textContainers[aContainer].fontColor))
//                        case .background:  AnyView(
//                            colorPickerHexWithSaturation(chosenColor:$redactor.textFields.textContainers[aContainer].backgroundColor))
//                        case .shadow:  AnyView(
//                            colorPickerHexWithSaturation(chosenColor:$redactor.textFields.textContainers[aContainer].shadowColor))
//                        case .nothing:  AnyView(EmptyView())
//                        }
//                        
////                        colorPickerHexWithSaturation(chosenColor:)
//                        TextField("hex:" , text:  $redactor.textFields.textContainers[aContainer].fontColor)
//                            .fixedSize()
//                            .padding([.top, .bottom], 5)
//                            .padding([.leading, .trailing], 10)
//                            .background(Color.white)
//                            .cornerRadius(5)
//                    })
                    textEditorColorPicker()
//                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
//                        .background(Color(hex:"a98162"))
                )
                
               
                case .align: return AnyView(
                   
                    textEditorFormat()
//                    VStack{
////                        Text("\(isFontSizeEditing.description)")
////                        HStack{
////                            ToolbarButton(icon: "text.alignleft", isSelected: true, size: 30){
////                                redactor.textFields.textContainers[aContainer].textAlign = 0
////                            }
////                            .foregroundColor(Color(hex: "f4d8c8"))
////                            .padding([.leading])
////                            ToolbarButton(icon: "text.aligncenter", isSelected: true, size: 30){
////                                redactor.textFields.textContainers[aContainer].textAlign = 1
////                            }
////                            .foregroundColor(Color(hex: "f4d8c8"))
////                            .padding([.leading])
////                            ToolbarButton(icon: "text.alignright", isSelected: true, size: 30){
////                                redactor.textFields.textContainers[aContainer].textAlign = 2
////                            }
////                            .foregroundColor(Color(hex: "f4d8c8"))
////                            .padding([.leading])
////                        }
////                        .hideCondition(isHidden: $data.isFontSizeEditing)
//                        //                        .frame(width: nil, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
////                        .hidden()
//                        HStack{
//                            HStack(alignment: .top, content: {
//                            ToolbarButton(icon: "bold", isSelected: true, size: iconSize)
////                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                            ToolbarButton(icon: "italic", isSelected: true, size: iconSize)
////                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                            ToolbarButton(icon: "underline", isSelected: true, size: iconSize * 1.2)
////                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//
//
////                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                            })
//
//                            ToolbarButton(icon: "arrow.up.and.down", isSelected: true, size: iconSize)
//                        Slider(
//                            value: $redactor.textFields.textContainers[aContainer].fontSize,
//                            in: 15...300
//                        )
////                        .padding([.trailing])
//                        .accentColor(Color(hex: "f4d8c8"))
//                            TextField("size", value: $redactor.textFields.textContainers[aContainer].fontSize, formatter: NumberFormatter(), onEditingChanged: {_ in
//                                data.isFontSizeEditing.toggle()
//                            }
//                            )
//                            .fixedSize()
//                                .keyboardType(.numbersAndPunctuation)
//                        }
//                        .padding([.leading, .trailing])
//                        HStack{
//                            ToolbarButton(icon: "text.alignleft", isSelected: true, size: iconSize){
//                                redactor.textFields.textContainers[aContainer].textAlign = 0
//                            }
////                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                            .foregroundColor(Color(hex: "f4d8c8"))
//                            ToolbarButton(icon: "strikethrough", isSelected: true, size: iconSize){
//                                redactor.textFields.textContainers[aContainer].textAlign = 0
//                            }
////                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                            .foregroundColor(Color(hex: "f4d8c8"))
//
//                            //
//                            ToolbarButton(icon: "a", isSelected: true, size: iconSize){
////                                redactor.textFields.textContainers[aContainer].textAlign = 0
//                            }
////                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                            .padding(0)
//                            .foregroundColor(Color(hex: "f4d8c8"))
//                            ToolbarButton(icon: "a", isSelected: true, size: iconSize){
////                                redactor.textFields.textContainers[aContainer].textAlign = 0
//                            }
//                            .padding(0)
//                            .offset(x: -iconSize*0.69, y: 0)
////                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                            .foregroundColor(Color(hex: "f4d8c8"))
////                            .padding([.leading])
//                            ToolbarButton(icon: "arrow.left.and.right", isSelected: true, size: iconSize)
//                        Slider(
//                            value: $redactor.textFields.textContainers[aContainer].style.kern,
//                            in: 0...15
//                        )
////                        .padding([.trailing])
////                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                        .accentColor(Color(hex: "f4d8c8"))
////                        .frame(width: nil, height: data.isFontSizeEditing ? nil : 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            TextField("kern", value: $redactor.textFields.textContainers[aContainer].style.kern, formatter: NumberFormatter(), onEditingChanged: {_ in
//                                data.isFontKernEditing.toggle()
//                            }
//                            )
//                            .fixedSize()
//
//                                .keyboardType(.numbersAndPunctuation)
//                        }
//                        .padding()
//                        .hideCondition(isHidden: $data.isFontSizeEditing)
//                    }
//                    .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                )
                case .format: return AnyView(
                    ZStack{
                        Color(hex: "a98162")
                                            .shadow(radius: 10 )
                    VStack(alignment: .center, content: {
                        pickerFonts()
                            .frame(width: nil, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                            .mask(
                                Rectangle()
                                    .frame(width: nil, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                            )
                            .contentShape(
                                Rectangle()
                            )
                    })
                }
                )
                
                case .nothing: return AnyView(EmptyView())
                }
            }
            
            .frame(width: nil, height: data.isFontSizeEditing ? nil : CGFloat(redactor.supposedKeyboardHeight))
//            .frame(width: nil, height: CGFloat(redactor.supposedKeyboardHeight))
        })
//        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        //        .padding()
//        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
        
        
    }
}

struct TextEditorPanel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            
            TextEditorPanel()
        }
        .previewDevice("iPhone 8")
        
    }
}
