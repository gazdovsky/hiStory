//
//  enumInFuncCall.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 20.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct fontFamilyCases: View {
    let fonts: [String] = ["Bender", "Vanilla","Molot", "French Script MT", "Didot", "Georgia", "Helvetica", "Helvetica-Light", "HelveticaNeue-UltraLight", "HoeflerText-BlackItalic", "HoeflerText-Italic", "IowanOldStyle-BoldItalic", "MarkerFelt-Thin", "Noteworthy-Bold", "Palatino-BoldItalic"]
    
    var body: some View{
        
        VStack{
            ForEach(fonts, id:\.self){f in
                HStack{
                    Text("б")
                        .font(.custom(f, size: 24))
//                        .fontWeight(.bold)
//                        .italic()
                   
                    Text("A")
                        .font(.custom(f, size: 24))
                        .fontWeight(.ultraLight)
                    Text("A")
                        .font(.custom(f, size: 24))
                        .fontWeight(.thin)
                    Text("A")
                        .font(.custom(f, size: 24))
                        .fontWeight(.light)
                    Text("A")
                        .font(.custom(f, size: 24))
                        .fontWeight(.regular)
                        .italic()
                    Text("A")
                        .font(.custom(f, size: 24))
                        .fontWeight(.medium)
                    Text("A")
                        .font(.custom(f, size: 24))
                        .fontWeight(.semibold)
                    Text("A")
                        .font(.custom(f, size: 24))
                        .fontWeight(.heavy)
                    Text("A")
                        .font(.custom(f, size: 24))
                        .fontWeight(.black)
                        .italic()
                }
                
                
                
            }
        }
    }
}


enum colors: CaseIterable {
    
    case white, green, yellow, red
}

struct enumInFuncCall: View {
    
    @State var chosenColor : colors = .red
    
    var body: some View {
        VStack{
            HStack{
                ForEach(colors.allCases, id: \.self){e in
                    //                Text("sw")
                    Button("e") {
                        chosenColor = e
                    }
                }
            }
            circleEnum(currentEnum: $chosenColor)
        }
    }
}

struct circleEnum: View {
    @Binding var currentEnum: colors
    var body: some View {
        switch currentEnum {
        case .white : Circle().foregroundColor(.white)
        case .green : Circle().foregroundColor(.green)
        case .yellow : Circle().foregroundColor(.yellow)
        case .red : Circle().foregroundColor(.red)
        }
    }
}

struct enumInFuncCall_Previews: PreviewProvider {
    static var previews: some View {
        fontFamilyCases()
    }
}
