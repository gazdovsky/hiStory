//
//  setPROLabel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.04.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI



struct setPROLabel: ViewModifier{
  @State  var isPro: Bool = false
    
    func body(content: Content) -> some View{
       
           content
            .overlay(
                ZStack(alignment: .topTrailing , content: {
                    Color.clear
                    Rectangle()
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.clear)
                        .overlay(
                            Rectangle()
                                .frame(width: 120, height: 20)
                                .foregroundColor(.elementAccent)
                                .overlay(
                                    Text("PRO")
                                        .foregroundColor(.lightBeige)
                                        .font(.custom("Arial", size: 11))
                                        .tracking(2)
                                )
                                .rotationEffect(Angle(degrees: 45))
                        )
                
                })
            )
        }
        
    }
