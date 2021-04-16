//
//  TextEditorPanel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI
import UIKit

enum textRedactorToolType: String  {
    case textColor = "COLOR"
    case background = "FRAME"
    case double = "DOUBLE"
    case neon = "NEON"
    case stroke = "STROKE"
    case format = "FORMAT"
    case size = "SIZE"
    case font = "FONT"
    case nothing = "NOTHING"
}
enum sizeRedactorTarget {
    case fontSize
    case kernSize
    case roundCornerSize
    case nothing
}
enum activeInputGroup {
    case color
    case size
    case nothing
}
enum keyboardState {
    case show
    case hide
}



class textEditorPanelData: ObservableObject{
    init() {
    }
    static var shared = textEditorPanelData()
    @Published var aTool: textRedactorToolType = .nothing
    
    
    @Published var isFontSizeEditing: Bool = false
    @Published var isFontKernEditing: Bool = false
    
    @Published var colorPickerTarget: colorPickerTarget = .nothing
    @Published var activeInputGroup: activeInputGroup = .nothing
    @Published var sizeRedactorTarget: sizeRedactorTarget = .nothing
}


struct TextEditorPanel: View {
    @ObservedObject var data: textEditorPanelData = .shared
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
    
    func calculateToolbarHeight() -> CGFloat {
        
        if redactor.keyboardHeight == 0 && keyboardState == .show {
//            print("1",redactor.keyboardHeight)
        return CGFloat(redactor.keyboardHeight)
        }
        else if redactor.keyboardHeight == 0 {
//            print("2", redactor.keyboardHeight)
          return CGFloat(redactor.supposedKeyboardHeight)
        } else if data.activeInputGroup != .nothing{
           return CGFloat(redactor.keyboardHeight + 60)
        }
//        print("last", redactor.keyboardHeight)
        return CGFloat(redactor.keyboardHeight)
    }
   
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
            ScrollView(.horizontal, showsIndicators: true, content: {
                HStack(alignment: .center, content: {
                    Group{
                        enumPanelButton(buttonCase: .textColor){
                            redactor.colorPickerData.colorPickerTarget = .text
                        }
                        enumPanelButton(buttonCase: .format)
                        enumPanelButton(buttonCase: .size)
                        enumPanelButton(buttonCase: .font)
                        enumPanelButton(buttonCase: .background){
                            redactor.colorPickerData.colorPickerTarget = .background
                        }
                        enumPanelButton(buttonCase: .double){
                            redactor.colorPickerData.colorPickerTarget = .shadow
                        }
                        enumPanelButton(buttonCase: .neon){
                            redactor.colorPickerData.colorPickerTarget = .glow
                        }
                        enumPanelButton(buttonCase: .stroke){
                            redactor.colorPickerData.colorPickerTarget = .stroke
                        }
                    }
                    .padding([.top,.bottom],10)
                    .simultaneousGesture(TapGesture(count: 1 )
                                            .onEnded{
                                                redactor.textFields.textContainers[aContainer].isFirstResponder = false
                                                keyboardState = .hide
                                            })
                })
            })
//            .frame(width: nil, height: 0) //
            .background(Color.mainBeige
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
            )
            .mask(Rectangle()
                    .offset(x: 0, y: 9)
            )
            .offset(x: 0, y: 7)
            Group{ () -> AnyView in
                switch data.aTool{
                case .textColor: return AnyView(
                    textEditorColorPicker3()
                )
                case .background: return AnyView(
                    textEditorColorPicker3()
                )
                case .double: return AnyView(
                    textEditorColorPicker3()
                )
                case .neon: return AnyView(
                    textEditorColorPicker3()
                )
                case .stroke: return AnyView(
                    textEditorColorPicker3()
                )
                case .format: return AnyView(
                    textEditorFormat()
                )
                case .size: return AnyView(
                    textEditorSliders()
                )
                case .font: return AnyView(
                    ZStack{
                        Color.mainBeige
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
                case .nothing: return AnyView(
                    Rectangle()
                        .foregroundColor(Color.mainBeige)
                )
                }
            }
//            .transition(.slide)
            .frame(width: nil, height: calculateToolbarHeight())
            
           
        })
    }
}

struct enumPanelButton: View {
    @ObservedObject var data: textEditorPanelData = .shared
    @State var buttonCase: textRedactorToolType
    var action: () -> () = {}
    var body: some View {
        
        Button(action: {
            data.aTool = buttonCase
            action()
        }){
            Text(NSLocalizedString(buttonCase.rawValue, comment: "Text format"))
                .padding([.leading,.trailing])
                .padding([.top,.bottom],12)
                .foregroundColor(data.aTool == buttonCase ? Color.textAccent : Color.lightBeige)
        }
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
