////
////  UIView.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 08.11.2020.
////  Copyright © 2020 David Gaz. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//
//
//struct SwiftUIView: View {
//
//    var body: some View {
//        VStack {
//            Text("Hello World")
//            customTextField()
//            Button("save"){
////                render1()
//            }
//            
//        }
//        
//    }
//    
//
//
//}
//
//class SwiftUIViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 1.
//        let swiftUIView = SwiftUIView()
//        
//        // 2.
//        let hostingController = UIHostingController.init(rootView: swiftUIView)
//        
//        // 3.
//        self.addChild(hostingController)
//        
//        // 4.
//        hostingController.didMove(toParent: self)
//        
//        // 5.
//        self.view.addSubview(hostingController.view)
//        
//        // 6.
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
//            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//        ])
//        
//    }
//    
//         func render1() {
////            var img2 :UIImage = redactor(templateItem: StoryPreviews[1]).asImage()
//    //        Create the UIImage
//            UIGraphicsBeginImageContext(view.frame.size)
////            view.layer.renderInContext(UIGraphicsGetCurrentContext())
//            let img2 = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//    //        Save it to the camera
//            UIImageWriteToSavedPhotosAlbum(img2!, nil ,nil, nil)
//        }
//    
//}
//
//
//
//
//struct UIView_Previews: PreviewProvider {
//    static var previews: some View {
////        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//        SwiftUIViewController().toPreview()
//    }
//}
//
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        // this variable is used for injecting the current view controller
//        let viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//
//    func toPreview() -> some View {
//        // inject self (the current view controller) for the preview
//        Preview(viewController: self)
//    }
//}
