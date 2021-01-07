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
    @ObservedObject var settings: selectorContainerStore =  .shared
//    @State var tt = StoryPreviews
    @State var dd = StoryPreviewsCategory
    
    @State var screenWidth:CGFloat = UIScreen.main.bounds.width
    var itemW:CGFloat{
        screenWidth*0.41
    }
    var baseRatio:CGFloat = 1080/1920
    var itemH:CGFloat{
        itemW/baseRatio
    }
    
    var body: some View{
        VStack{
            Spacer(minLength: 20)
        ForEach(0..<dd.count){ n in
            VStack(alignment: .leading){
                Text("\(dd[n].name)")
                    .font(.custom("Baskerville", size: 19))
                    .fontWeight(.black)
                    .foregroundColor(Color(hex: "#493412"))
                    .padding(.all)
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack{
                        Spacer(minLength: (screenWidth - itemW*2)/3)
                        ForEach(0 ..< dd[n].items.count){i in
                          VStack{
                            mainMenuItem(iPreview:dd[n].items[i], isNavigate: $settings.navigateToRedactor, w:self.itemW , h: self.itemH)
                                .overlay(
                                    Button(action:{
                                        settings.navigateToRedactor = true
                                        settings.templateName = dd[n].items[i].renderfile
                                        settings.templateImageName = dd[n].items[i].image
//                                        settings.tx = 0
//                                        settings.ty = 0
//                                        settings.tw = 0
//                                        settings.th = 0
                                    }, label:{
                                        Rectangle()
                                            .opacity(0.0)
                                    }
)
                                )
                          }
                        }
                        Spacer(minLength: (screenWidth - itemW*2)/3)
                    }
                })

//                Button("yyy"){
//                  print(  settings.getSavedTemplates())
//                }

            }
            .padding(.bottom)
            Divider()
        }
//        Rectangle()
//            .foregroundColor(.white)
//            .frame(width: nil, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    }
}

struct defaultTemplates_Preview: PreviewProvider {
    static var previews: some View {
        defaultTemplates()
            .previewDevice("Iphone X")
    }
}
