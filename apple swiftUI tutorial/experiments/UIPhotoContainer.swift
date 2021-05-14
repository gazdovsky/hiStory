//
//  UIPhotoContainer.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 09.03.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

class photoAdderData: ObservableObject{
    init() {
    }
    static let shared = photoAdderData()
    
    @Published var img1: customImageDataHolder = customImageDataHolder()
    
}

//struct customImageDataHolder: Identifiable, Hashable {
//    var id: UUID = UUID()
//    var isShowingImagePicker:Bool = true
//    var imageInBlackBox:UIImage = UIImage()
//    var isActive: Bool = false
//    var imageZIndex:Int = 0
//    var height: CGFloat = 500
//    var width: CGFloat = 500
//    var transform: transformContainer = transformContainer()
//}

struct customPhotoContainer: UIViewRepresentable{
    @ObservedObject var redactor: redactorViewData = .shared
    //    @ObservedObject var data: textContainersFrameData = .shared
    @ObservedObject var data: photoContainersFrameData = .shared
    @ObservedObject var testPhoto: photoAdderData = .shared
    @Binding var index: Int 
    //    var increaser: CGFloat
    
    var x: CGFloat
    var y: CGFloat
    var w: CGFloat
    var h: CGFloat
    var scale: CGFloat = 1
    var position: CGSize = .zero
    var rotation: Double = .zero
    func getBaseScale(_ image: UIImage) -> CGFloat {
        let w = image.size.width
        let h = image.size.height
        return w > h ? h / self.h : w / self.w
    }
    var cx: CGFloat {
        -w/2
    }
    var cy: CGFloat {
        -h/2
    }
    
    @State var buttonHide: Bool = false
    
    func makeUIView(context: Context) -> UIView {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: w, height: h))
//        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
//        let button: UIButton =  UIButton(frame: CGRect(x: cx, y: cy, width: 15, height: 15))
       
//        button.backgroundColor =  .green
//        button.setTitle("Test Button", for: [])
//        button.addTarget(context.coordinator, action: #selector(Coordinator.toggleButtonAction), for: .touchUpInside)

        let scaleGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleScale(gesture:)))
        let pan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(gesture:)))
        let rotate = UIRotationGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleRotation(gesture:)))
        
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(scaleGesture)
        mainView.addGestureRecognizer(rotate)
        mainView.addGestureRecognizer(pan)
        
