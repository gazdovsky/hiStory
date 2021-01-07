//
//  photoContainersFrame.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 05.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

class photoContainersFrameData:systemFilesWorker, ObservableObject{
    
    static var shared = photoContainersFrameData()
    @ObservedObject var storyTemplate: selectorContainerStore = .shared
    
    @Published var containers:Array<photoSelector> = Array(repeating:  photoSelector() , count: 5)
    
    func indexOfActiveContainer() -> Int {
    var active = 0
    var activeCount = 0
    for i in 0...containers.count-1 {
        if containers[i].redactorActive == true{
            active = i
            activeCount += 1
        }
    }
    active = activeCount > 0 ? active : -1
    return active
}
//    
    func clearAllContainers() -> Void{
        for i in 0...containers.count-1{
            containers[i] = photoSelector()
        }
    }
    func clearContainer(index: Int) -> Void {
        if index == -1 {return}
        containers[index] = photoSelector()
        storyTemplate.templateOpacity = false
    }
//    
    func acceptContainerChanges(index: Int) -> Void {
        if index == -1 {return}
        containers[index].redactorActive = false
        storyTemplate.templateOpacity = false

        saveContainerImage(index: index)
//        savedStorys = getSavedTemplates()
    }
    func saveContainerImage(index: Int) -> Void {
        let newFolder = createFileDirectory(folderName: storyTemplate.templateImageName) //story
//        let newFolder = getDocumentsDirectory().appendingPathComponent(templateImageName)
         saveImageToFolder(image: containers[index].imageInBlackBox, name:"t\(index).jpg", folder: newFolder)
    }
    func saveTransformToFolder(){
        let transformData = [containers[0].transform, containers[1].transform]
        let encoder = JSONEncoder()
        let newFolder = createFileDirectory(folderName: storyTemplate.templateImageName) //story
//        let newFolder = getDocumentsDirectory().appendingPathComponent(templateImageName)
        let filename = newFolder.appendingPathComponent("data.JSON")
        do{let file = try encoder.encode(transformData)
            try file.write(to: filename)
//            savedStorys = getSavedTemplates()
        } catch {
        }
    }
//    func getTransformFromFolder(){
//        let decoder = JSONDecoder()
//        let folder = getDocumentsDirectory().appendingPathComponent(storyTemplate.templateImageName)
//        let name = folder.appendingPathComponent("data.JSON")
//        guard let transformData = try? Data(contentsOf: name) else { return }
//        
//        do{let file:[transformContainer] = try decoder.decode([transformContainer].self, from: transformData)
//            containers[0].transform = file[0]
//            containers[1].transform = file[1]
////           savedStorys = getSavedTemplates()
//        } catch {
//        }
//    }
//    func getImagesFromFolder(folderName:String) -> Void {
//        let folder = getDocumentsDirectory().appendingPathComponent(folderName)
//        //      _rr = ("\(folder)")
//        for i in 0...1 {
//            let name = folder.appendingPathComponent("t\(i).jpg")
//            let imageData = try? Data(contentsOf: name)
//            let image = UIImage(data: imageData!)
//          
////            let attributes = try! FileManager.default.attributesOfItem(atPath: name.path)
////            let creationDate1 = attributes[.creationDate] as! Date
//            
////            print(creationDate1)
////            print(attributes[.creationDate] as! Date)
//            containers[i].imageInBlackBox = image!
//            containers[i].imageSelected = true
//            containers[i].imageZIndex = 1
//        }
//    }
}

struct photoContainersFrame: View {
//    @ObservedObject var data: photoContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    let imgW = CGFloat(1080)
    var tmp: [storyTemplate] {
        readPlst(redactor.storyTemplate.templateName)
    }
    var crnts: [container] {
        tmp[0].containers ?? readPlst("defaultContainer.json")
    }
    var body: some View {
        Image(redactor.storyTemplate.templateImageName)
            .resizable()
            .aspectRatio(1080/1920, contentMode: .fit)
            .opacity(0)
            .overlay(
                GeometryReader{ g in
                    ZStack{
                        Rectangle()
                            .resisable()
                            .shadow(radius: 20)
                            
                            .foregroundColor(Color.white)
                            .opacity(0.3)
                            
                        ForEach(crnts.indices){ index -> AnyView in
                            if(crnts.count <= index ){
                                return AnyView(EmptyView())
                            }
                            let i = crnts[index]
                            if(i.id == "empty" ){
                                return AnyView(EmptyView())
                            }
                            
                            return AnyView  (
                                photoSelectorWithParams(
                                    actualTemplateWith: g.size.width,
                                    actualTemplateHeight: g.size.height,
                                    konstantTemplateWith: imgW,
                                    container: i,
                                    redactorActive: $redactor.photoContainers.containers[index].redactorActive,
                                    templateOpacity: $redactor.storyTemplate.templateOpacity,
                                    index: index)
                                    .onTapGesture {
                                        var activeCount = 0
                                        for indexActive in 0...crnts.count{
                                            if indexActive != index {
                                                redactor.photoContainers.containers[indexActive].redactorActive = false
                                            }
                                            if redactor.photoContainers.containers[indexActive].redactorActive == true {activeCount += 1}
                                        }
                                        redactor.photoContainers.containers[index].redactorActive.toggle()
                                        redactor.storyTemplate.templateOpacity = activeCount == 0 ? true : false
                                        if redactor.photoContainers.containers[index].redactorActive {
                                            redactor.redactorMode = .imageEdit
                                        } else {
                                            redactor.redactorMode = .nothing
                                        }
                                    }
                                    .disabled(!redactor.photoContainers.containers[index].redactorActive && redactor.storyTemplate.templateOpacity)
                                    .zIndex(!redactor.photoContainers.containers[index].redactorActive && redactor.storyTemplate.templateOpacity ? 0 : 2)
                            )
                        }
                        Image(redactor.storyTemplate.templateImageName)
                             .resizable()
                             .zIndex(3)
                             .aspectRatio(1080/1920, contentMode: .fit)
                             .contentShape(
                                 Rectangle()
                                     .size(CGSize(width: 1.0, height: 1.0))
                             )
                            .opacity(redactor.storyTemplate.templateOpacity ? 0.5 : 1)
                    }
                    .onAppear(perform: {
//                            tGeom = g.frame(in: .global)
                    }
                    )
                }
            )
    }
}

struct photoContainersFrame_Previews: PreviewProvider {
    static var previews: some View {
        photoContainersFrame()
    }
}
