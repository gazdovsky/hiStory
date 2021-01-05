//
//  coordinator.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 12.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

enum redactorMode {
    case nothing
    case textEdit
    case imageEdit
}
class textContainerStore: ObservableObject {
    init() {
    }
    
    static var shared = textContainerStore()
    var tester = 0
    @Published var textContainers:Array<textFieldContainer> = Array(repeating:  textFieldContainer() , count: 5)
    @Published var activeTextContainer = 0
}

class selectorContainerStore: ObservableObject {

    init() {
    }
   
    static var shared = selectorContainerStore()
   
    @Published var score = 0
    @Published var containers:Array<photoSelector> = Array(repeating:  photoSelector() , count: 5)
    @Published var lastActiveContainerIndex = -2
    @Published var templateName: String = "beige aesthetic 1.json"
    @Published var templateImageName: String = "beige aesthetic 1"
    @Published var savedStorys:[String] = [""]
    @Published var navigateToRedactor: Bool = false
    @Published var templateOpacity: Bool = false
    @Published var keyboardHeight: Int = 0
    @Published var supposedKeyboardHeight: Int = 260
    @Published var textContainers:Array<textFieldContainer> = Array(repeating:  textFieldContainer() , count: 5)
    @Published var activeTextContainer = 0
    @Published var redactorMode: redactorMode = .nothing
    @Published var templateFrame: CGRect = CGRect()
    @Published var tx: CGFloat = 1
    @Published var ty: CGFloat = 1
    @Published var tw: CGFloat = 1
    @Published var th: CGFloat = 1
    @Published var screenOffset: Double = 0
    @Published var redactorOffset: Int = 0
    
    
    
    
    var tmp: [storyTemplate] {
        readPlst(templateName)
    }
    var txtfld: [textFieldContainer] {
        if (Bundle.main.path(forResource: templateImageName + "texts.json", ofType: nil) != nil){
        return readPlst(templateImageName + "texts.json")
        } else {
            return readPlst("defaultText.json")
        }
    }
    
    func importTextFields() -> Void{
        if txtfld[0].fieldText != "default" {
        for i in txtfld.indices {
            textContainers[i] = txtfld[i]
        }
        }
    }

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
    func clearAllContainers() -> Void{
        for i in 0...containers.count-1{
            containers[i] = photoSelector()
        }
    }
    func clearContainer(index: Int) -> Void {
        if index == -1 {return}
        containers[index] = photoSelector()
        templateOpacity = false
    }
    func acceptContainerChanges(index: Int) -> Void {
        if index == -1 {return}
        containers[index].redactorActive = false
        templateOpacity = false

        saveContainerImage(index: index)
//        savedStorys = getSavedTemplates()
    }
    func saveContainerImage(index: Int) -> Void {
        let newFolder = createFileDirectory(folderName: templateImageName) //story
//        let newFolder = getDocumentsDirectory().appendingPathComponent(templateImageName)
         saveImageToFolder(image: containers[index].imageInBlackBox, name:"t\(index).jpg", folder: newFolder)
    }
    func saveTransformToFolder(){
        let transformData = [containers[0].transform, containers[1].transform]
        let encoder = JSONEncoder()
        let newFolder = createFileDirectory(folderName: templateImageName) //story
//        let newFolder = getDocumentsDirectory().appendingPathComponent(templateImageName)
        let filename = newFolder.appendingPathComponent("data.JSON")
        do{let file = try encoder.encode(transformData)
            try file.write(to: filename)
//            savedStorys = getSavedTemplates()
        } catch {
        }
    }
    func getTransformFromFolder(){
        let decoder = JSONDecoder()
        let folder = getDocumentsDirectory().appendingPathComponent(templateImageName)
        let name = folder.appendingPathComponent("data.JSON")
        guard let transformData = try? Data(contentsOf: name) else { return }
        
        do{let file:[transformContainer] = try decoder.decode([transformContainer].self, from: transformData)
            containers[0].transform = file[0]
            containers[1].transform = file[1]
//           savedStorys = getSavedTemplates()
        } catch {
        }
    }
    
