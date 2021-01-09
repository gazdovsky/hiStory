//
//  MainEditorPanel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct MainEditorPanel: View {

    let fontSize: CGFloat = 15
    var body: some View {
        HStack{
                           VStack{ToolbarButton(icon: "txt2", isSelected: true, size: 30){
        
                        }
                            .padding([.leading,.trailing])
                           Text("Text")
                            .font(.custom("Times New Roman", size: fontSize))
                            .foregroundColor(Color(hex: "ecc9af"))
                           }
                            Spacer()
            
                           VStack{ ToolbarButton(icon: "img2", isSelected: true, size: 30){
                            
                            }
                            .padding([.leading,.trailing])
                           Text("Image")
                            .font(.custom("Times New Roman", size: fontSize))
                            .foregroundColor(Color(hex: "ecc9af"))
                           }
                        }
                        .frame(width: nil, height: 50)
    }
}

struct MainEditorPanel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
        Color(.systemGreen)
        MainEditorPanel()
        }
    }
}
