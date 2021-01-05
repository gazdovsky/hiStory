//
//  pickerFromList.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 22.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct pickerFromList: View {
//    @Binding var font: String
    
    let fontList = ["Cochin-BoldItalic", "Didot", "Georgia", "Helvetica", "Helvetica-Light", "HelveticaNeue-UltraLight", "HoeflerText-BlackItalic", "HoeflerText-Italic", "IowanOldStyle-BoldItalic", "MarkerFelt-Thin", "Noteworthy-Bold", "Palatino-BoldItalic"]
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State var selectedColor: Int = 3
   
    var body: some View {
       VStack {
          Picker(selection: $selectedColor, label: Text("Please choose a color")) {
            ForEach(fontList, id: \.self){ font in
                Text(font)
//                    .font(.custom(self.fontList[$0], size: 20))
             }
          }
          Text("You selected: \(selectedColor) \(fontList[selectedColor])")
            
       }
    }
}

struct pickerFromList_Previews: PreviewProvider {
    static var previews: some View {
        pickerFromList()
    }
}
