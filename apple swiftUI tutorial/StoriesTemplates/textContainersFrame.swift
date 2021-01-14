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
    
   
    @Published var textContainers:Array<textFieldContainer> = Array(repeating:  textFieldContainer() , count: 2)

    @Published var activeTextContainer = 0
    
    
    func loadTextFieldsFromTemplate(templateImageName: String) -> Void {
        if (Bundle.main.path(forResource: templateImageName + "texts.json", ofType: nil) != nil){
            textContainers = readPlst(templateImageName + "texts.json")
           
            
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
            }

//            textContainers[0] = file[0]
//            textContainers[1] = file[1]
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
               
//                    var w = g.frame.
                ZStack{
                    GeometryReader{ g in
                    let w = g.size.width / CGFloat(1080)
                        
                    ForEach(redactor.textFields.textContainers.indices){ u in
                       return
                        textViewWrapper(
                        textViewItem: $redactor.textFields.textContainers[u],
                        index: u,
                            increaser: w)
//                            .modifier(makeTransformingMultilineText(
//                                        index : u,
//                                        fontSize: redactor.textFields.textContainers[u].fontSize
//                                ))
//                            .position(x: redactor.textFields.textContainers[u].x * w, y: redactor.textFields.textContainers[u].y * w)
//                            .overlay(
//                                VStack(alignment: .trailing , content: {
//                                        Text("current W: \(g.size.width.description) w/1080 = \(g.size.width / CGFloat(1080))")
//                                    Text("font W: \(data.textContainers[u].fontSize)")
//                                        .background(Color.white)
//                                }
//                                )
//                            )
                            .opacity(u == 0 ? 1 : 0)
                            
                        
                    }
                }
                
                }
            )
    }
}

struct textContainersFrame_Previews: PreviewProvider {
    static var previews: some View {
        textContainersFrame()
    }
}
