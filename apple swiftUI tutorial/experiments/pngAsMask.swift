////
////  pngAsMask.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 21.05.2020.
////  Copyright © 2020 David Gaz. All rights reserved.
////
//
//import SwiftUI
//
//struct pngAsMask: View {
//    let screenW = UIScreen.main.bounds.width
//    let screenH = UIScreen.main.bounds.height
//    
//    var body: some View {
//        let rec1 =  Rectangle()
//            .size(CGSize(width: 200.0, height: 200.0))
//            .fill(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
//            .frame(width: 200, height: 200)
//            .position(x: screenW/2, y: screenH/2)
//            
//        
////        let rec2 =  Rectangle()
////            .size(CGSize(width: 100, height: 100))
////            .frame(width: 100, height: 100)
////            .position(x: screenW/2, y: screenH/2)
//
//    ZStack{
//        rec1
//    Image(systemName: "bolt.fill")
//        .foregroundColor(.white)
//             .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
//             .background(Color.green)
//        .clipShape(Capsule())
//    }
//    }
//}
//
////struct rec: View {
////    var body: some View{
////        Rectangle()
////            .
////    }
////}
//struct pngAsMask_Previews: PreviewProvider {
//    static var previews: some View {
//        pngAsMask()
//    }
//}
//