//        print("customPhotoContainer", w)
//        mainView.addSubview(imageView)
//        mainView.addSubview(button)
//        imageView.center = button.center
       
        return mainView
    }
    
    func updateUIView(_ uiView: UIView, context: Context){
//        var button2: UIButton =  UIButton(frame: CGRect(x: cx, y: cy, width: 10, height: 10))
//        button2.backgroundColor =  .red
//        uiView.addSubview(button2)
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, view: UIView() )
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        private func gestureRecognizer(
            _ gestureRecognizer: UIPinchGestureRecognizer,
            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIRotationGestureRecognizer
        ) -> Bool {
            return true
        }
        
        @objc func buttonAction(sender: UIButton!) {
//            print("Button tapped")
            parent.buttonHide = true
        }
        @objc func toggleButtonAction(sender: UIButton!) {
//            print("Button untapped")
            parent.buttonHide.toggle()
//            parent.data.containers[parent.index].isShowingImagePicker = true
        }
        
        @objc func handleScale(gesture: UIPinchGestureRecognizer) {
            switch gesture.state {
            case .began:
                parent.scale = parent.redactor.photoContainers.containers[parent.index].transform.currentScale
                
            case .changed:
                parent.redactor.photoContainers.containers[parent.index].transform.currentScale = parent.scale * gesture.scale
                
            case .ended:
                parent.scale = parent.redactor.photoContainers.containers[parent.index].transform.currentScale
            case .cancelled, .failed: break
            default:
                break
            }
        }
        //
        @objc func handlePan(gesture: UIPanGestureRecognizer) {
                        
            switch gesture.state {
            case .began:
                parent.position = parent.redactor.photoContainers.containers[parent.index].transform.currentPosition
            case .changed:
               
                let centerizeDelta: CGFloat = 5
                let supposedWidth = gesture.translation(in: UIApplication.shared.windows.filter {$0.isKeyWindow}.first).x + parent.position.width
                let supposedHeight = gesture.translation(in: UIApplication.shared.windows.filter {$0.isKeyWindow}.first).y + parent.position.height
//alternative is: UIApplication.shared.keyWindow
                
            
                let image = parent.redactor.photoContainers.containers[parent.index].imageInBlackBox
                let imageSize = image.size
                enum side {
                    case w,h
                }
                let bscale = parent.getBaseScale(parent.redactor.photoContainers.containers[parent.index].imageInBlackBox)
                func magnetPosition(_ side: side ) -> CGFloat {
                    let imageSide = side == .w ? imageSize.width : imageSize.height
                    let containerSide = side == .w ? parent.w : parent.h
                    let supposedPosition = side == .w ? supposedWidth : supposedHeight
                    let magnetPoints: [CGFloat] = [
                        0,
                        (imageSide * parent.scale / bscale - containerSide) / 2,
                        (containerSide - imageSide * parent.scale / bscale) / 2,
                    ]
                    for (i, point) in magnetPoints.enumerated() {
                        if point - centerizeDelta...point + centerizeDelta ~= supposedPosition{
                            if side == .w {
                                switch i {
                                case 0:
                                    parent.data.horizontalAtignLineX = parent.x
                                    
                                case 1:
                                    parent.data.horizontalAtignLineX = parent.x - containerSide/2
                                case 2:
                                    parent.data.horizontalAtignLineX = parent.x + containerSide/2
                                default:
                                    break
                                }
                                parent.data.horizontalAtignHeight = parent.h
                                parent.data.horizontalAtignLineY = parent.y
                                parent.data.horizontalAtignVisible = true

                            } else if side == .h {
                                switch i {
                                case 0:
                                    parent.data.verticalAtignLineY = parent.y
                                case 1:
                                    parent.data.verticalAtignLineY = parent.y - containerSide/2
                                case 2:
                                    parent.data.verticalAtignLineY = parent.y + containerSide/2
                                default:
                                    break
                                }
                                parent.data.verticalAtignWidth = parent.w
                                parent.data.verticalAtignLineX = parent.x
                                parent.data.verticalAtignVisible = true
                            }
                           
                            return point
                        }
                    }
                    switch side {
                    
                    case .w:
                        parent.data.horizontalAtignVisible = false
                    case .h:
                        parent.data.verticalAtignVisible = false
                    } 
                    return supposedPosition
                }
                
                parent.redactor.photoContainers.containers[parent.index].transform.currentPosition = CGSize(
                    width: magnetPosition(.w),
                    height: magnetPosition(.h)
                )
//                print("draging:", parent.index, parent.redactor.photoContainers.containers[parent.index].transform.currentPosition.debugDescription)
            case .ended:
                parent.position = parent.redactor.photoContainers.containers[parent.index].transform.currentPosition
                parent.data.verticalAtignVisible = false
                parent.data.horizontalAtignVisible = false
            default:
                break
            }
        }
        //
        @objc func handleRotation(gesture: UIRotationGestureRecognizer){
            
         
            
            switch gesture.state {
            case .began:
                
                parent.rotation = parent.redactor.photoContainers.containers[parent.index].transform.rotate
            case .changed:
                var supposedDegree = parent.rotation + Double((gesture.rotation ))
                if supposedDegree > Double.pi * 2 {
                    supposedDegree = supposedDegree - Double.pi * 2
                } else if supposedDegree < -Double.pi * 2 {
                        supposedDegree = supposedDegree + Double.pi * 2
                    }
                
                //
                let deltaDegree = Double(0.1)
                
                
                func newAngle() -> Double {
                    let fixPointsNumber: Int = 8
                    var fixPoints: [Double] = []
                    let fixStep: Double = (2 * Double.pi) / Double(fixPointsNumber)
                    var aligns: [ClosedRange<Double>] = []
                    for i in 0..<fixPointsNumber {
                        fixPoints.append(fixStep * Double(i))
                        aligns.append(fixPoints[i] - deltaDegree...fixPoints[i] + deltaDegree)
                        if aligns[i] ~= abs(supposedDegree) {
                        return fixPoints[i] * (abs(supposedDegree) / supposedDegree)
                        }
                    }
                    return supposedDegree
                }
                //                print( Double(gesture.rotation), gesture.rotation)
                parent.redactor.photoContainers.containers[parent.index].transform.rotate = newAngle() //Double(gesture.rotation)
            case .ended:
                
                parent.rotation = parent.redactor.photoContainers.containers[parent.index].transform.rotate
            default:
                break
            }
        }
        
        var parent: customPhotoContainer
        
        //        init(_ view: UIView) {
        //            self.view = view
        //            super.init()
        //        }
        private let view: UIView
        init(_ parent: customPhotoContainer, view: UIView){
            self.view = view
            self.parent = parent
            
        }
    }
    
}
//
//struct customPhotoContainerWrapper: View {
////    @ObservedObject var textFields: textContainersFrameData = .shared
////    @ObservedObject var redactor: redactorViewData = .shared
//    @ObservedObject var testPhoto: photoAdderData = .shared
//    @State var ww: CGFloat = 220
////    var index: Int
////    var increaser: CGFloat
//    var body: some View {
//        VStack{
//            customPhotoContainer(x:0,y:0,w: 200,h: 250)
//                .offset(x: testPhoto.img1.transform.currentPosition.width, y: testPhoto.img1.transform.currentPosition.height)
////                .frame(width: 200, height: 250)
//                
////                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                
////                .onTapGesture {
////                    print("tap")
////                }
////                .frame(width: textFields.customPhotoContainers[index].width, height: textFields.customPhotoContainers[index].height)
////                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
////                .scaleEffect(textFields.customPhotoContainers[index].transform.currentScale)
////                .rotationEffect(Angle(degrees: textFields.customPhotoContainers[index].transform.rotate * 180 / .pi))
////                .offset(x: textFields.customPhotoContainers[index].transform.currentPosition.width, y: textFields.customPhotoContainers[index].transform.currentPosition.height)
//                .sheet(isPresented: $testPhoto.img1.isShowingImagePicker, content: {
//                    PhotoPickerUIView(isPresented: $testPhoto.img1.isShowingImagePicker,
//                                     index: 0)
//                }                )
//        }
//        
//    }
//}
//
//
//
struct PhotoPickerUIView: UIViewControllerRepresentable {
    @ObservedObject var testPhoto: photoAdderData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    @ObservedObject var data: photoContainersFrameData = .shared
//    @State var isPresented: Bool {
//        didSet{
//            print("isPresented is change from: ", oldValue, " to: ", isPresented)
//        }
//    }
//    @Binding var index: Int
    
