////
////  UIViewPhotoAdd.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 27.02.2021.
////  Copyright © 2021 David Gaz. All rights reserved.
////

import Foundation
import SwiftUI



class imageAdderData: ObservableObject{
    init() {
    }
    static let shared = imageAdderData()
    
    @Published var img1: customImageDataHolder = customImageDataHolder()
  
}



//struct customImageContainer: UIViewRepresentable{
//    @ObservedObject var redactor: redactorViewData = .shared
//    @ObservedObject var data: textContainersFrameData = .shared
//
//    var index: Int
//    var increaser: CGFloat
//    var scale: CGFloat = 1
//    var position: CGSize = .zero
//
//
//    func makeUIView(context: Context) -> UIView {
//        let mainView = UIView()
//        let imageView: UIImageView = UIImageView()
//        imageView.image = redactor.textFields.customPhotoContainers[index].imageInBlackBox
//        imageView.frame.size.width = redactor.textFields.customPhotoContainers[index].width
//        imageView.frame.size.height = redactor.textFields.customPhotoContainers[index].height
//
//        imageView.contentMode = .scaleAspectFit
//
//        imageView.frame.size.width = imageView.contentClippingRect.width
//        imageView.frame.size.height = imageView.contentClippingRect.height
//
//        redactor.textFields.customPhotoContainers[index].width = imageView.contentClippingRect.width
//        redactor.textFields.customPhotoContainers[index].height = imageView.contentClippingRect.height
//
//        let scaleGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleScale(gesture:)))
//        let pan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(gesture:)))
//        let rotate = UIRotationGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleRotation(gesture:)))
//
//        mainView.isUserInteractionEnabled = true
//        mainView.addGestureRecognizer(scaleGesture)
//        mainView.addGestureRecognizer(rotate)
////        mainView.addGestureRecognizer(pan)
//        mainView.addSubview(imageView)
//        return mainView
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//                if let imageView = uiView.subviews.first as? UIImageView {
//                    if redactor.textFields.customPhotoContainers.count - 1 < index {return}
//                            imageView.image = redactor.textFields.customPhotoContainers[index].imageInBlackBox
//                    imageView.frame.size.width = redactor.textFields.customPhotoContainers[index].width
//                    imageView.frame.size.height = redactor.textFields.customPhotoContainers[index].height
//                }
//    }
//
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self, view: UIView(frame: CGRect(x: 0, y: 0, width: 108, height: 192) ) )
//    }
//
//    class Coordinator: NSObject {
//
//        @objc func handleScale(gesture: UIPinchGestureRecognizer) {
//            switch gesture.state {
//            case .began:
//                parent.scale = parent.redactor.textFields.customPhotoContainers[parent.index].transform.currentScale
//
//            case .changed:
//                parent.redactor.textFields.customPhotoContainers[parent.index].transform.currentScale = parent.scale * gesture.scale
//
//            case .ended:
//                parent.scale = parent.redactor.textFields.customPhotoContainers[parent.index].transform.currentScale
//            case .cancelled, .failed: break
//            default:
//                break
//            }
//        }
//
//        @objc func handlePan(gesture: UIPanGestureRecognizer) {
//            switch gesture.state {
//            case .began:
//                parent.position = parent.redactor.textFields.customPhotoContainers[parent.index].transform.currentPosition
//            case .changed:
//                parent.redactor.textFields.customPhotoContainers[parent.index].transform.currentPosition.width = parent.position.width + gesture.translation(in: self.view).x //(in: UIApplication.shared.keyWindow)
//                parent.redactor.textFields.customPhotoContainers[parent.index].transform.currentPosition.height = parent.position.height + gesture.translation(in: self.view).y //(in: UIApplication.shared.keyWindow)
//            case .ended:
//                parent.position = parent.redactor.textFields.customPhotoContainers[parent.index].transform.currentPosition
//            default:
//                break
//            }
//        }
//
//        @objc func handleRotation(gesture: UIRotationGestureRecognizer){
//            switch gesture.state {
//            //            case .began:
//
//            //                parent.position = parent.redactor.textFields.customPhotoContainers[index].transform.currentPosition
//            case .changed:
//                print( Double(gesture.rotation), gesture.rotation)
//                parent.redactor.textFields.customPhotoContainers[parent.index].transform.rotate = Double(gesture.rotation)
//            //            case .ended:
//
//            //                parent.position = parent.redactor.textFields.customPhotoContainers[index].transform.currentPosition
//            default:
//                break
//            }
//        }
//
//        var parent: customImageContainer
//
////        init(_ view: UIView) {
////            self.view = view
////            super.init()
////        }
//        private let view: UIView
//        init(_ parent: customImageContainer, view: UIView){
//            self.view = view
//            self.parent = parent
//        }
//    }
//
//}

