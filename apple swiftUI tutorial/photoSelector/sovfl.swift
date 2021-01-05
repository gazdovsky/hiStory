//
//  sovfl.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 12.11.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

//struct ContentViewTest: View {
//    @State var imageData: Data?
//
//    var body: some View {
//        VStack {
//            testView
//                .frame(width: 50, height: 50)
//            Button("test"){
//                UIImageWriteToSavedPhotosAlbum(screenshot(), nil ,nil, nil)
//            }
////
//        }
////
//    }
//
//   
//    
//    var testView: some View {
//        ZStack {
//            Color.blue
//            Circle()
//                .fill(Color.red)
//            
//           customTextField()
//        }
//    }
//}
//
//func convertViewToData<V>(view: V, size: CGSize, completion: @escaping (Data?) -> Void) where V: View {
//    guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
//        completion(nil)
//        return
//    }
//    let imageVC = UIHostingController(rootView: view.edgesIgnoringSafeArea(.all))
//    imageVC.view.frame = CGRect(origin: .zero, size: size)
//    DispatchQueue.main.async {
//        rootVC.view.insertSubview(imageVC.view, at: 0)
//        let uiImage = imageVC.view.asImage2(size: size)
//        imageVC.view.removeFromSuperview()
//        completion(uiImage.pngData())
//    }
//}
//
//extension UIView {
//    func asImage2(size: CGSize) -> UIImage {
//        let format = UIGraphicsImageRendererFormat()
//        format.scale = 1
//        return UIGraphicsImageRenderer(size: size, format: format).image { context in
//            layer.render(in: context.cgContext)
//        }
//    }
//}
//
//
//struct ContentViewTest_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViewTest()
//    }
//}
//
//func screenshot() -> UIImage {
//    let imageSize = UIScreen.main.bounds.size as CGSize;
//    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
//    let context = UIGraphicsGetCurrentContext()
//    for obj : AnyObject in UIApplication.shared.windows {
//        if let window = obj as? UIWindow {
//            if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
//                                // so we must first apply the layer's geometry to the graphics context
//                                context!.saveGState();
//                                // Center the context around the window's anchor point
//                                context!.translateBy(x: window.center.x, y: window.center
//                                    .y);
//                                // Apply the window's transform about the anchor point
//                                context!.concatenate(window.transform);
//                                // Offset by the portion of the bounds left of and above the anchor point
//                context!.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x,
//                                     y: -window.bounds.size.height * window.layer.anchorPoint.y);
//
//                                // Render the layer hierarchy to the current context
//                                window.layer.render(in: context!)
//
//                                // Restore the context
//                                context!.restoreGState();
//            }
//        }
//    }
//    let image = UIGraphicsGetImageFromCurrentImageContext();
//    return image!
//}
