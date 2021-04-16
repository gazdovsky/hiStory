//
//  systemFilesWorker.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 05.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct savedTemplatesData{
    var names: [String] = [""]
    var dates: [Date] = [Date()]
    var images: [Image] = [Image( systemName: "goforward")]
}

class systemFilesWorker {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveImageToFolder(image: UIImage, name:String, folder: URL, compressionQuality: CGFloat = 1){
        let data = image.jpegData(compressionQuality: compressionQuality)
//               let filename = getDocumentsDirectory().appendingPathComponent(name)
        let filename = folder.appendingPathComponent(name)
           do{
            try data?.write(to: filename)
           } catch {
            
           }
    }
    func savePngImageToFolder(image: UIImage, name:String, folder: URL, compressionQuality: CGFloat = 1){
        let data = image.pngData()
//               let filename = getDocumentsDirectory().appendingPathComponent(name)
        let filename = folder.appendingPathComponent(name)
           do{
            try data?.write(to: filename)
           } catch {
            
           }
    }
    func deleteFileFromFolder(name: String, folder: URL) -> Void {
        do{
            let fileForDelete = folder.appendingPathComponent(name)
            try FileManager.default.removeItem(at: fileForDelete)
        }catch{
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
    
    func clearDraftByName(_ name: String){
        var folders: [URL]
        do{
            folders = try getDocumentsDirectory().subDirectories()
            do {
                try folders.forEach{
                    if $0.lastPathComponent == name {
                    try FileManager.default.removeItem(at: $0)
                        return
                    }
                }
            } catch {
            }
        } catch {
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
  
}
