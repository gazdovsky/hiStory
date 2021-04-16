//
//  MainEditorPanel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct MainEditorPanel: View {
    @ObservedObject var redactor: redactorViewData = .shared
    @State var sheetOpen: Bool = false
    let fontSize: CGFloat = 15
    var body: some View {
        HStack{
                           VStack{ToolbarButton(icon: "txt2", isSelected: true, size: 30){
                            redactor.textFields.textContainers.append(textFieldContainer(z: redactor.textFields.getNextZIndex()))
                        }
//                           Text("Text")
//                            .font(.custom("Times New Roman", size: fontSize))
//                            .foregroundColor(Color(hex: "ecc9af"))
                           }
                           
//                            Spacer()
//                           VStack{
//                            ToolbarButton(icon: "img2", isSelected: true, size: 30, action: {
//                                redactor.textFields.customPhotoContainers.append(customImageDataHolder(imageZIndex: redactor.textFields.getNextZIndex()))
//                            })
//                           .sheet(isPresented: $sheetOpen){
//                            VStack( spacing: 15, content: {
//                                Button("loadAll") {
//                                    redactor.loadAllFromDraft()
//                                }
//                                Button("chsange text") {
//                                    redactor.textFields.textContainers[0].fieldText = "u"
//                                    redactor.textFields.textContainers[1].fieldText = "i"
//                                    for i in 0..<redactor.textFields.textContainers.count {
//                                        redactor.textFields.textContainers[i].fieldText = "empty"
//                                    }
//                                    redactor.storyTemplate.update.toggle()
//                                }
//                                Button("loadTextfromDraft") {
//                                    redactor.textFields.getTransformTextFromFolder(folderName: redactor.storyTemplate.templateImageName)
//                                }
//                                Button("loadTextfromTemplate") {
//                                    redactor.textFields.loadTextFieldsFromTemplate(templateImageName: redactor.storyTemplate.templateImageName)
//                                }
//                                Text("\(redactor.textFields.textContainers[0].fieldText)")
//                                Text("curent pos\(redactor.textFields.textContainers[0].transform.currentPosition.debugDescription)")
//                                Text("x \(redactor.textFields.textContainers[0].x)")
//                                Text("y \(redactor.textFields.textContainers[0].y)")
//                                Slider(value: $redactor.frameWidth, in: 100...700) {
//                                    Text("\(redactor.frameWidth)")
//                                }
//                            })
//                           }
//                           Text("Image")
//                            .font(.custom("Times New Roman", size: fontSize))
//                            .foregroundColor(Color(hex: "ecc9af"))
//                           }
                        }
//                        .frame(height: 50)
        .padding([.leading,.trailing], 50)
        .padding([.bottom], 30)
    }
}

struct MainEditorPanel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
        Color(hex: "a07554")
        MainEditorPanel()
        }
    }
}
