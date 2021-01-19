//
//  ImageEditorPanel.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct ImageEditorPanel: View {
//    @ObservedObject var settings: selectorContainerStore = .shared
//    @ObservedObject var data: photoContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {

            ToolbarButton(icon: "xmark", isSelected: true, size: 30){
                let activeContainer = redactor.photoContainers.indexOfActiveContainer()
                redactor.photoContainers.clearContainer(index: activeContainer)
                redactor.redactorMode = .nothing
                redactor.photoContainers.deleteContainerImageFromFolder(index: activeContainer)
                redactor.photoContainers.containers[activeContainer] = photoSelector()
                redactor.photoContainers.saveTransformToFolder()
                redactor.saveDraftPreview()
            }
            //            Spacer()
            ToolbarButton(icon: "checkmark", isSelected: true, size: 30){
                redactor.photoContainers.acceptContainerChanges(index: redactor.photoContainers.indexOfActiveContainer())
                redactor.photoContainers.saveTransformToFolder()
                redactor.redactorMode = .nothing
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
