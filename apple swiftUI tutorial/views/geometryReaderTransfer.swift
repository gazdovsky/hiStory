//
//  geometryReaderTransfer.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 24.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI

struct geometryReaderTransfer: View {
    @ObservedObject var settings: selectorContainerStore = .shared
    @State var geo: CGRect
    @State var geoStr: String
    
    var body: some View {
        VStack{
        Text("1 \(self.geo.debugDescription)")
            .onAppear(perform: {
//                settings.templateFrame = self.geo
            })
            Text("2 \(self.geoStr)")
        }
    }
}

struct geometryReaderTransfer_Previews: PreviewProvider {
    static var previews: some View {
        geometryReaderTransfer(geo: CGRect(), geoStr: "ssa")
    }
}
