//
//  takeScreenShot.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 12.11.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


func screenshot(origin: CGPoint, size: CGSize) -> UIImage {
//    var settings: selectorContainerStore = .shared
    let imageSize = size //UIScreen.main.bounds.size as CGSize;
//    let screenScale = UIScreen.main.scale
    let imageScale = 1080 / size.width
    UIGraphicsBeginImageContextWithOptions(imageSize, false, imageScale)
    let context = UIGraphicsGetCurrentContext()
    for obj : AnyObject in UIApplication.shared.windows {
        if let window = obj as? UIWindow {
            if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                                // so we must first apply the layer's geometry to the graphics context
                                context!.saveGState();
                                // Center the context around the window's anchor point
//                                context!.translateBy(x: window.center.x, y: window.center.y);
                                // Apply the window's transform about the anchor point
//                                context!.concatenate(window.transform);
                                // Offset by the portion of the bounds left of and above the anchor point
//                context!.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x,
//                                     y: -window.bounds.size.height * window.layer.anchorPoint.y);
                //use with values from function call
                context!.translateBy(x: -(origin.x-size.width/2),
                                     y: -(origin.y-size.height/2));
                //use with values stored in settings
//                context!.translateBy(x: -(CGFloat(settings.tx)-settings.tw/2),
//                                     y: -(settings.ty-settings.th/2));
                                     
//                print(-(origin.x-size.width/2))
//print(-(origin.y-size.height/2))
                                // Render the layer hierarchy to the current context
                                window.layer.render(in: context!)

                                // Restore the context
                                context!.restoreGState();
            }
        }
    }
    let image = UIGraphicsGetImageFromCurrentImageContext();
    return image!
}

extension UIImage {
    func toPNG() -> UIImage? {
        guard let imageData = self.pngData() else {return nil}
        guard let imagePng = UIImage(data: imageData) else {return nil}
        return imagePng
    }
    
    func toJPG() -> UIImage? {
        guard let imageData = self.jpegData(compressionQuality: 1.0) else {return nil}
        guard let imageJng = UIImage(data: imageData) else {return nil}
        return imageJng
    }
}

enum imageResolution {
    case low
    case normal
    case high
    case ultra
}


extension View {
    func asImage(resolution: imageResolution ) -> UIImage {
//        let baseWidth = width > 0 ? width : CGFloat(1080)
        let controller = UIHostingController(rootView: self)
        
      
        var increasedSize: CGSize {
            switch resolution {
            case .low: return CGSize(width: 540, height: 960)
            case .normal: return CGSize(width: 1080, height: 1920)
            case .high: return CGSize(width: 2160, height: 3840)
            case .ultra:  return CGSize(width: 3240, height: 5760)
            }
        }
        // locate far out of screen
//        controller.view.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        controller.view.frame = CGRect(origin: CGPoint(x: 1000, y: 1000), size: increasedSize)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        //        var increasedSize = CGSize(width: 540, height: 960 ) //UIScreen.main.bounds.size
        //increase size of saved screehshot
//        let increaser = (baseWidth)/increasedSize.width
//        increasedSize.width *= increaser
//        increasedSize.height *= increaser
        let size = controller.sizeThatFits(in: increasedSize)
        
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.backgroundColor = UIColor.clear
        controller.view.isOpaque = true
        controller.view.sizeToFit()

        let image = controller.view.asImage(size: size)
        controller.view.removeFromSuperview()
        return image
    }
}
