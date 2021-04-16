//
//  textEditorColorPicker.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 16.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

enum colorPickerTarget3 {
    case text, background, shadow, glow, stroke, nothing
}

class textEditorcolorPickerData3: ObservableObject{
    init(){}
    static var shared = textEditorcolorPickerData3()
    @Published var colorPickerTarget3: colorPickerTarget3 = .nothing
    @Published var colorPickerType: colorPickerType = .colorCircles
    //    @Published var recentColors: String = UserDefaults.standard.string(forKey: "recentColors") ?? "fff"
    //    @Published var recentColors: [String] = ["fff","ccc"]
    @Published var newRecentColors: [String] = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["fff"]

   
    
}

enum colorPickerType3 {
    case colorCircles
    case gradient
}

struct textEditorColorPicker3: View {
    @ObservedObject var uiColors: uiColors = .shared
    @ObservedObject var textContainers: textContainersFrameData = .shared
    @ObservedObject var data: textEditorcolorPickerData3 = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    let iconSize: CGFloat = 20
    let border: CGFloat = 0
    var aContainer: Int{
        return redactor.textFields.activeTextContainer
    }
//    let screenW = UIScreen.main.bounds.width
    let colorPalleteTitleLeadingPadding = (UIScreen.main.bounds.width - (47 * 6 + 12 *  5)) / 2
    var colorTarget: String {
        switch redactor.colorPickerData.colorPickerTarget {
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
   
    func setColorFromSaved(index: Int){
        if index < data.newRecentColors.count{
            print(data.newRecentColors[index])
            switch   redactor.colorPickerData.colorPickerTarget {
       
        case .text:
            textContainers.textContainers[aContainer].fontColor = data.newRecentColors[index]
        case .background:
            textContainers.textContainers[aContainer].backgroundColor = data.newRecentColors[index]
        case .shadow:
            textContainers.textContainers[aContainer].glowColor = "00000000"
            textContainers.textContainers[aContainer].shadowColor = data.newRecentColors[index]
        case .nothing:
            textContainers.textContainers[aContainer].fontColor = data.newRecentColors[index]
        case .glow:
            textContainers.textContainers[aContainer].shadowColor = "00000000"
            textContainers.textContainers[aContainer].glowColor = data.newRecentColors[index]
        case .stroke:
            textContainers.textContainers[aContainer].strokeColor = data.newRecentColors[index]
        }
    }
    }
    func clearColor(){
        switch redactor.colorPickerData.colorPickerTarget {
        case .text:textContainers.textContainers[aContainer].fontColor = "fff"
        case .background:textContainers.textContainers[aContainer].backgroundColor = "00000000"
        case .shadow:textContainers.textContainers[aContainer].shadowColor = "00000000"
        case .nothing:break
        case .glow:textContainers.textContainers[aContainer].glowColor = "00000000"
        case .stroke:textContainers.textContainers[aContainer].strokeColor = "00000000"
        }
    }
    func setRecomendColor(index: Int){
        print(uiColors.chosableColors[index])
        switch redactor.colorPickerData.colorPickerTarget{
        case .text:textContainers.textContainers[aContainer].fontColor = uiColors.chosableColors[index]
        case .background:textContainers.textContainers[aContainer].backgroundColor = uiColors.chosableColors[index]
        case .shadow:textContainers.textContainers[aContainer].glowColor = "00000000"
            textContainers.textContainers[aContainer].shadowColor = uiColors.chosableColors[index]
        case .nothing: break
        case .glow:textContainers.textContainers[aContainer].shadowColor = "00000000"
            textContainers.textContainers[aContainer].glowColor = uiColors.chosableColors[index]
        case .stroke:textContainers.textContainers[aContainer].strokeColor = uiColors.chosableColors[index]
        }
    }
    
    func setOpacityColor(index: Int){
        print(uiColors.opacityColors[index])
        switch redactor.colorPickerData.colorPickerTarget{
        case .text:textContainers.textContainers[aContainer].fontColor = uiColors.opacityColors[index]
        case .background:textContainers.textContainers[aContainer].backgroundColor = uiColors.opacityColors[index]
        case .shadow:textContainers.textContainers[aContainer].glowColor = "00000000"
            textContainers.textContainers[aContainer].shadowColor = uiColors.opacityColors[index]
        case .nothing: break
        case .glow:textContainers.textContainers[aContainer].shadowColor = "00000000"
            textContainers.textContainers[aContainer].glowColor = uiColors.opacityColors[index]
        case .stroke:textContainers.textContainers[aContainer].strokeColor = uiColors.opacityColors[index]
        }
    }
    
    
    
    func setStandartColors(index: Int){
//        print(uiColors.opacityColors[index])
        switch redactor.colorPickerData.colorPickerTarget{
        case .text:textContainers.textContainers[aContainer].fontColor = uiColors.standartColors[index]
        case .background:textContainers.textContainers[aContainer].backgroundColor = uiColors.standartColors[index]
        case .shadow:textContainers.textContainers[aContainer].glowColor = "00000000"
            textContainers.textContainers[aContainer].shadowColor = uiColors.standartColors[index]
        case .nothing: break
        case .glow:textContainers.textContainers[aContainer].shadowColor = "00000000"
            textContainers.textContainers[aContainer].glowColor = uiColors.standartColors[index]
        case .stroke:textContainers.textContainers[aContainer].strokeColor = uiColors.standartColors[index]
        }
    }
    func setBlur(index: Int){
        switch redactor.colorPickerData.colorPickerTarget {
//        case .text: textContainers.textContainers[aContainer].fontColor = "fff"
//        case .background: textContainers.textContainers[aContainer].style.backgroundBlur = index
//        case .shadow: textContainers.textContainers[aContainer].shadowColor = "00000000"
//        case .nothing: break
//        case .glow: textContainers.textContainers[aContainer].glowColor = "00000000"
//        case .stroke: textContainers.textContainers[aContainer].strokeColor = "00000000"
        default: return
        }
    }
    
    var body: some View {
        ZStack{
            Color.mainBeige
                .shadow(radius: 10 )
            ScrollView(.vertical, content:  {
                VStack(alignment: .center, spacing: 0, content: {
                Group{
                    switch data.colorPickerType{
                    case .colorCircles:
//                        colorPalleteTitle("Used")
//                        .padding(.leading, colorPalleteTitleLeadingPadding)
//                        .padding(.bottom,5)
                        HStack{
                            VStack(alignment: .center, content:{
                                colorPalleteTitle("Pallete")
                                    .border(Color.red, width: border)
                            gradientButton {
                                data.colorPickerType = .gradient
                            }
                            })
                            .border(Color.red, width: border)
                            VStack(alignment: .center, content:{
                                colorPalleteTitle("Current")
                                    .border(Color.red, width: border)
                            colorCircleChoser3(color: colorTarget, action: {})
                            .simultaneousGesture(
                                TapGesture(count: 2)
                                           .onEnded {
                                    var newRecentColors = data.newRecentColors
                                    newRecentColors.append(colorTarget)
                                    UserDefaults.standard.set(newRecentColors, forKey:"newRecentColors")
                                            withAnimation { () -> () in
                                    data.newRecentColors = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["ccc"]
                                            }
                                            }
                            )
                            .padding([.trailing,.leading],6)
                                .border(Color.red, width: border)
                            })
                            .border(Color.red, width: border)
                            VStack(alignment: .center, content:{
                                colorPalleteTitle("Saved colors")
                                    .border(Color.red, width: border)
                                ScrollView(.horizontal, showsIndicators: false, content: {
                                HStack(spacing: 12, content:{
                                    Group{
                                    Text("Double tap to save color")
                                        .padding(6)
                                    }
                                    .foregroundColor(Color.white)
                                    .frame(width: data.newRecentColors.count > 0 ? 0 : nil, height: data.newRecentColors.count > 0 ? 0 : nil )

                                    ForEach(data.newRecentColors.indices.reversed(), id: \.self){ u in

                                        colorCircleChoser3(color: data.newRecentColors[u]) {
                                            setColorFromSaved(index: u)
                                        }

                                        .simultaneousGesture(
                                            TapGesture(count: 2)
                                                .onEnded {
                                                    var newRecentColors = data.newRecentColors
                                                    newRecentColors.remove(at: u)
                                                    UserDefaults.standard.set(newRecentColors, forKey:"newRecentColors")
                                                    withAnimation { () -> () in
                                                        data.newRecentColors = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["ccc"]
                                                    }

                                                }
                                        )
                                    }
                                    .transition(AnyTransition.scale)
                                })

                                .padding([ .top, .bottom ],6)

                            })
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        })
                            .border(Color.red, width: border)
                        }
                        .padding([.trailing,.leading],12)
                        
                        colorPalleteTitle("Standart Colors")
                        .padding(.top)
                        .padding(.bottom,5)
                            lazyStack(elements: uiColors.standartColors.count, elementsInRow: 6
                            ) { e in
                                colorCircleChoser3(color: uiColors.standartColors[e]){
                                    setStandartColors(index: e)
                                }
                            }
                        .padding([.trailing,.leading],12)
                        
                        colorPalleteTitle("Color palette 2021")
//                        .padding(.leading, colorPalleteTitleLeadingPadding)
                        .padding(.top)
                        .padding(.bottom,5)
                            lazyStack(elements: uiColors.chosableColors.count, elementsInRow: 6) { e in
                                colorCircleChoser3(color: uiColors.chosableColors[e]){
                                    setRecomendColor(index: e)
                                }
                            }
                        .padding([.trailing,.leading],12)

                        
                       
                        
                        colorPalleteTitle("Opacity Colors")
                        .padding(.top)
                        .padding(.bottom,5)
                            lazyStack(elements: uiColors.opacityColors.count, elementsInRow: 6) { e in
                                colorCircleChoser3(color: uiColors.opacityColors[e]){
                                    setOpacityColor(index: e)
                                }
                            }
                        .padding([.trailing,.leading],12)

                        
                        colorCircleChoser(color: "fff", eraser: redactor.colorPickerData.colorPickerTarget == .text ? false : true){
                           clearColor()
                        }
                        .padding(.top)
                    case .gradient:
                        Group{
                            switch redactor.colorPickerData.colorPickerTarget {
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
                })
            .padding([.top, .bottom])
        }
//        .transition(AnyTransition.scale)
        .animation(Animation.easeInOut)
    }
    
}

struct textButtonWithColorIndicateDot3: View{
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

struct colorPalleteTitle: View {
    let titleText: String
    init(_ titleText: String) {
        self.titleText = titleText
    }
    var body: some View{
        HStack(content: {
            Text(titleText)
                .foregroundColor(Color.lightBeige)
                .font(.custom("Arial", size: 15))

//            Spacer()
        })
    }
}

struct colorCircleChoser3: View{
    var color: String
    
    var circleSize: CGFloat = 47
    var eraser: Bool = false
    var action: () -> ()
    
    var body: some View{
        Button(
            action: {
                action()
            },
            label: {
                RoundedRectangle(cornerRadius: 5)
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

struct textEditorColorPicker3_Previews: PreviewProvider {
//    @ObservedObject var uiColors: uiColors = .shared
//    @ObservedObject var textContainers: textContainersFrameData = .shared
//    @ObservedObject var data: textEditorcolorPickerData3 = .shared
//    @ObservedObject var redactor: redactorViewData = .shared
    static var previews: some View {
        textEditorColorPicker3().environmentObject(textContainersFrameData())
            .frame(height: 180)
    }
}


