////
////  щиыукмУтмшкщьуте.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 03.01.2021.
////  Copyright © 2021 David Gaz. All rights reserved.
////
//
//import SwiftUI
//
//struct ObserveEnviroment: View {
//    @ObservedObject var ob: testContainerStore = .shared
//    var body: some View {
//        VStack{
//        TextField("yourText", text: $ob.text)
//            Text(ob.text)
//            TextField("yourText", text: $ob.ob.text)
//                Text(ob.ob.text)
//        }
//    }
//}
//
//class testContainerStore: ObservableObject {
//    init() {
//    }
//    @ObservedObject var ob: testContainerStore2 = .shared
//    static var shared = testContainerStore()
//    var tester = 0
//    @Published var text = "1"
//    @Published var activeTextContainer = 0
//    
//}
//
//class testContainerStore2: ObservableObject {
//    init() {
//    }
//    static var shared = testContainerStore2()
//    var tester = 0
//     var text = "2"
//    @Published var activeTextContainer = 0
//}
//
//
//struct ObserveEnviromentPreviews: PreviewProvider {
//    static var previews: some View {
//        ObserveEnviroment()
//    }
//}
