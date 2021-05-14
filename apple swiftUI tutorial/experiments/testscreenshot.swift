//
//  testscreenshot.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 06.11.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI
import UIKit


extension View {
//    func asImage() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//
//        // locate far out of screen
//        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
////        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
//        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(controller.view)
//
//        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
//        controller.view.bounds = CGRect(origin: .zero, size: size)
//        controller.view.sizeToFit()
//
//        let image = controller.view.asImage(size: size)
//        controller.view.removeFromSuperview()
//        return image
//    }
}

extension UIView {
    func asImage1() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
// [!!] Uncomment to clip resulting image
//             rendererContext.cgContext.addPath(
//                UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath)
//            rendererContext.cgContext.clip()

// As commented by @MaxIsom below in some cases might be needed
// to make this asynchronously, so uncomment below DispatchQueue
// if you'd same met crash
            DispatchQueue.main.async {
                self.layer.render(in: rendererContext.cgContext)
            }
        }
    }
    func asImage(size: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = false
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
                self.layer.render(in: context.cgContext)
        }
    }

}


// TESTING
struct TestableView: View {
    var body: some View {
        VStack {
            Text("Test 2")
                .foregroundColor(Color.blue)
//            photoSelectorTest(w:50, h:50, angle:Angle(degrees: 15))
        }
    }
}

struct TestBackgroundRendering: View {
    
    func getScreen(){
//        var view = UIHostingController(rootView: frame1())
//        
//        let renderer = UIGraphicsImageRenderer(size: view.sizeThatFits(in: CGSize(width: 1080, height: 1920)))
//        let image = renderer.image { ctx in
//            
//            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
//        }
    }
    var body: some View {
        VStack {
            TestableView()
            Divider()
            Image(uiImage: render())
//                .border(Color.black)
            
            
        }
    }
    
    private func render() -> UIImage {
//        var img1 :UIImage = TestableView().asImage()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 200), false, 0);
        
//        view.drawViewHierarchyInRect(CGRect(x: -50,y: -5,width: self.view.bounds.size.width,height: self.view.bounds.size.height), afterScreenUpdates: true)
        
//
//        UIGraphicsEndImageContext()
//
//     UIHostingController(rootView: photoSelectorTest()).view.drawHierarchy(in: CGRect(x: -50,y: -5,width: 100,height: 100), afterScreenUpdates: true)
//UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.mainScreen().scale)
        let img1:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        
//       UIImageWriteToSavedPhotosAlbum(img1, nil ,nil, nil)
        return img1
    }
}


struct TestBackgroundRendering_Previews: PreviewProvider {
    static var previews: some View {
        TestBackgroundRendering()
    }
}

