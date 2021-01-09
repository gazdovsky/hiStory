//
//  textContainersFrame.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 05.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

class textContainersFrameData: ObservableObject{
    init() {
    }
    static var shared = textContainersFrameData()
//    @ObservedObject var storyTemplate: selectorContainerStore = .shared
    @Published var textContainers:Array<textFieldContainer> = Array(repeating:  textFieldContainer() , count: 5)

    @Published var activeTextContainer = 0
    
    func indexOfActiveTextContainer() -> Int{
        var active = 0
        var activeCount = 0
        for i in 0..<textContainers.count {
            if textContainers[i].isActive == true{
                active = i
                activeCount += 1
            }
        }
        active = activeCount > 0 ? active : -1
        return active
    }
    
    func deactivateAllTextContainers(){
        activeTextContainer = 0
        for i in 0..<textContainers.count {
            self.textContainers[i].isActive = false
        }
    }
}

struct textContainersFrame: View {
    @ObservedObject var data: textContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    var body: some View {
        Image(redactor.storyTemplate.templateImageName)
            .resizable()
            .aspectRatio(1080/1920, contentMode: .fit)
            .opacity(0)
            .overlay(
                ZStack{
                    ForEach(redactor.textFields.textContainers.indices){ u in
                        textViewWrapper(textViewItem: $redactor.textFields.textContainers[u], index: u)
                            .modifier(makeTransformingMultilineText(index : u, fontSize: redactor.textFields.textContainers[u].fontSize))
                    }
                }
            )
    }
}

struct textContainersFrame_Previews: PreviewProvider {
    static var previews: some View {
        textContainersFrame()
    }
}
