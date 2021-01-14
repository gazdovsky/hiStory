////
////  multiFrames.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 06.06.2020.
////  Copyright © 2020 David Gaz. All rights reserved.
////
//
//import SwiftUI
//
//struct multiFrames: View {
//    @State var containers = [
//        
//        
//    ]
//    
//    var body: some View {
//    
//        ZStack{
//            GeometryReader{geom in
//                
//                photoSelectorWrapper(geomSize: geom.size)
////                .layoutPriority(1)
//            }.layoutPriority(10)
//        
//        }
////        .layoutPriority(1)
//        //        .navigationBarHidden(false)
//        //        .navigationBarItems(trailing:
//        //            HStack{
//        //                Button("Save"){
//        //                }
//        //            }
//        //        )
//        
//    }
//}
//
//struct photoSelectorWrapper: View{
//    @State var geomSize:CGSize
////    @State var cW:Double
////    @State var cH:Double
////    @State var cX:Double
////    @State var cY:Double
//    var body: some View{
//        SwiftUIPhotoSelector()
////        Rectangle()
////            .layoutPriority(1)
//            .frame(width: geomSize.width/1.36,
//                   height: geomSize.width/1.36)
//            .mask(
//                Rectangle()
//                    .size(width : geomSize.width/1.36,
//                          height: geomSize.width/1.36)
//        )
//            .position(
//                x: geomSize.width/1.36/2+geomSize.width*0.130,
//                y: geomSize.width/1.36/2+geomSize.width*0.133
//        )
////        .layoutPriority(1)
//    }
//    
//    
//}
//
//struct multiFrames_Previews: PreviewProvider {
//    static var previews: some View {
//            NavigationView{
//        multiFrames()
//        }
//    }
//}
