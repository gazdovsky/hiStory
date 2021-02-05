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
    case format
    case sliders
    case font
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
    @Published var aTool: textRedactorToolType = .nothing
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
    
    let iconSize: CGFloat = 25
    
    @State var keyboardState: keyboardState = .show
    {
        didSet{
            if data.aTool != .nothing || redactor.keyboardHeight > 0{
                redactor.redactorOffset = Int(-redactor.supposedKeyboardHeight)
            } else {
                redactor.redactorOffset = 0
            }
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
                Spacer()
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
                ToolbarButton(icon: "bold.underline", isSelected: true, size: iconSize){
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
                ToolbarButton(icon: "slider.horizontal.3", isSelected: true, size: iconSize){  //icon_textAligment
                    if data.aTool == .sliders {
                        data.aTool = .nothing
                    } else {
                        data.aTool = .sliders
                    }
                    redactor.textFields.textContainers[aContainer].isFirstResponder = false
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading,.trailing])
                .opacity(data.aTool == .nothing || data.aTool == .sliders ? 1 : 0.2)
                ToolbarButton(icon: "textformat", isSelected: true, size: iconSize){
                    if data.aTool == .font {
                        data.aTool = .nothing
                    } else {
                        data.aTool = .font
                    }
                    redactor.textFields.textContainers[aContainer].isFirstResponder = false
                    keyboardState = .hide
                }
                .foregroundColor(Color(hex: "f4d8c8"))
                .padding([.leading,.trailing])
                .opacity(data.aTool == .nothing || data.aTool == .font ? 1 : 0.2)
                Spacer()
            })
            .padding([.top,.bottom], 10)
            .background(Color(hex:"a98162")
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
            )
            Group{ () -> AnyView in
                switch data.aTool{
                case .colorPicker: return AnyView(
                    textEditorColorPicker()
                )
                case .format: return AnyView(
                    textEditorFormat()
                )
                case .sliders: return AnyView(
                    textEditorSliders()
                )
                case .font: return AnyView(
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
        })
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
