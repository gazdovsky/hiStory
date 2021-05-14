//
//  colorsCodes.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

class uiColors: ObservableObject{
    init() {
    }
    static var shared = uiColors()
    @Published var chosableColors: [String] = [
        "FDAC53",
        "9BB7D4",
        "B55A30",
        "F5DF4D",
        "0072B5",
        "A0DAA9",
        "E9897E",
        "00A170",
        "926AA6",
        "D2386C",
        "9A8B4F",
        "E0B589",
        "EFE1CE",
        "939597",
        "363945",
    ]

    @Published var standartColors: [String] = [
    "161616",
        "404040",
        "7f7f7f",
        "bebebe",
        "dedede",
        "fefefe",
        "01596f",
        "0096b9",
        "03c3ea",
        "6edaf4",
        "9ce7f7",
        "caf2fa",
        "090e60",
        "1022aa",
        "2732f0",
        "725af6",
        "9685f6",
        
        
        "c0b6fd",
        "500935",
        "8d1761",
        "c32e8a",
        "d07cb0",
        "d096ba",
        "e7c4da",
        "691400",
        "af2a01",
        "db5120",
        "e39179",
        "e3a694",
        "f2d4ca",
        "6b3f00",
        "b76f00",
        "ea9901",
        "eebf71",
        "eecc93",
        "f9e6c8",
        "726b00",
        "bdb401",
        "e4db00",
        "eae67a",
        "eae799",
        "f9f7da",
        "3d5300",
        "6c8f00",
        "99c228",
        "b9d07e",
        "c2d09d",
        "dfe9c7"
        
    ]
    
    @Published var opacityColors: [String] = [
        "7fFDAC53",
        "7f9BB7D4",
        "7fB55A30",
        "7fF5DF4D",
        "7f0072B5",
        "7fA0DAA9",
        "7fE9897E",
        "7f00A170",
        "7f926AA6",
        "7fD2386C",
        "7f9A8B4F",
        "7fE0B589",
        "7fEFE1CE",
        "7f939597",
        "7f363945",
    ]
    
//    var c7 = hexColor(hex: "f4d9c9")
//    var c3 = hexColor(hex: "f4d8c8")
//    var c2 = hexColor(hex: "ecc9af")
//    var c10 = hexColor(hex: "a98162")
//    var c11 = hexColor(hex: "bb8a62")
//    var c4 = hexColor(hex: "a07554")
//    var c6 = hexColor(hex: "7d3704")
//    var c8 = hexColor(hex: "59361c")
//    var c9 = hexColor(hex: "493412")
    
}

struct colorsCodes: View {
    var body: some View {
        ZStack{
            HStack (spacing: 0, content:{
            Rectangle()
                .foregroundColor(Color.white)
            Rectangle()
                .background(Color.black)
            })
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing:0 ,content:{
                        Group{
                        Rectangle()
                            .foregroundColor(Color(hex: "f4d8c8"))
                        Rectangle()
                            .foregroundColor(Color.lightBeige)
                        
                        Rectangle()
                            .foregroundColor(Color(hex: "a98162"))
                        Rectangle()
                            .foregroundColor(Color.mainBeige)
                        
                        Rectangle()
                            .foregroundColor(Color(hex: "7d3704"))
                        Rectangle()
                            .foregroundColor(Color.textAccent )
                        
                        Rectangle()
                            .foregroundColor(Color(hex: "59361c"))
                        Rectangle()
                            .foregroundColor(Color.elementAccent )
                        }
                        .frame(width: 200, height: 50)
                    })
        }

    }
}

struct colorsCodes_Previews: PreviewProvider {
    static var previews: some View {
        colorsCodes()
    }
}