    func makeUIViewController(context:
                                UIViewControllerRepresentableContext<PhotoPickerUIView>) ->
    UIViewController {
        let controller = UIImagePickerController()
//        navigationBar.tintColor
//        controller.navigationBar.barTintColor = UIColor.black
        
        UINavigationBar.appearance().tintColor = UIColor.link
        
        controller.delegate = context.coordinator
        controller.definesPresentationContext = true
//        print("sheet present fo container at index: ", data.indexOfActiveContainer())
        
        return controller
    }
    
    func makeCoordinator() -> PhotoPickerUIView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: PhotoPickerUIView
        init(parent: PhotoPickerUIView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
                                    [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                parent.redactor.photoContainers.containers[parent.data.indexOfActiveContainer()].imageInBlackBox = selectedImageFromPicker
                parent.redactor.photoContainers.containers[parent.data.indexOfActiveContainer()].imageSelected = true
                let newFolder = parent.redactor.photoContainers.createFileDirectory(folderName: parent.redactor.storyTemplate.templateImageName)
                parent.redactor.photoContainers.saveImageToFolder(image: selectedImageFromPicker, name:"t\(parent.data.indexOfActiveContainer()).jpg", folder: newFolder)
//                print("image is set to container:", parent.data.indexOfActiveContainer())
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
            }
//            self.parent.isPresented = false
            self.parent.data.containers[self.parent.data.indexOfActiveContainer()].isShowingImagePicker = false // experiment
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) -> Void{
//            self.parent.isPresented = false
//            self.parent.redactor.photoContainers.clearContainer(index: self.parent.index)
            self.parent.redactor.photoContainers.clearContainer(index: self.parent.data.indexOfActiveContainer()) //dinamyc get active container
            self.parent.redactor.redactorMode = .nothing
            
            self.parent.redactor.photoContainers.deactivateAllCContainers()
//            self.parent.data.containers[self.parent.index].isShowingImagePicker = false // experiment
        }
    }
    
    func updateUIViewController(_ uiViewController:
                                    PhotoPickerUIView.UIViewControllerType, context:
                                        UIViewControllerRepresentableContext<PhotoPickerUIView>) {
//        print("active container has index: ", data.indexOfActiveContainer() )
        UINavigationBar.appearance().tintColor = UIColor.link
    }
    
    
}
//
//
//
//
//
//struct customPhotoContainerWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        customPhotoContainerWrapper()
//        
//    }
//}
