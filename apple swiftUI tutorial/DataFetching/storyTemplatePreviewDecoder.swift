//
//  storyTemplatePreviewDecoder.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 28.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation

struct itemPreview: Codable,  Hashable {
//    let id: String
    let name: String
//    let image: String
//    let renderfile: String
}
struct itemPreviewCategory: Codable,  Hashable {
//    var id : String
    let name: String
    let items: [String]
}
struct newTemplatesCategorys: Codable {
    let names: [String]
}
struct newSingleTemplatesCategory: Codable{
    let names: [String]
}

//func getPlstAsData
let StoryPreviews:[itemPreview] = readPlst("framescopy.json")
let StoryPreviewsCategory:[itemPreviewCategory] = readPlst("templatesCategorys.json")
let TemplatesCategorys:[newTemplatesCategorys] = readPlst("newTemplatesCategorys.json")

let templateWidthDivider = 1.5
//let TestGeo:[TestContainer] = readPlst("testGeom.json")

func readPlst<T: Decodable>(_ fileName: String) -> T {
    guard let path =  Bundle.main.path(forResource: fileName, ofType: nil) else {
//        print(fileName)
        fatalError("Couldn't find  in main bundle.")
    }
   
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)

    
//    let responseDict = try! JSONSerialization.jsonObject(with: data,
//                                                         options: JSONSerialization.ReadingOptions.allowFragments) as! [NSDictionary]
//    print(responseDict[0].allKeys[0] )

    let plst = try! JSONDecoder().decode(T.self, from: data) //for json read
    
    return plst
}

func matches(for regex: String, in text: String) -> [String] {
//    let str = String(decoding: data, as: UTF8.self)
//    let keys = matches(for: #""(\w+)":"#, in: str )
//    print(keys)
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range(at: 1) , in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}
