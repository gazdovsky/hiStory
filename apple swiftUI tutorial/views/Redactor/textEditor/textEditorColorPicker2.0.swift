//
//  textEditorColorPicker.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 16.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI



struct textEditorColorPicker2: View {
    //    @ObservedObject var mainEditor: textEditorPanelData = .shared
    @ObservedObject var uiColors: uiColors = .shared
    @ObservedObject var textContainers: textContainersFrameData = .shared
    @ObservedObject var data: textEditorColorPickerData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    let iconSize: CGFloat = 20
    var aContainer: Int{
        return redactor.textFields.activeTextContainer
    }
    
    var colorTarget: String {
        switch data.colorPickerTarget {
        case .text:
            return textContainers.textContainers[aContainer].fontColor
        case .background:
            return textContainers.textContainers[aContainer].backgroundColor
        case .shadow:
            return textContainers.textContainers[aContainer].shadowColor
        case .glow:
            return textContainers.textContainers[aContainer].glowColor
        case .stroke:
            return textContainers.textContainers[aContainer].strokeColor
        case .nothing:
            return textContainers.textContainers[aContainer].fontColor
        }
    }
   
    
    var body: some View {
        ZStack{
            Color.mainBeige
                .shadow(radius: 10 )
            VStack(alignment: .center, content: {
                Group{
                    switch data.colorPickerType{
                    case .colorCircles:
                        HStack{
                            ToolbarButton(icon: "eyedropper", isSelected: true, size: iconSize){
                                data.colorPickerType = .gradient
                            }
                            colorCircleChoser2(color: colorTarget, action: {
                            } )
                            .simultaneousGesture(
                                TapGesture(count: 2)
                                           .onEnded {
                                    var newRecentColors = data.newRecentColors
                                    newRecentColors.append(colorTarget)
                                    UserDefaults.standard.set(newRecentColors, forKey:"newRecentColors")
                                    data.newRecentColors = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["ccc"]
                                }
                            )
                            .padding([.trailing,.leading],6)
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                HStack(spacing: 12, content:{
                                    ForEach(data.newRecentColors.indices.reversed(), id: \.self){ u in
                                        colorCircleChoser2(color: data.newRecentColors[u]) {
                                            if u < data.newRecentColors.count{
                                            switch data.colorPickerTarget {
                                            
                                            case .text:
                                                textContainers.textContainers[aContainer].fontColor = data.newRecentColors[u]
                                            case .background:
                                                textContainers.textContainers[aContainer].backgroundColor = data.newRecentColors[u]
                                            case .shadow:
                                                textContainers.textContainers[aContainer].glowColor = "00000000"
                                                textContainers.textContainers[aContainer].shadowColor = data.newRecentColors[u]
                                            case .nothing:
                                                textContainers.textContainers[aContainer].fontColor = data.newRecentColors[u]
                                            case .glow:
                                                textContainers.textContainers[aContainer].shadowColor = "00000000"
                                                textContainers.textContainers[aContainer].glowColor = data.newRecentColors[u]
                                            case .stroke:
                                                textContainers.textContainers[aContainer].strokeColor = data.newRecentColors[u]
                                            }
                                        }
                                        }
                                        .simultaneousGesture(
                                            TapGesture(count: 2)
                                                .onEnded {
                                                    var newRecentColors = data.newRecentColors
                                                    newRecentColors.remove(at: u)
                                                    UserDefaults.standard.set(newRecentColors, forKey:"newRecentColors")
                                                    data.newRecentColors = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["ccc"]
                                                }
                                        )
                                        
                                    }
                                })
                                .padding([.leading],6)
                            })
                        }
                        .padding([.trailing,.leading],12)
                  
                        
                        
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            HStack(spacing: 12, content:{
                                colorCircleChoser2(color: "fff", eraser: data.colorPickerTarget == .text ? false : true){
                                    switch data.colorPickerTarget {
                                    case .text:textContainers.textContainers[aContainer].fontColor = "fff"
                                    case .background:textContainers.textContainers[aContainer].backgroundColor = "00000000"
                                    case .shadow:textContainers.textContainers[aContainer].shadowColor = "00000000"
                                    case .nothing:break
                                    case .glow:textContainers.textContainers[aContainer].glowColor = "00000000"
                                    case .stroke:textContainers.textContainers[aContainer].strokeColor = "00000000"
                                    }
                                }
                                ForEach(uiColors.chosableColors.indices){ u in
                                    colorCircleChoser2(color: uiColors.chosableColors[u]){
                                        switch data.colorPickerTarget {
                                        case .text:textContainers.textContainers[aContainer].fontColor = uiColors.chosableColors[u]
                                        case .background:textContainers.textContainers[aContainer].backgroundColor = uiColors.chosableColors[u]
                                        case .shadow:textContainers.textContainers[aContainer].glowColor = "00000000"
                                            textContainers.textContainers[aContainer].shadowColor = uiColors.chosableColors[u]
                                        case .nothing: break
                                        case .glow:textContainers.textContainers[aContainer].shadowColor = "00000000"
                                            textContainers.textContainers[aContainer].glowColor = uiColors.chosableColors[u]
                                        case .stroke:textContainers.textContainers[aContainer].strokeColor = uiColors.chosableColors[u]
                                        }
                                    }
                                }
                            })
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
                            case .glow: colorPickerHUE_SatBri(chosenColor:$textContainers.textContainers[aContainer].glowColor)
                            case .stroke: colorPickerHUE_SatBri(chosenColor:$textContainers.textContainers[aContainer].strokeColor)
                            }
                        }
                    }
                }
            })
        }
    }
    
}


struct textButtonWithColorIndicateDot2: View{
    var text: String
//    var color: String
    var action: () -> ()
    var body: some View{
        VStack(spacing:0, content:{
            Button(action: action,
                   label: {
                    Text(text)
                   })
//            Circle()
//                .frame(width: 5, height: 5)
//                .foregroundColor(Color(hex: color))
        })
        
    }
}

struct colorCircleChoser2: View{
    var color: String
    
    var circleSize: CGFloat = 40
    var eraser: Bool = false
    var action: () -> ()
    
    var body: some View{
        Button(
            action: {
                action()
            },
            label: {
                Rectangle()
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

struct textEditorColorPicker2_Previews: PreviewProvider {
//    @ObservedObject var uiColors: uiColors = .shared
//    @ObservedObject var textContainers: textContainersFrameData = .shared
//    @ObservedObject var data: textEditorColorPickerData = .shared
//    @ObservedObject var redactor: redactorViewData = .shared
    static var previews: some View {
        textEditorColorPicker2().environmentObject(textContainersFrameData())
            .frame(height: 180)
    }
}
