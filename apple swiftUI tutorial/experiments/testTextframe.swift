//
//  testTextframe.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct testTextframe: View {
    @ObservedObject var data: textContainersFrameData = .shared
//    @State var imageWidth: CGFloat = 1080
    var body: some View {
        ZStack{
            photoContainersFrame()
        ForEach(0 ..< data.textContainers.count, id: \.self){ u  in
        textViewWrapper(
            textViewItem: $data.textContainers[u],
            index: u,
            increaser: 1)
//            .onAppear(perform: {
//                data.textContainers[0] = textFieldContainer()
//            })
        }
        }
    }
}

struct testTextframe_Previews: PreviewProvider {
    static var previews: some View {
        testTextframe()
    }
}
