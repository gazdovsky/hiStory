//
//  draftTemplates.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 15.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

struct draftTemplates: View{
    
    @ObservedObject var settings: selectorContainerStore =  .shared
//    var f1 = true
//    var f2 = true
//    static func == (lhs: draftTemplates, rhs: draftTemplates) -> Bool {
//        return lhs.f1 == rhs.f2
//      }
    
    @State var reload: Bool = false
    @State var reloadTwo: String = ""
//    @State var tt = StoryPreviews
    @State var dd = StoryPreviewsCategory
    var savedStorys:[String]
    {
        if !settings.navigateToRedactor  {
            return settings.getSavedTemplates(source: "draft")
        } else {
            return [""]
        }
        
   }
    @State var screenWidth:CGFloat = UIScreen.main.bounds.width
    var itemW:CGFloat{
        screenWidth*0.41
    }
    var baseRatio:CGFloat = 1080/1920
    var itemH:CGFloat{
        itemW/baseRatio
    }
    var body: some View{
        let gettedSavedStoryes: [String] = savedStorys //settings.getSavedTemplates()
      return  VStack{
            Text(gettedSavedStoryes.count == 0 ? "Здесь появятся ваши черновики" : "")
                .padding(.top, gettedSavedStoryes.count == 0 ? 40 : 0)
            Button("reload"){
                self.reload.toggle()
                settings.savedStorys = settings.getSavedTemplates(source: "draftView")
            }
            Spacer(minLength: 20)
            Text(getDocumentsDirectory().absoluteString)
            Text("Черновиков: \(gettedSavedStoryes.count)")
            ForEach(0..<10 ){ n  in
                VStack(alignment: .leading){
                    if ( n >= gettedSavedStoryes.count  || gettedSavedStoryes.count == 0){
                         Text("ff")
                            .frame(width: 0, height: 0)
                    } else {
                        Text("\(gettedSavedStoryes[n])")
                        .font(.custom("Baskerville", size: 19))
                        .fontWeight(.black)
                        .foregroundColor(Color(hex: "#493412"))
                        .padding(.all)
                        
                        mainMenuItem(
                            iPreview:itemPreview(
                                        id: "0",
                                        name: gettedSavedStoryes[n],
                                        image: gettedSavedStoryes[n],
                                        renderfile: gettedSavedStoryes[n] + ".json"),
                                        isNavigate: $settings.navigateToRedactor, w:self.itemW , h: self.itemH,
                            isDraftItem: true
                            )
                            .overlay(
                                Button(action:{
                                    settings.isOpenedDraft = true
                                    settings.templateOpacity = false
//                                    settings.clearAllContainers()
                                    settings.navigateToRedactor = true
                                    settings.templateName = gettedSavedStoryes[n] + ".json"
                                    settings.templateImageName = gettedSavedStoryes[n]
                                }, label:{
                                    Rectangle()
                                        .opacity(0.0)
                                }
                                )
//                                .frame(width: n > settings.getSavedTemplates().count - 1 ? 0 : nil, height: n > settings.getSavedTemplates().count  ? 0 : nil)
//                                .disabled(n > settings.getSavedTemplates().count ? true : false)
                            )
//Text("\(settings.getCreationDateByTemplateName(name: savedStorys[n]) )")
//                    Button("yyy"){
//                        print(settings.getSavedTemplates())
//                    }
//                        var mainFolder = getDocumentsDirectory()
            //                mainFolder.appendingPathComponent($0)
//                        Text("\(getDocumentsDirectory().appendingPathComponent(settings.templateName).creationDate ?? Date())")
                }
                }
                
            }
            Rectangle()
                .foregroundColor(.white)
                .frame(width: nil, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct draftTemplates_Preview: PreviewProvider {
    static var previews: some View{
        draftTemplates()
    }
}
