//
//  customTextField.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 11.06.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct customTextField: View {
    @State var fontName: String = "Vanilla"
    @State var fieldText: String = "Your amazing Text "
    @State var fontSize: CGFloat = 20
    var body : some View {
        //        ZStack{
      TextField("Your Text", text: $fieldText, onEditingChanged: { changes in
//            print(changes)
        })
        .padding()
            .multilineTextAlignment(.center)
        .fixedSize()
//            .strokedDashAnimated()
            .transformingText(fontName: fontName, fontSize: fontSize)

    }
}

struct customTextField_Previews: PreviewProvider {
    static var previews: some View {
        customTextField()
    }
}
