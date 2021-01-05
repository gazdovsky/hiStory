//
//  ImageEditorPanel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct ImageEditorPanel: View {
    @ObservedObject var settings: selectorContainerStore = .shared
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            
        
            //            Spacer()
            ToolbarButton(icon: "xmark", isSelected: true, size: 30){
                self.settings.clearContainer(index: self.settings.indexOfActiveContainer())
                self.settings.redactorMode = .nothing
            }
//            Spacer()
            ToolbarButton(icon: "checkmark", isSelected: true, size: 30){
                self.settings.acceptContainerChanges(index: self.settings.indexOfActiveContainer())
                settings.saveTransformToFolder()
                self.settings.redactorMode = .nothing
            }
            .padding([.leading])
            //        Spacer()
        }
        )
        //        .itemsInFrame()
        //        .opacity(settings.templateOpacity ? 1 : 0)
    }
}

struct ImageEditorPanel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            
            Color(.systemGreen)
            ImageEditorPanel()
        }
    }
}
