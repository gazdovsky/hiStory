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


struct textEditorColorPicker: View {
//    @ObservedObject var mainEditor: textEditorPanelData = .shared
    @ObservedObject var textContainers: textContainersFrameData = .shared
    @ObservedObject var data: textEditorColorPickerData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    let iconSize: CGFloat = 20
    var aContainer: Int{
                    return redactor.textFields.activeTextContainer
    }
    let bottomPadding = UIApplication.shared.windows[0].safeAreaInsets.bottom
//    var : CGFloat { window.safeAreaInsets.bottom }
    var body: some View {
        ZStack{
            Color(hex: "a98162")
                            .shadow(radius: 10 )
        VStack(alignment: .center, content: {
            HStack{
//                Spacer()
                Button("TEXT") {
                    data.colorPickerTarget = .text
                }
                .foregroundColor(data.colorPickerTarget == .text ? Color(hex: "7d3704") : Color(hex: "f4d9c9"))
                Button("FRAME") {
                    data.colorPickerTarget = .background
                }
                .foregroundColor(data.colorPickerTarget == .background ? Color(hex: "7d3704") : Color(hex: "f4d9c9"))
                Button("DOUBLE") {
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
//            .frame(height: 60)
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

        })
        .padding(.bottom, bottomPadding )
       }

        
        
    }
}

struct textEditorColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        textEditorColorPicker()
            .frame(height: 180)
    }
}
