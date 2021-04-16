//
//  textEditorSliders.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 23.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

class textEditorSliders_Data: ObservableObject{
    init() {
    }
    static var shared = textEditorSliders_Data()
    @Published var isFontSizeEditing: Bool = false
    @Published var isFontKernEditing: Bool = false
}
enum activeSizeInput {
case size, kern, corner, nothing
    mutating func toggle(_ state: activeSizeInput){
        self = self == state ? .nothing : state
    }
}
struct textEditorSliders: View {
    @ObservedObject var textContainers: textContainersFrameData = .shared
    @ObservedObject var redactorData: textEditorPanelData = .shared
    @ObservedObject var data: textEditorFormat_Data = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    @State var activeInput: activeSizeInput = .nothing
    var aContainer: Int{
        return redactor.textFields.activeTextContainer
    }
    func stateCheck(_ state: activeSizeInput) -> Bool {
       return activeInput == state || activeInput == .nothing
    }
    let labelSize: CGFloat = 15
    var body: some View {
        ZStack(alignment: .top, content: {
            Color.mainBeige
                .shadow(radius: 10 )
            VStack{
                if stateCheck(.size) {
                    HStack{
                        Text("size")
                            .foregroundColor(Color.lightBeige)
                            .frame(width: 50, height: nil)
                        Slider(
                            value: $redactor.textFields.textContainers[aContainer].fontSize,
                            in: 15...300
                        )
                        .accentColor(Color.lightBeige)
                        TextField("000", value: $redactor.textFields.textContainers[aContainer].fontSize, formatter: NumberFormatter(), onEditingChanged: { isFieldActive in
                            if isFieldActive {
                                redactorData.activeInputGroup = .size
                                redactorData.sizeRedactorTarget = .fontSize
                                activeInput = .size
                            } else {
                                redactorData.activeInputGroup = .nothing
                                redactorData.sizeRedactorTarget = .nothing
                                activeInput = .nothing
                            }
                        }
                        )
                        .foregroundColor(Color.lightBeige)
                        .fixedSize()
                        .keyboardType(.numbersAndPunctuation)
                        
                    }
                }
                if stateCheck(.kern) {
                    HStack{
                        Text("kern")
                            .foregroundColor(Color.lightBeige)
                            .frame(width: 50, height: nil)
                        Slider(
                            value: $redactor.textFields.textContainers[aContainer].style.kern,
                            in: 0...50
                        )
                        .accentColor(Color.lightBeige)
                        TextField("000", value: $redactor.textFields.textContainers[aContainer].style.kern, formatter: NumberFormatter(), onEditingChanged: { isFieldActive in
                            if isFieldActive {
                                redactorData.activeInputGroup = .size
                                redactorData.sizeRedactorTarget = .kernSize
                                activeInput = .kern
                            } else {
                                redactorData.activeInputGroup = .nothing
                                redactorData.sizeRedactorTarget = .nothing
                                activeInput = .nothing
                            }
                        }
                        )
                        .foregroundColor(Color.lightBeige)
                        .fixedSize()
                        .keyboardType(.numbersAndPunctuation)
                    }
                }
                
                if stateCheck(.corner){
                    HStack{
                        Text("radius")
                            .foregroundColor(Color.lightBeige)
                            .frame(width: 50, height: nil)
                        Slider(
                            value: $redactor.textFields.textContainers[aContainer].frameCornerRadius ,
                            in: 0...50
                        )
                        .accentColor(Color.lightBeige)
                        TextField("000", value: $redactor.textFields.textContainers[aContainer].frameCornerRadius, formatter: NumberFormatter(), onEditingChanged: { isFieldActive in
                            if isFieldActive {
                                redactorData.activeInputGroup = .size
                                redactorData.sizeRedactorTarget = .kernSize
                                activeInput = .corner
                            } else {
                                redactorData.activeInputGroup = .nothing
                                redactorData.sizeRedactorTarget = .nothing
                                activeInput = .nothing
                            }
                        }
                        )
                        .foregroundColor(Color.lightBeige)
                        .fixedSize()
                        .keyboardType(.numbersAndPunctuation)
                    }
                }
            }
        .padding()
        })
    }
}

struct textEditorSliders_Previews: PreviewProvider {
    static var previews: some View {
        textEditorSliders()
    }
}
