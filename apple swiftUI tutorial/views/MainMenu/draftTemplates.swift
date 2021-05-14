//
//  draftTemplates.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 15.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

class draftTemplatesData: systemFilesWorker, ObservableObject {
    override init() {
    }
    static var shared = draftTemplatesData()
//    @ObservedObject var settings: selectorContainerStore =  .shared
//    @Published var drafts: savedTemplatesData = savedTemplatesData()
//    @Published var drafts: [savedStoryTemplateData] = UserDefaults.standard.object(forKey: "drafts") as? [savedStoryTemplateData] ?? [savedStoryTemplateData]
    @Published var draftsNames = UserDefaults.standard.stringArray(forKey: "draftsNames") ?? ["empty"]
   
    func addNameToDrafts(_ name: String) -> Void {
        var draftsNamesForUpdate = draftsNames
        let indexOfDuplicate = draftsNamesForUpdate.lastIndex(of: name)
        
        if indexOfDuplicate != nil {
//            draftsNamesForUpdate.remove(at: indexOfDuplicate!)
            draftsNamesForUpdate[indexOfDuplicate!] = "empty"
        }
        
//        for (index, element) in draftsNames.enumerated() {
//            if element == "empty" {
//                draftsNames.remove(at: index)
//            }
//        }
        
//        draftsNamesForUpdate = draftsNamesForUpdate.filter {$0 != "empty" }
        
        draftsNamesForUpdate.append(name)
        UserDefaults.standard.set(draftsNamesForUpdate, forKey: "draftsNames")
        draftsNames = UserDefaults.standard.stringArray(forKey: "draftsNames") ?? ["empty"]
        print("after addNameToDrafts", draftsNames, UserDefaults.standard.stringArray(forKey: "draftsNames") ?? ["empty"])
    }
    
    func clearDraftsNames() -> Void {
        draftsNames = ["empty"]
        UserDefaults.standard.set(draftsNames, forKey: "draftsNames")
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
        let indexOfDeletingDraft = draftsNames.lastIndex(of: name)
        print("clearDraftByName indexOfDeletingDraft", indexOfDeletingDraft)
        if indexOfDeletingDraft != nil {
//            draftsNames.remove(at: indexOfDeletingDraft!)
            draftsNames[indexOfDeletingDraft!] = "empty"
        }
        UserDefaults.standard.set(draftsNames, forKey: "draftsNames")
        draftsNames = UserDefaults.standard.stringArray(forKey: "draftsNames") ?? ["empty"]
        print("after clearDraftByName", draftsNames, UserDefaults.standard.stringArray(forKey: "draftsNames") ?? ["empty"])
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
        clearDraftsNames()
    }
    func getModificationDateByDraftName(_ name: String) -> String {
        let folderOfDraft = getDocumentsDirectory().appendingPathComponent(name)
        let draftImage = folderOfDraft.appendingPathComponent("draftImage.jpg")
        let draftImaeModificationDate = draftImage.customModificationDate ?? Date()
        return draftImaeModificationDate.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
    }
    func isDraftsNamesEmpty() -> Bool {
        var emptyNamesCount = draftsNames.filter{$0 == "empty"}.count
        return (emptyNamesCount == draftsNames.count || draftsNames.count == 0)
    }
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
//        print( names)
//        let result:savedTemplatesData = savedTemplatesData(names: names, dates: dates, images: images)
////print(result)
//        return result
//    }
}

struct draftTemplates: View{
    
    @ObservedObject var settings: selectorContainer =  .shared
    @ObservedObject var draftStories: draftTemplatesData = .shared
//    var f1 = true
//    var f2 = true
//    static func == (lhs: draftTemplates, rhs: draftTemplates) -> Bool {
//        return lhs.f1 == rhs.f2
//      }
    
    @State var reload: Bool = false
    @State var reloadTwo: String = ""
//    @State var tt = StoryPreviews
    @State var dd = StoryPreviewsCategory
//    var savedStorys:savedTemplatesData
//    {
//        if !settings.navigateToRedactor && settings.activeMainPage == .draft {
//            return settings.getSavedTemplates()
//        } else {
////            return settings.getSavedTemplates()
//            return savedTemplatesData(names: [""], dates: [Date()])
//        }
//
//   }
    @State var screenWidth:CGFloat = UIScreen.main.bounds.width
    @State var isShowingclearAllAlert: Bool = false
    var itemW:CGFloat{
        screenWidth*0.41
    }
    var baseRatio:CGFloat = 1080/1920
    var itemH:CGFloat{
        itemW/baseRatio
    }
    var body: some View{
        

        VStack{
        Text(draftStories.isDraftsNamesEmpty() ? NSLocalizedString("Here you will see 10 recent redacted templates", comment: "Here you will see 10 recent redacted templates") : "")
            .padding([.top, .bottom], draftStories.isDraftsNamesEmpty() ? 40 : 0)
            ForEach(draftStories.draftsNames.indices.reversed() , id: \.self){ n in
            VStack(alignment: .leading){
                if ( n >= draftStories.draftsNames.count || draftStories.draftsNames.count == 0 || draftStories.draftsNames[n] == "empty" ){
                    
                    } else {
                        mainMenuItem(
                            iPreview:
                            draftStories.draftsNames[n] == "" ? "empty" : draftStories.draftsNames[n],
                            w:self.itemW, h: self.itemH,
                            isDraftItem: true,
                            newPreviewImg: Image(uiImage: UIImage(data:
                                                                    try! Data(contentsOf:
                                                                        getDocumentsDirectory()
                                                                        .appendingPathComponent(draftStories.draftsNames[n])
                                                                        .appendingPathComponent("draftImage.jpg")))!)
                        )
                        .contextMenu {
                            Button {
                                draftStories.clearDraftByName(draftStories.draftsNames[n])
                            } label: {
                                Text("Delete")
                            }

                        }
                        Text("\(draftStories.getModificationDateByDraftName(draftStories.draftsNames[n]))")
                            .font(.custom("Baskerville", size: 15))
                            .foregroundColor(Color.elementAccent)

                    }
        }
//                }
            .padding(.top, (n >= draftStories.draftsNames.count || draftStories.isDraftsNamesEmpty() || draftStories.draftsNames[n] == "empty" ) ? 0 : 40)
   
            }
        Button(NSLocalizedString("Clear all", comment: "Clear all")){
//            draftStories.clearDrafts()
            reload.toggle()
            isShowingclearAllAlert = true
        }
        .opacity(draftStories.isDraftsNamesEmpty() ? 0 : 1)
        .padding([.top, .bottom], draftStories.isDraftsNamesEmpty() ? 0 : 40)
//        .padding(draftStories.isDraftsNamesEmpty() ? 0 : nil)
        .alert(isPresented: $isShowingclearAllAlert) {
                    Alert(title: Text(NSLocalizedString("Clear all drafts", comment: "Clear all drafts")),
                          message: Text(NSLocalizedString("Are you sure? This action cannot be undone", comment: "Are you sure? This action cannot be undone")),
                          primaryButton: .default(Text("Cancel"), action: {
                            isShowingclearAllAlert = false
                          }),
                          secondaryButton: .default(Text("Clear all"), action: {
                            draftStories.clearDrafts()
                          })
                    
                    )
                }
       
//            Rectangle()
//                .foregroundColor(.white)
//                .frame(width: nil, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct draftTemplates_Preview: PreviewProvider {
    static var previews: some View{
        draftTemplates()
    }
}