//struct customImageContainerWrapper: View {
//    @ObservedObject var textFields: textContainersFrameData = .shared
//    @ObservedObject var redactor: redactorViewData = .shared
//    @State var ww: CGFloat = 220
//    var index: Int
//    var increaser: CGFloat
//    var body: some View {
//        VStack{
//            customImageContainer(index: index, increaser: increaser)
//                .frame(width: textFields.customPhotoContainers[index].width, height: textFields.customPhotoContainers[index].height)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                .scaleEffect(textFields.customPhotoContainers[index].transform.currentScale)
//                .rotationEffect(Angle(degrees: textFields.customPhotoContainers[index].transform.rotate * 180 / .pi))
//                .offset(x: textFields.customPhotoContainers[index].transform.currentPosition.width, y: textFields.customPhotoContainers[index].transform.currentPosition.height)
//                .sheet(isPresented: $textFields.customPhotoContainers[index].isShowingImagePicker, content: {
//                    imagePickerUIView(isPresented: $textFields.customPhotoContainers[index].isShowingImagePicker,
//                                     index: index)
//                }                )
//        }
//        
//    }
//}


//struct imagePickerUIView: UIViewControllerRepresentable {
//    @ObservedObject var redactor: redactorViewData = .shared
//    @Binding var isPresented: Bool
//    var index:Int
//
//    func makeUIViewController(context:
//                                UIViewControllerRepresentableContext<imagePickerUIView>) ->
//    UIViewController {
//        let controller = UIImagePickerController()
//        controller.delegate = context.coordinator
//        return controller
//    }
//
//    func makeCoordinator() -> imagePickerUIView.Coordinator {
//        return Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate,
//                       UINavigationControllerDelegate {
//
//        let parent: imagePickerUIView
//        init(parent: imagePickerUIView) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
//                                    [UIImagePickerController.InfoKey : Any]) {
//            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
//                parent.redactor.textFields.customPhotoContainers[parent.index].imageInBlackBox = selectedImageFromPicker
//                let imageView: UIImageView = UIImageView()
//                imageView.image = selectedImageFromPicker
//                imageView.frame.size.width = parent.redactor.textFields.customPhotoContainers[parent.index].width
//                imageView.frame.size.height = parent.redactor.textFields.customPhotoContainers[parent.index].height
//
//                imageView.contentMode = .scaleAspectFit
//
//                parent.redactor.textFields.customPhotoContainers[parent.index].width = imageView.contentClippingRect.width
//                parent.redactor.textFields.customPhotoContainers[parent.index].height = imageView.contentClippingRect.height
//                imageView.contentMode = .center
//                parent.redactor.textFields.saveCustomPhotoContainerImage(index: parent.index)
//            }
//            self.parent.isPresented = false
//        }
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) -> Void{
//        }
//    }
//
//    func updateUIViewController(_ uiViewController:
//                                    imagePickerUIView.UIViewControllerType, context:
//                                        UIViewControllerRepresentableContext<imagePickerUIView>) {
//    }
//
//
//}


//struct photoadder_Previews: PreviewProvider {
//    static var previews: some View {
//        customImageContainerWrapper(index: 0)
//    }
//}


extension UIImageView {
    
    var contentClippingRect: CGRect {
            guard let image = image else { return bounds }
            guard contentMode == .scaleAspectFit else { return bounds }
            guard image.size.width > 0 && image.size.height > 0 else { return bounds }

            let scale: CGFloat
            if image.size.width > image.size.height {
                scale = bounds.width / image.size.width
            } else {
                scale = bounds.height / image.size.height
            }

            let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
            let x = (bounds.width - size.width) / 2.0
            let y = (bounds.height - size.height) / 2.0

            return CGRect(x: x, y: y, width: size.width, height: size.height)
        }
    
}
