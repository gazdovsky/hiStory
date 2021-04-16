//
//  textEditorTopPanel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 17.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct textEditorTopPanel: View {
//    @ObservedObject var textFields: textContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    var copyAction: () -> () = {}
    var layerUp: String {
        if #available(iOS 14.0, *) {
            return "square.2.stack.3d.top.fill"
        } else {
            return "square.stack.3d.up.fill"
        }
    }
    var layerDown: String {
        if #available(iOS 14.0, *) {
            return "square.2.stack.3d.bottom.fill"
        } else {
            return "square.stack.3d.up.fill"
        }
    }
    var layerDownIconRotation: Double {
        if #available(iOS 14.0, *) {
            return 0
        } else {
            return 180
        }
    }
    
    var body: some View {
        HStack{
            Spacer()
            ToolbarButton(icon: layerUp, isSelected: true, size: 25) {
                redactor.textFields.moveTextLayer(direction: .up)
            }
            ToolbarButton(icon: layerDown, isSelected: true, size: 25) {
                redactor.textFields.moveTextLayer(direction: .down)
            }
            .rotationEffect(Angle(degrees: layerDownIconRotation))
            Spacer()
            Group{
                if redactor.textFields.containersPairIndexesForCopy.count > 0 {
                    gradientIcon(iconName: "doc.on.doc.fill", size: 25){
                        redactor.textFields.addSmartCopy()
                    }
                } else {
                    ToolbarButton(icon: "doc.on.doc.fill", isSelected: true, size: 25){
                        redactor.textFields.addSmartCopy()
                    }
                }
                
                
            }
//            .onTapGesture {
//                textFields.addSmartCopy()
//            }
           
        }
    }
}

struct textEditorTopPanel_Previews: PreviewProvider {
    static var previews: some View {
        textEditorTopPanel()
    }
}
