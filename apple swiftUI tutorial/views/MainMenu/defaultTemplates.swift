//
//  defoultTemplates.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 15.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

struct defaultTemplates: View {
    @ObservedObject var settings: selectorContainer =  .shared
//    @State var tt = StoryPreviews
    @State var dd = StoryPreviewsCategory
    @State var categorys = TemplatesCategorys
    @State var screenWidth:CGFloat = UIScreen.main.bounds.width
    @ObservedObject var proTemplates: proTemplates = .shared
    @ObservedObject var manager: manager = .shared
    var itemW:CGFloat{
        screenWidth*0.28 //screenWidth*0.41
    }
    var baseRatio:CGFloat = 1080/1920
    var itemH:CGFloat{
        itemW/baseRatio
    }
    @State var counter: Int = 0
    
    var body: some View{
        VStack{
            Spacer(minLength: 20)
            
        ForEach(0..<dd.count){ n in
            VStack(alignment: .leading){
                Text("\(dd[n].name)")
                    .font(.custom("Baskerville", size: 19))
                    .fontWeight(.black)
                    .foregroundColor(Color.elementAccent)
                    .padding(.all)

                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack( spacing: screenWidth * 0.03 , content:{
//                        Spacer(minLength : screenWidth * 0.03) //                        Spacer(minLength: (screenWidth - itemW*3)/4)

                        ForEach(0 ..< dd[n].items.count){i in
                            mainMenuItem(iPreview:  dd[n].items[i]  ,  w:self.itemW , h: self.itemH, isDraftItem: false,
                                         isPro: (proTemplates.names.firstIndex(of: dd[n].items[i]) != nil) &&
                                         (!UserDefaults.standard.bool(forKey: "com.davagaz.historyPro.Year") &&
                                           !UserDefaults.standard.bool(forKey: "com.davagaz.historyPro.Month")) ,
                                         newPreviewImg: Image(dd[n].items[i] + "_PREVIEW")
                                         ) //isNavigate: $settings.navigateToRedactor,
//                                    .overlay(
//                                        Button(action:{
//                                            if proTemplates.names.firstIndex(of: dd[n].items[i]) != nil &&
//                                                (!UserDefaults.standard.bool(forKey: "com.davagaz.historyPro.Year") &&
//                                                  !UserDefaults.standard.bool(forKey: "com.davagaz.historyPro.Month"))
//                                                {
//                                                settings.showProPurchase = true
//                                            } else {
//                                                print("item tap")
//                                                settings.isOpenedDraft = false
//                                                settings.navigateToRedactor = true
//                                                
//                                                settings.templateName = dd[n].items[i] + ".json"
//                                                settings.templateImageName = dd[n].items[i]
//                                                settings.templateReserveName = dd[n].items[i]
//                                            }
//                                         
//                                        }, label:{
//                                            Rectangle()
//                                                .opacity(0.0)
//                                        }
//                                        )
//                                    )
//                                    .onAppear {
//                                        counter += 1
//                                        print(counter)
//                                    }
                        }
//                        Spacer(minLength: 100) //Spacer(minLength: (screenWidth - itemW*2)/3)
                    })
//                    .onAppear(perform: {
//                        print(dd[n].items.count)
//                    })
                    .padding([.leading, .trailing], screenWidth * 0.03)
                })

            }
            .padding(.bottom)
            
            Divider()
                
        }
        
        }
       
    }
    
//    var body: some View{
//        VStack{
//            Spacer(minLength: 20)
//        ForEach(0..<dd.count){ n in
//            VStack(alignment: .leading){
//                Text("\(dd[n].name)")
//                    .font(.custom("Baskerville", size: 19))
//                    .fontWeight(.black)
//                    .foregroundColor(Color.elementAccent)
//                    .padding(.all)
//                ScrollView(.horizontal, showsIndicators: false, content: {
//                    HStack{
//                        Spacer(minLength: (screenWidth - itemW*2)/3)
//                        ForEach(0 ..< dd[n].items.count){i in
//                                mainMenuItem(iPreview:dd[n].items[i], isNavigate: $settings.navigateToRedactor, w:self.itemW , h: self.itemH, isDraftItem: false)
//                                    .overlay(
//                                        Button(action:{
//                                            settings.isOpenedDraft = false
//                                            settings.navigateToRedactor = true
//                                            settings.templateName = dd[n].items[i].renderfile
//                                            settings.templateImageName = dd[n].items[i].image
//                                        }, label:{
//                                            Rectangle()
//                                                .opacity(0.0)
//                                        }
//                                        )
//                                    )
//                        }
//                        Spacer(minLength: (screenWidth - itemW*2)/3)
//                    }
//                })
//            }
//            .padding(.bottom)
//            Divider()
//        }
//        }
//    }
    
}

struct defaultTemplates_Preview: PreviewProvider {
    static var previews: some View {
        defaultTemplates()
            .previewDevice("Iphone X")
    }
}
