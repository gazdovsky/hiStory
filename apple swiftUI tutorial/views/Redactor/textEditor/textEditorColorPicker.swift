//
//  textEditorColorPicker.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 16.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

class textEditorColorPickerData: ObservableObject{
    init(){}
    static var shared = textEditorColorPickerData()
    @Published var colorPickerTarget: colorPickerTarget = .text
    @Published var colorPickerType: colorPickerType = .colorCircles
//    @Published var recentColors: String = UserDefaults.standard.string(forKey: "recentColors") ?? "fff"
//    @Published var recentColors: [String] = ["fff","ccc"]
    @Published var newRecentColors: [String] = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["fff"]
}

enum colorPickerType {
    case colorCircles
    case gradient
}

struct textEditorColorPicker: View {
    //    @ObservedObject var mainEditor: textEditorPanelData = .shared
    @ObservedObject var uiColors: uiColors = .shared
    @ObservedObject var textContainers: textContainersFrameData = .shared
    @ObservedObject var data: textEditorColorPickerData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    let iconSize: CGFloat = 20
    var aContainer: Int{
        return redactor.textFields.activeTextContainer
    }
    var body: some View {
        ZStack{
            Color(hex: "a98162")
                .shadow(radius: 10 )
            VStack(alignment: .center, content: {
                Group{
                    switch data.colorPickerType{
                    case .colorCircles:
                        HStack{
                            textButtonWithColorIndicateDot(text: "TEXT", color: textContainers.textContainers[aContainer].fontColor) {
                                data.colorPickerTarget = .text
                            }
                            .foregroundColor(data.colorPickerTarget == .text ? Color(hex: "7d3704") : Color(hex: "f4d9c9"))
                            textButtonWithColorIndicateDot(text: "FRAME", color: textContainers.textContainers[aContainer].backgroundColor) {
                                data.colorPickerTarget = .background
                            }
                            .foregroundColor(data.colorPickerTarget == .background ? Color(hex: "7d3704") : Color(hex: "f4d9c9"))
                            textButtonWithColorIndicateDot(text: "DOUBLE", color: textContainers.textContainers[aContainer].shadowColor) {
                                data.colorPickerTarget = .shadow
                            }
                            .foregroundColor(data.colorPickerTarget == .shadow ? Color(hex: "7d3704") : Color(hex: "f4d9c9"))
                        }
                        HStack{
                            ToolbarButton(icon: "eyedropper", isSelected: true, size: iconSize){
                                data.colorPickerType = .gradient
                            }
                            Group{
                            switch data.colorPickerTarget {
                            case .text:
                                colorCircleChoser(color: textContainers.textContainers[aContainer].fontColor ) {
//                                    textContainers.textContainers[aContainer].fontColor = data.recentColors
                                }
                            case .background:
                                colorCircleChoser(color: textContainers.textContainers[aContainer].backgroundColor ) {
//                                    textContainers.textContainers[aContainer].backgroundColor = data.recentColors
                                }
                            case .shadow:
                                colorCircleChoser(color: textContainers.textContainers[aContainer].shadowColor ) {
//                                    textContainers.textContainers[aContainer].shadowColor = data.recentColors
                                }
                            case .nothing:  colorCircleChoser(color: textContainers.textContainers[aContainer].fontColor ) {}
                            }
                            }
                            .padding([.trailing,.leading],6)
                            ToolbarButton(icon: "arrow.right.circle", isSelected: true, size: iconSize) {
//                                print(UserDefaults.standard.stringArray(forKey: "newRecentColors"))
                                switch data.colorPickerTarget {
                                case .text:
//                                  UserDefaults.standard.set(textContainers.textContainers[aContainer].fontColor, forKey: "recentColors")
//                                    data.recentColors.append("118899")
                                    var newRecentColors = data.newRecentColors
                                    newRecentColors.append(textContainers.textContainers[aContainer].fontColor)
                                    UserDefaults.standard.set(newRecentColors, forKey:"newRecentColors")
                                    data.newRecentColors = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["ccc"]
                                
                                case .background:
//                                    UserDefaults.standard.set(textContainers.textContainers[aContainer].backgroundColor, forKey: "recentColors")
//                                    data.recentColors.append(textContainers.textContainers[aContainer].backgroundColor)
                                    UserDefaults.standard.set(["aaa"], forKey:"newRecentColors")
                                case .shadow:
//                                    UserDefaults.standard.set(textContainers.textContainers[aContainer].shadowColor, forKey: "recentColors")
//                                    data.recentColors.append(textContainers.textContainers[aContainer].shadowColor)
                                return
                                case .nothing:
//                                    UserDefaults.standard.set(textContainers.textContainers[aContainer].fontColor, forKey: "recentColors")
//                                    data.recentColors.append(textContainers.textContainers[aContainer].fontColor)
                                    return
                                }
//                                data.recentColors = UserDefaults.standard.string(forKey: "recentColors") ?? ["fff"]
                            }
                            .padding([.leading],4)
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                HStack(spacing: 12, content:{
                                    ForEach(data.newRecentColors.indices.reversed(), id: \.self){ u in
                                        colorCircleChoser(color: data.newRecentColors[u]) {
                                            switch data.colorPickerTarget {
                                            
                                            case .text:
                                                textContainers.textContainers[aContainer].fontColor = data.newRecentColors[u]
                                            case .background:
                                                textContainers.textContainers[aContainer].backgroundColor = data.newRecentColors[u]
                                            case .shadow:
                                                textContainers.textContainers[aContainer].shadowColor = data.newRecentColors[u]
                                            case .nothing:
                                                textContainers.textContainers[aContainer].fontColor = data.newRecentColors[u]
                                            }
                                        }
//                                        switch data.colorPickerTarget {
//                                        case .text:
//                                            colorCircleChoser(color: textContainers.textContainers[aContainer].fontColor ) {
//                                                textContainers.textContainers[aContainer].fontColor = data.recentColors[u]
//                                            }
//                                        case .background:
//                                            colorCircleChoser(color: textContainers.textContainers[aContainer].backgroundColor ) {
//                                                textContainers.textContainers[aContainer].backgroundColor = data.recentColors[u]
//                                            }
//                                        case .shadow:
//                                            colorCircleChoser(color: textContainers.textContainers[aContainer].shadowColor ) {
//                                                textContainers.textContainers[aContainer].shadowColor = data.recentColors[u]
//                                            }
//                                        case .nothing: colorCircleChoser(color: textContainers.textContainers[aContainer].fontColor ) {}
//                                        }
                                    }
                                    ToolbarButton(icon: "minus.circle", isSelected: true, size: iconSize) {
                                        var newRecentColors = data.newRecentColors
                                        newRecentColors.remove(at: data.newRecentColors.count - 1)
                                        UserDefaults.standard.set(newRecentColors, forKey:"newRecentColors")
                                        data.newRecentColors = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["ccc"]
                                    }
                                })
                                .padding([.leading],6)
                            })
                        }
                        .padding([.trailing,.leading],12)
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            HStack(spacing: 12, content:{
                                colorCircleChoser(color: "fff", eraser: data.colorPickerTarget == .text ? false : true){
                                    switch data.colorPickerTarget {
                                    case .text:
                                        textContainers.textContainers[aContainer].fontColor = "fff"
                                    case .background:
                                        textContainers.textContainers[aContainer].backgroundColor = "00000000"
                                    case .shadow:
                                        textContainers.textContainers[aContainer].shadowColor = "00000000"
                                    case .nothing:
                                        break
                                    }
                                }
                                ForEach(uiColors.chosableColors.indices){ u in
                                    colorCircleChoser(color: uiColors.chosableColors[u]){
                                        switch data.colorPickerTarget {
                                        case .text: textContainers.textContainers[aContainer].fontColor = uiColors.chosableColors[u]
                                        case .background:
                                            textContainers.textContainers[aContainer].backgroundColor = uiColors.chosableColors[u]
                                        case .shadow:
                                            textContainers.textContainers[aContainer].shadowColor = uiColors.chosableColors[u]
                                        case .nothing: break
                                        }
                                    }
                                }
                            })
                            //                            .padding([.trailing,.leading],12)
                        })
                        .padding([.trailing,.leading],12)
                        .padding(.top,6)
                    case .gradient:
                        Group{
                            switch data.colorPickerTarget {
                            case .text:  AnyView(
                                colorPickerHUE_SatBri(chosenColor:$textContainers.textContainers[aContainer].fontColor)
                            )
                            case .background:  AnyView(
                                colorPickerHUE_SatBri(chosenColor:$textContainers.textContainers[aContainer].backgroundColor)
                            )
                            case .shadow:  AnyView(
                                colorPickerHUE_SatBri(chosenColor:$textContainers.textContainers[aContainer].shadowColor)
                            )
                            case .nothing:  AnyView(EmptyView())
                            }
                        }
                    //                        .overlay(
                    //                            HStack(alignment: .top, content: {
                    //                            Spacer()
                    //                                ToolbarButton(icon: "checkmark.circle", isSelected: true, size: 25, color: "fff", action: {
                    //                                    data.colorPickerType = .colorCircles
                    //                                })
                    //                                .padding()
                    //                            })
                    //                        )
                    }
                }
            })
        }
    }
}

struct textButtonWithColorIndicateDot: View{
    var text: String
    var color: String
    var action: () -> ()
    var body: some View{
        VStack(spacing:0, content:{
            Button(action: action,
                   label: {
                    Text(text)
                   })
            Circle()
                .frame(width: 5, height: 5)
                .foregroundColor(Color(hex: color))
        })
        
    }
}

struct colorCircleChoser: View{
    var color: String
    
    var circleSize: CGFloat = 25
    var eraser: Bool = false
    var action: () -> ()
    
    var body: some View{
        Button(
            action: {
                action()
            },
            label: {
                Circle()
                    .frame(width: circleSize, height: circleSize)
                    .foregroundColor(eraser ? Color.white : Color(hex: color))
                    .overlay(
                        Rectangle()
                            .frame(width: 2, height: circleSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.red)
                            .rotationEffect(Angle.degrees(30))
                            .opacity(eraser ? 1 : 0)
                    )
                
            })
    }
}

struct textEditorColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        textEditorColorPicker()
            .frame(height: 180)
    }
}
