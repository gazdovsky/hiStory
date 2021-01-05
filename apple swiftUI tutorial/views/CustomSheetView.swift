//
//  CustomSheetView.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 21.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct CustomSheetView: View {
    
    @Binding var currentHeight: CGFloat
    @Binding var movingOffset: CGFloat
    var body: some View {
        SheetView(currentHeight: self.$currentHeight, movingOffset: self.$movingOffset, smallHeight: 350, onDragEnded: { position in
            // Do things on drag End
        }) {
            ZStack(alignment: .top) {
                
             CreateNewWikiView(movingOffset: self.$currentHeight)
                ToolBarView(currentHeight: self.$currentHeight, movingOffset: self.$movingOffset)
            }
            .background(Color.white)
            .shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0.0, y: -5)
            .clipShape(RoundedShape())
        }
    }
}

struct CustomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSheetView(currentHeight: .constant(0.0), movingOffset: .constant(0.0))
    }
}
