//
//  sideMenu.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 26.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct sideMenu: View {
    var aboutText = "Привет! Мы создатели приложения hiStories, Давид и Настя. Идея создать hiStory пришла к нам весной 2020, когда мы начали изучать язык Swift и UX/UI дизайн. Со временем наш небольшой, но любимый проект стал полноценным приложением. Мы постарались сделать его таким, чтобы процесс создания сторис стал еще более скоростным качественным и разнообразным. Будем рады обратной связи, и спасибо за поддержку!"
    @State var showAboutUs: Bool = false
    var body: some View {
        VStack( spacing: 0, content:{
            ZStack{
        
                VStack{
            Group{
                sideMenuButton(text: NSLocalizedString("About us", comment: "About us")){
                    showAboutUs =  true
                }
                sideMenuButton(text: NSLocalizedString("Rate in app store", comment: "Rate in app store"))
                sideMenuButton(text: NSLocalizedString("Instagram", comment: "Instagram")){
                    if let url = URL(string: "https://www.instagram.com/hi.story.app/") {
                           UIApplication.shared.open(url)
                       }
                }
                
                Spacer()
                sideMenuButton(text: NSLocalizedString("Feedback", comment: "Feedback"))
                Spacer()
                HStack{
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                        Group{
                            Text(NSLocalizedString("version", comment: "version"))
                            Text("0.2")
                        }
                            .font(.custom("Times New Roman", size: 12))
                            .foregroundColor(Color.lightBeige.opacity(0.7))
                    })
                    Spacer()
                   Image(systemName: "suit.heart.fill")
                    
                    .foregroundColor(Color.lightBeige.opacity(0.7))
                }
                .padding(30)
         
            }
             
                }
                Rectangle()
                    .foregroundColor(.white)
                  .padding()
                    .overlay(
                        VStack{
                            ToolbarButton(icon: "xmark.circle", isSelected: true, size: 30, color: "000", action: {
                                showAboutUs = false
                            })
                            Text(aboutText)
                                .padding()
                                .padding()
                        }
                        
                    )
                    .opacity(showAboutUs ? 1 : 0)
            }
            
            })
        .frame(width: 270, alignment: .center)
        .background(Color.elementAccent)
    }
}

struct sideMenuButton: View {
    var text: String
    var action: () -> () = {}
    var body: some View{
        VStack(alignment: .leading, spacing: 0, content:{
            Button(action: {
                action()
            }, label: {
                Text(text)
                    .padding([.trailing])
                    .padding(.top, 35)
                    .padding(.leading, 35)
                    .padding(.bottom, 9)
                    .font(.custom("Times New Roman", size: 18))
                    .foregroundColor(Color.lightBeige)
            })
            Divider()
                .background(Color.lightBeige)
                .padding([.leading])
        })
        
        
    }
}

struct sideMenu_Previews: PreviewProvider {
    static var previews: some View {
        sideMenu()
//            .background(Color(hex: <#T##String#>))
    }
}
