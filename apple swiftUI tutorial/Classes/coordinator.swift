//
//  coordinator.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 12.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI



class selectorContainer: systemFilesWorker, ObservableObject {
    enum activeMainPage {
        case templates, draft
    }
    static var shared = selectorContainer()
    @Published var templateName: String = "beige aesthetic 1.json"
    @Published var templateImageName: String = "beige aesthetic 1"
    {
        didSet{
//            templateReserveName = templateImageName
        }
    }
    @Published var templateReserveName: String? = "notshow" {
        willSet{
            if newValue == nil {
//                print("templateReserveName prevented ",newValue)
                return
            }
//            print("templateReserveName",newValue)
        }
    }
    
//    @Published var savedStorys:savedTemplatesData = savedTemplatesData()
    @ObservedObject var draftStories: draftTemplatesData = .shared
    @Published var activeMainPage: activeMainPage = .templates
    @Published var navigateToRedactor: Bool = false
    
    @Published var templateOpacity: Bool = false
    @Published var templateFrame: CGRect = CGRect()
    @Published var tx: CGFloat = 1
    @Published var ty: CGFloat = 1
    @Published var tw: CGFloat = 1
    @Published var th: CGFloat = 1
    @Published var screenOffset: Double = 0
    @Published var isOpenedDraft: Bool = false
    @Published var GlobalIncreaser: CGFloat = 1
    @Published var update: Bool = true
    @Published var showProPurchase: Bool = false
    
//    func getSavedTemplates() -> savedTemplatesData{
//        var folders: [URL]
//        var names: [String] = []
//        var dates: [Date] = []
//        var images: [Image] = []
//         // Set output formate
//
//        do{
//            folders = try getDocumentsDirectory().subDirectories()
//            folders.sort(by: {
//                return $0.appendingPathComponent("draftImage.jpg").customModificationDate?.compare(
//                    $1.appendingPathComponent("draftImage.jpg").customModificationDate ?? Date()) == .orderedDescending
//            })
//            folders.forEach{
//                names.append($0.lastPathComponent)
//                dates.append($0.appendingPathComponent("draftImage.jpg").customModificationDate ?? Date())
//                let imageData = try? Data(contentsOf: $0.appendingPathComponent("draftImage.jpg"))
//                if imageData != nil {
//                    images.append(Image(uiImage: UIImage(data: imageData!)!))
//                }
////                images.append(UIImage( ) ) //$0.appendingPathComponent("draftImage.jpg")
////            print($0)
//            }
//
//        } catch {
//            return savedTemplatesData()
//        }
////        print(source, names, dates)
//        let result:savedTemplatesData = savedTemplatesData(names: names, dates: dates, images: images)
////print(result)
//        return result
//    }

}
