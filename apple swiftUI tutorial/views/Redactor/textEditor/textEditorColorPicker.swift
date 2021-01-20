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
    @State var colorPickerType: colorPickerType = .colorCircles
    var aContainer: Int{
        return redactor.textFields.activeTextContainer
    }
    //    let bottomPadding = UIApplication.shared.windows[0].safeAreaInsets.bottom
    //    var : CGFloat { window.safeAreaInsets.bottom }
    var body: some View {
        ZStack{
            Color(hex: "a98162")
                .shadow(radius: 10 )
            VStack(alignment: .center, content: {
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
                    //                Spacer()
                    TextField("hex:" , text:  $textContainers.textContainers[aContainer].fontColor)
                        .fixedSize()
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                        .background(Color.white)
                        .cornerRadius(5)
                }
                
                Group{
                    switch colorPickerType{
                    case .colorCircles:
                        HStack{
                            ToolbarButton(icon: "eyedropper", isSelected: true, size: iconSize){
                                colorPickerType = .gradient
                            }
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
                                .padding([.trailing,.leading],12)
                            })
                        }
                        .padding([.trailing,.leading],12)
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
                        .overlay(
                            HStack(alignment: .top, content: {
                            Spacer()
                                ToolbarButton(icon: "checkmark.circle", isSelected: true, size: 25, color: "fff", action: {
                                    colorPickerType = .colorCircles
                                })
                                .padding()
                            })
                        )
                    }
                }
                
            })
            //        .padding(.bottom, bottomPadding )
        }
        
        
        
    }
}

struct textButtonWithColorIndicateDot: View{
    var text: String
    var color: String
    var action: () -> ()
    var body: some View{
        VStack(spacing:0, content:{
            Button(action: action, label: {
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
            action: action,
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
