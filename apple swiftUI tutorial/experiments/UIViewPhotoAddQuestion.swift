////
////  UIViewPhotoAdd.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 27.02.2021.
////  Copyright © 2021 David Gaz. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//
//
//struct imageAdderDataHolder: Identifiable, Hashable {
//    var id: UUID = UUID()
//    var isShowingImagePicker:Bool = false
//    var imageInBlackBox:UIImage = UIImage(systemName: "photo")!
//    var height: CGFloat = 160
//    var width: CGFloat = 160
//}
//
//class imageAdderData: ObservableObject{
//    init() {}
//    static let shared = imageAdderData()
//    @Published var img1: imageAdderDataHolder = imageAdderDataHolder()
//}
//
//struct simpleadder: UIViewRepresentable{
//    @ObservedObject var imageData: imageAdderData = .shared
//
//    func makeUIView(context: Context) -> UIView {
//        let mainView: UIView = UIView()
//        let imageView: UIImageView = UIImageView()
//        
//        imageView.image = imageData.img1.imageInBlackBox
//        imageView.frame.size.width = imageData.img1.width
//        imageView.frame.size.height = imageData.img1.height
//        imageView.contentMode = .scaleAspectFit
//        mainView.addSubview(imageView)
//        return mainView
//    }
//    
//    func updateUIView(_ uiView: UIView, context: Context) {
//        if let imageView = uiView.subviews.first as? UIImageView {
//                    imageView.image = imageData.img1.imageInBlackBox
//                }
//        
//    }
//}
//
//struct  photoadder: View {
//    @ObservedObject var imageData: imageAdderData = .shared
//    var body: some View {
//        VStack{
//            HStack{
//                simpleadder()
//                    .frame(width: imageData.img1.width, height: imageData.img1.height)
//                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                    .sheet(isPresented: $imageData.img1.isShowingImagePicker, content: {
//                        imagePickerUIView(isPresented: $imageData.img1.isShowingImagePicker)
//                    })
//                Image(uiImage: imageData.img1.imageInBlackBox)
//                    .resizable()
//                    .aspectRatio(contentMode: ContentMode.fit)
//                    .frame(width: imageData.img1.width, height: imageData.img1.height)
//                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//            }
//            Button("change image") {
//                imageData.img1.isShowingImagePicker = true
//            }
//        }
//    }
//}
//
//
//struct imagePickerUIView: UIViewControllerRepresentable {
//    @ObservedObject var imageData: imageAdderData = .shared
//    @Binding var isPresented: Bool
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
//                parent.imageData.img1.imageInBlackBox = selectedImageFromPicker
//            }
//            self.parent.isPresented = false
//        }
//    }
//    func updateUIViewController(_ uiViewController:
//                                    imagePickerUIView.UIViewControllerType, context:
//                                        UIViewControllerRepresentableContext<imagePickerUIView>) {
//    }
//}
//
//
//struct photoadder_Previews: PreviewProvider {
//    static var previews: some View {
//        photoadder()
//    }
//}
//
//
//extension UIImageView {
//    
//    var contentClippingRect: CGRect {
//        guard let image = image else { return bounds }
//        guard contentMode == .scaleAspectFit else { return bounds }
//        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
//        
//        let scale: CGFloat
//        if image.size.width > image.size.height {
//            scale = bounds.width / image.size.width
//        } else {
//            scale = bounds.height / image.size.height
//        }
//        
//        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
//        let x = (bounds.width - size.width) / 2.0
//        let y = (bounds.height - size.height) / 2.0
//        
//        return CGRect(x: x, y: y, width: size.width, height: size.height)
//    }
//    
//}
