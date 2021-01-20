//
//  hideView.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 15.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

import SwiftUI

struct hidebleView: View {
    @State var hid: Bool = false
    var body: some View {
        VStack{
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .hideCondition(isHidden: $hid)
            .modifier(hideViewState(isHidden: hid))
//            .resisableText(fontSize: 40)
        Toggle("is hidden", isOn: $hid)
            Text("\(hid.description)")
        }
    }
}

struct hideView: ViewModifier{
    @Binding var isHidden: Bool
   
    @ViewBuilder
    func body(content: Content) -> some View{
        if isHidden {
           content
            .frame(height: 0)
                .opacity(0)
        } else {
             content
        }
    }
}

struct hideViewState: ViewModifier{
    @State var isHidden: Bool
   
    @ViewBuilder
    func body(content: Content) -> some View{
        if isHidden {
           content
            .frame(height: 0)
                .opacity(0)
        } else {
             content
        }
    }
}

extension View{
    func hideCondition(isHidden: Binding<Bool>) -> some View{
        self.modifier(hideView(isHidden: isHidden))
    }
}

struct hidebleView_Previews: PreviewProvider {
    static var previews: some View {
        hidebleView()
    }
}
