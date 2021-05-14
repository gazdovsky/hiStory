//
//  sideMenu.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 26.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct sideMenu: View {
    var aboutText = "Hello! We are creators of the hiStory app, David and Anastasia. The idea to create hiStory came to us in the spring of 2020, when we started learning Swift and UX / UI design. Over time, our pet project became a full-fledged application. We aim to make it in such a way that the process of creating stories becomes even more high-speed, high-quality and diverse. We'd love to get any feedback, and thanks for your support!"
    @State var showAboutUs: Bool = false
    var body: some View {
        VStack( spacing: 0, content:{
            ZStack{
        
                VStack{
            Group{
                sideMenuButton(text: NSLocalizedString("About us", comment: "About us")){
                    showAboutUs =  true
                }
//                sideMenuButton(text: NSLocalizedString("Rate in app store", comment: "Rate in app store"))
//                
//                Spacer()
//                sideMenuButton(text: NSLocalizedString("Feedback", comment: "Feedback"))
//                Spacer()
                HStack{
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                        Group{
                            Text(NSLocalizedString("version", comment: "version"))
                            Text("0.2")
                        }
                            .font(.custom("Times New Roman", size: 12))
                            .foregroundColor(Color(hex: "f4d8c8").opacity(0.7))
                    })
                    Spacer()
                   Image(systemName: "suit.heart.fill")
                    
                    .foregroundColor(Color(hex: "f4d8c8").opacity(0.7))
                }
                .padding(30)
         
            }
             
                }
                Rectangle()
                    .foregroundColor(.white)
                  .padding()
                    .overlay(
                        VStack{
                            ToolbarButton(icon: "xmark.circle", isSelected: true, size: 30, color: "f4d8c8", action: {
                                showAboutUs = false
                            })
                            .padding(.top)
                            Text(NSLocalizedString(aboutText, comment: "About us") )
                                .foregroundColor(Color(hex: "f4d8c8"))
                                .padding([.leading,.trailing,.bottom])
                                .padding([.leading,.trailing,.bottom])
                            Spacer()
                        }
                        
                        .background(Color(hex: "59361c"))
                        
                    )
                    .opacity(showAboutUs ? 1 : 0)
            }
            
            })
        .frame(width: 270, alignment: .center)
        .background(Color(hex: "59361c"))
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
                    .foregroundColor(Color(hex: "f4d8c8"))
            })
            Divider()
                .background(Color(hex: "f4d8c8"))
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
