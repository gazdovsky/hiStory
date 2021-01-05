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
    @ObservedObject var storyTemplate: selectorContainerStore = .shared
    @Published var textContainers:Array<textFieldContainer> = Array(repeating:  textFieldContainer() , count: 5)
}

struct textContainersFrame: View {
    @ObservedObject var data: textContainersFrameData = .shared
    var body: some View {
        Image(data.storyTemplate.templateImageName)
            .resizable()
            .aspectRatio(1080/1920, contentMode: .fit)
            .overlay(
                ZStack{
                    ForEach(data.textContainers.indices){ u in
                        textViewWrapper(textViewItem: $data.textContainers[u], index: u)
                            .modifier(makeTransformingMultilineText(index : u, fontSize: data.textContainers[u].fontSize))
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
