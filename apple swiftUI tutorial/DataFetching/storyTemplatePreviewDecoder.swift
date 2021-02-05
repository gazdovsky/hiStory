//
//  storyTemplatePreviewDecoder.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 28.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation

struct itemPreview: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let image: String
    let renderfile: String
}
struct itemPreviewCategory: Codable, Identifiable, Hashable {
    var id : String
    let name: String
    let items: [itemPreview]
}
//func getPlstAsData
let StoryPreviews:[itemPreview] = readPlst("framescopy.json")
let StoryPreviewsCategory:[itemPreviewCategory] = readPlst("templatesCategorys.json")
//let TestGeo:[TestContainer] = readPlst("testGeom.json")

func readPlst<T: Decodable>(_ fileName: String) -> T {
    guard let path =  Bundle.main.path(forResource: fileName, ofType: nil) else {
//        print(fileName)
        fatalError("Couldn't find  in main bundle.")
    }
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)
    let plst = try! JSONDecoder().decode(T.self, from: data) //for json read
    
    
    return plst
}

