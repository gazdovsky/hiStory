//
//  purchaseButton.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 25.03.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct purchaseButton: View {
    var radius:CGFloat = 10
    @Binding var isSelected: Bool
    @State private var amount: CGFloat = 2
    var title: String = "ГОДОВОЙ АБОНИМЕНТ"
    var price: String = "599 Р"
    var info: String = "*Всего 50 Р / месяц"
    var sale: String = ""
    var action: (() -> ()) = {}
    var body: some View {
        Button(action: {
            action()
        }){

        ZStack(alignment: .center , content:{
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.mainBeige, lineWidth: 3.3)
                        .background(
                            Color.clear
                                .cornerRadius(radius)
                                .opacity( 0.5 )
                        )
                )
                .opacity(isSelected ? 1 : 0)
                
            
            
            RoundedRectangle(cornerRadius: radius-3)
                .foregroundColor(.white)
                .padding(8)
                .overlay(
                    VStack(alignment:.leading ,content:{
                        Text(title)
                            .font(.custom("Arial", size: 10) )
                            .foregroundColor(.elementAccent)
//                            .kerning(amount)
                        
                        Text(price)
                            .font(.custom("Arial", size: 22) )
                            .kerning(amount)
                            .padding([.top,.bottom], 10)
                            .foregroundColor(.elementAccent)
                           
                        
                        Text(info)
                            .font(.custom("Arial", size: 10) )
                            .foregroundColor(.elementAccent)
//                            .kerning(amount)
                    })
                    
                )
                .overlay(
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                           
                            .foregroundColor(.orange)
                        Text("- \(sale)%")
                            .font(.custom("Arial", size: 16) )
                            .foregroundColor(.white)
                    }
                    .frame(width: 65, height: 19)
                    .offset(x: -34, y: -56)
                    .opacity(sale == "" ? 0 : 1)
                )
//                .onTapGesture {
//                    self.action()
//                }
            
        })
        
      
        .frame(width: 163, height: 114)
//        .offset(x: -83, y: 156)
        }
        .animation(.easeInOut)
    }
}


struct purchaseButtonWrap: View {
    @State var active : Bool = true
    var body: some View {
        purchaseButton(isSelected: $active)
    }
}


struct purchaseButton_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack{
            Image("hiStory PRO")
                .resizable()
                .scaledToFill()

//            Color.gray
//            purchaseButtonWrap()
//                        .opacity(0.7)
        }
    }
}
