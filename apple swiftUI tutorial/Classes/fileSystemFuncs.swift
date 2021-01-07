//
//  fileSystemFuncs.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 05.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation

class fileSystem {
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
}