    func saveImageToFolder(image: UIImage, name:String, folder: URL){
        let data = image.jpegData(compressionQuality: 0.8)
//               let filename = getDocumentsDirectory().appendingPathComponent(name)
        let filename = folder.appendingPathComponent(name)
           do{
            try data?.write(to: filename)
           } catch {
            
           }
    }
    func getImagesFromFolder(folderName:String) -> Void {
        let folder = getDocumentsDirectory().appendingPathComponent(folderName)
        //      _rr = ("\(folder)")
        for i in 0...1 {
            let name = folder.appendingPathComponent("t\(i).jpg")
            let imageData = try? Data(contentsOf: name)
            let image = UIImage(data: imageData!)
          
//            let attributes = try! FileManager.default.attributesOfItem(atPath: name.path)
//            let creationDate1 = attributes[.creationDate] as! Date
            
//            print(creationDate1)
//            print(attributes[.creationDate] as! Date)
            containers[i].imageInBlackBox = image!
            containers[i].imageSelected = true
            containers[i].imageZIndex = 1
        }
    }
    func createFileDirectory(folderName: String) -> URL { 
        let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        //set the name of the new folder
        let folderURL = documentsURL.appendingPathComponent(folderName)
//        print( "\(folderURL)")
        do
        {
             try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
        catch let error as NSError
        {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
        return folderURL
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func getSavedTemplates(source: String) -> [String]{
        var folders: [URL]
        var names: [String] = []
        do{
            folders = try getDocumentsDirectory().subDirectories()
            folders.sort(by: {
                return $0.appendingPathComponent("data.JSON").customModificationDate?.compare($1.appendingPathComponent("data.JSON").customModificationDate ?? Date()) == .orderedDescending
            })
            folders.forEach{
                names.append($0.lastPathComponent)
            }
         print(source, names)
        } catch {
        }
//        print(names)
        return names
    }
    
    func fileModificationDate(url: URL) -> Date? {
    do {
    let attr = try FileManager.default.attributesOfItem(atPath: url.path)
//        _ = attr[.modificationDate] as? Date
//        print(dts)
        return attr[.modificationDate] as? Date
    } catch {
    return nil
    }
    }
    
    func clearDrafts(){
        var folders: [URL]
        do{
            folders = try getDocumentsDirectory().subDirectories()
            do{
                try folders.forEach{ try FileManager.default.removeItem(at: $0)}
            }catch{
            }
        } catch {
        }
    }
    
    func deactivateAllTextContainers(){
        activeTextContainer = 0
        for i in 0..<textContainers.count {
            self.textContainers[i].isActive = false
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
    
    func saveTextContainersToFolder(){
        let transformTextData = [textContainers[0], textContainers[1]]
        let encoderText = JSONEncoder()
        let newFolder = createFileDirectory(folderName: templateImageName)
        let filenameText = newFolder.appendingPathComponent("texts.JSON")
        do{let file = try encoderText.encode(transformTextData)
            try file.write(to: filenameText)
        } catch {
    }
    }
    func getTransformTextFromFolder(){
        let decoder = JSONDecoder()
        let folder = getDocumentsDirectory().appendingPathComponent(templateImageName)
        let name = folder.appendingPathComponent("texts.JSON")
        guard let transformData = try? Data(contentsOf: name) else { return }
        do{let file:[textFieldContainer] = try decoder.decode([textFieldContainer].self, from: transformData)
            textContainers[0] = file[0]
            textContainers[1] = file[1]
        } catch {
        }
    }
    
    func updateSupposedKeyboardHeight() {
        if keyboardHeight == 0{
        } else if keyboardHeight > 0 {
            supposedKeyboardHeight = keyboardHeight
        }
        
        
    }
    
}





//enum TextAlig
