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
    var savedStorys:savedTemplatesData
    {
        if !settings.navigateToRedactor && settings.activeMainPage == .draft {
            return settings.getSavedTemplates()
        } else {
//            return settings.getSavedTemplates()
            return savedTemplatesData(names: [""], dates: [Date()])
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
        var gettedSavedStoryes: savedTemplatesData = savedStorys // //settings.getSavedTemplates()
      return  VStack{
//        Text(gettedSavedStoryes.names.count == 0 ? "Здесь появятся ваши черновики" : "")
//            .padding(.top, gettedSavedStoryes.names.count == 0 ? 40 : 0)
//            Button("reload"){
//                self.reload.toggle()
//                settings.savedStorys = settings.getSavedTemplates(source: "draftView")
//            }
//            Spacer(minLength: 20)
//            Text(getDocumentsDirectory().absoluteString)
//        Text("Черновиков: \(gettedSavedStoryes.names.count)")
//            ForEach(0..<10 ){ n  in
//
        lazyStack(elements: 10, elementsInRow: 2) { n in
//            colorCircleChoser2(color: uiColors.chosableColors[e]){
//                setRecomendColor(index: e)
//            }
            VStack(alignment: .leading){
                if ( n >= gettedSavedStoryes.names.count || gettedSavedStoryes.names.count == 0 ){
//                if ( n == -1){
//                         Text("ff")
//                            .frame(width: 0, height: 0)
                    } else {
//                        Text("\(gettedSavedStoryes.names[n])")
//                        .font(.custom("Baskerville", size: 15))
//                        .fontWeight(.black)
//                        .foregroundColor(Color(hex: "#493412"))
//                        .padding(.all)
                        
                        mainMenuItem(
                            iPreview:
                            gettedSavedStoryes.names[n] == "" ? "empty" : gettedSavedStoryes.names[n],
//                                itemPreview(
//                                id: "0",
//                                name: gettedSavedStoryes.names[n]
//                                image: gettedSavedStoryes.names[n]
//                                renderfile: gettedSavedStoryes.names[n] + ".json"
//                            ),
                             w:self.itemW , h: self.itemH, //isNavigate: $settings.navigateToRedactor,
                            isDraftItem: true
                            
                        )
                        .onAppear{
                            print(gettedSavedStoryes.names.count, n, gettedSavedStoryes.names[n])
                        }
                            .overlay(
                                Button(action:{
                                    settings.templateName = gettedSavedStoryes.names[n] + ".json"
                                    settings.templateImageName = gettedSavedStoryes.names[n]
                                    settings.isOpenedDraft = true
                                    settings.templateOpacity = false
//                                    settings.clearAllContainers()
                                    settings.navigateToRedactor = true
                                   
                                    
                                }, label:{
                                    Rectangle()
                                        .opacity(0.0)
                                }
                                )
                            )
                        .contextMenu {
                            Button {
//                                gettedSavedStoryes.names.remove(at: n)
//                                gettedSavedStoryes.images.remove(at: n)
//                                gettedSavedStoryes.dates.remove(at: n)
                                settings.clearDraftByName(gettedSavedStoryes.names[n])
                                settings.update.toggle()
                            } label: {
                                Text("Delete")
                            }

                        }
                        Text("\(gettedSavedStoryes.dates[n].getFormattedDate(format: "yyyy-MM-dd HH:mm:ss"))")
                            .font(.custom("Baskerville", size: 15))
                            .foregroundColor(Color.elementAccent)
                    }
        }
                }
        .padding(.top, 35)
        .onAppear {
            print(getDocumentsDirectory().absoluteString)
        }
//            }
        Button("Clear all") {
            settings.clearDrafts()
            reload.toggle()
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
