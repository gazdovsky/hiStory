//
//  textContainersFrame.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 05.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

class textContainersFrameData:systemFilesWorker, ObservableObject{
    
    static var shared = textContainersFrameData()
//    @ObservedObject var storyTemplate: selectorContainerStore = .shared
    
    @Published var textContainers:Array<textFieldContainer> = Array(repeating:  textFieldContainer() , count: 1)

    @Published var activeTextContainer = 0
    
    @Published var centerXLineVisible: Bool = false
    @Published var centerYLineVisible: Bool = false
    
    @Published var activeFontIndex: Int = 0
    @Published var activeFontFamilyName: String = "Arial"
    @Published var isBoldFontWeightEnable: Bool = false
    @Published var isItalicFontWeightEnable: Bool = false
    
    @Published var increaser: CGFloat = 1
    
    func updateWeghtsEnable(){
        let fontsList = fontsNamesGlobal
        if fontsList.names[activeFontFamilyName]?.bold == "" {
            isBoldFontWeightEnable = false
        } else {
            isBoldFontWeightEnable = true
        }
        if fontsList.names[activeFontFamilyName]?.italic == "" {
            isItalicFontWeightEnable = false
        } else {
            isItalicFontWeightEnable = true
        }
        
    }
    func clearAllContainers() -> Void{
        for i in 0...textContainers.count-1{
            textContainers[i] = textFieldContainer()
        }
    }
    func deleteActiveTextContainer() -> Void {
        textContainers[activeTextContainer].fieldText = "."
        textContainers[activeTextContainer].fontColor = "00000000"
        textContainers[activeTextContainer].backgroundColor = "00000000"
        textContainers[activeTextContainer].shadowColor = "00000000"
        textContainers[activeTextContainer].fontSize = 0.0001
        textContainers[activeTextContainer].x = -1000
}
    
    func loadTextFieldsFromTemplate(templateImageName: String) -> Void {
        if (Bundle.main.path(forResource: templateImageName + "texts.JSON", ofType: nil) != nil){
            textContainers = readPlst(templateImageName + "texts.JSON")
        } else {
        }
    }
    
    func indexOfActiveTextContainer() -> Int{
        var active = 0
        var activeCount = 0
        for i in 0..<textContainers.count {
            if textContainers[i].isActive == true{
                active = i
                activeCount += 1
            }
        }
        active = activeCount > 0 ? active : -1
        return active
    }
    
    func deactivateAllTextContainers(){
        activeTextContainer = 0
        for i in 0..<textContainers.count {
            self.textContainers[i].isActive = false
            self.textContainers[i].isFirstResponder = false
        }
    }
    func importTextFields() -> Void{
        if textContainers[0].fieldText != "default" {
        for i in textContainers.indices {
            textContainers[i] = textContainers[i]
        }

        }
    }
    func saveTextContainersToFolder(folder: URL){
        let textData = textContainers
        let encoderText = JSONEncoder()
        let newFolder = folder//createFileDirectory(folderName: templateImageName)
        let filenameText = newFolder.appendingPathComponent("texts.JSON")
        do{let file = try encoderText.encode(textData)
            try file.write(to: filenameText)
        } catch {
    }
        
    }
    func getTransformTextFromFolder(folderName: String){
        
        let decoder = JSONDecoder()
        let folder = getDocumentsDirectory().appendingPathComponent(folderName)
        let name = folder.appendingPathComponent("texts.JSON")
        //        textContainers[0].transform.currentPosition.width *= 2 * (1080/231)
        //        textContainers[0].transform.currentPosition.height *= 2 * (1080/231)
        guard let transformData = try? Data(contentsOf: name) else { return }
        do{
            let textData:[textFieldContainer] = try decoder.decode([textFieldContainer].self, from: transformData)
            for i in 0...textContainers.count-1{
                textContainers[i] = textData[i]
//                print(textData[i].fieldText)
            }
        } catch {
        }
        
    }
}

struct textContainersFrame: View {
    @ObservedObject var data: textContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    
    var body: some View {
        Image(redactor.storyTemplate.templateImageName)
            .resizable()
            .aspectRatio(1080/1920, contentMode: .fit)
            .opacity(0)
            .overlay(
//                ZStack{
                    GeometryReader{ g in
                        let w = g.size.width / CGFloat(1080)
                        ForEach(0 ..< redactor.textFields.textContainers.count, id: \.self){ u -> AnyView in //
                            if u < redactor.textFields.textContainers.count {
                                return AnyView(
                                    textViewWrapper(
                                        textViewItem: $redactor.textFields.textContainers[u],
                                        index: u,
                                        increaser: w)
                                )
                            } else {
                                return AnyView(EmptyView())
                            }
                        }
                        .onAppear(
                            perform: {
                                if g.size.width < 1080 && redactor.storyTemplate.increaser == 1 {
                                    redactor.storyTemplate.increaser = 1080 / g.size.width
                                    data.increaser = 1080 / g.size.width
//                                    print("w:", g.size.width)
                                }
                             
                            }
                        )
                    }
//                }
            )
            .overlay(
                ZStack{
                    Group{
                        Rectangle()
                            .frame(width: 1, height: 1500)
                            .opacity(redactor.textFields.centerXLineVisible ? 1 : 0)
                        Rectangle()
                            .frame(width: 1500 , height: 1)
                            .opacity(redactor.textFields.centerYLineVisible ? 1 : 0)
                    }
                    .foregroundColor(Color.gray)
                }
            )
//            .mask(Rectangle().frame(width: 300, height: 550))
            .onAppear {
    //                     unkomment before build
                if redactor.storyTemplate.isOpenedDraft {
                    redactor.loadAllFromDraft()
                    
                } else {
                    redactor.loadAllFromTemplate()
                }
            }
    }
}

struct textContainersFrame_Previews: PreviewProvider {
    static var previews: some View {
        textContainersFrame()
    }
}
