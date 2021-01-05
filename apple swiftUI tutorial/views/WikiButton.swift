//
//  WikiButton.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 21.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct WikiButton: View {

    let screenSize = UIScreen.main.bounds.size
    var icon = "plus"
    var color = "green"
    var text = "Create New Wiki"
    var isFolder = false
    var action: (()->()) = {}
    
    var body: some View {
        let screenWidth = screenSize.width
        
        return Button(action: {
            self.action()
        }) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(isFolder ? Color(color) : Color.white)
                
                Text(text)
                    .foregroundColor(isFolder ? Color(color) : Color.white)
                
            }.frame(width: screenWidth * 0.7 )
                .padding(.vertical)
                .background(Color(color).opacity(isFolder ? 0.2 : 1))
                .cornerRadius(10)
        }
    }
}

struct WikiButton_Previews: PreviewProvider {
    static var previews: some View {
        WikiButton()
    }
}
