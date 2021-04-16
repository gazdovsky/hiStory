////
////  SwiftUIPhotoSelectorScreen.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 16.05.2020.
////  Copyright © 2020 David Gaz. All rights reserved.
////
//
//import SwiftUI
//
//struct picSelectorFrame:View {
//    
//    @State var isShowingImagePicker = false
//    @State var      imageInBlackBox            = UIImage()
//    @State var        imageSelected            = false
//    @State var          imageZIndex            = 0.0
//    @State private var currentPosition: CGSize = .zero
//    @State private var     newPosition: CGSize = .zero
//    
//    var body: some View{
//       let picSelector = ZStack{
//             Image(uiImage: imageInBlackBox)
//                 .resizable()
//                 .scaledToFill()
//                 .background(
//                     Color.gray
//                         .opacity(0.1)
//                 )
//                 .layoutPriority(10)
//                 .zIndex(imageZIndex)
//                 .gesture(DragGesture(minimumDistance: 5)
//                             .onChanged({value in
//                                 self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
//                                                               height: value.translation.height + self.newPosition.height)
//                             })
//                             .onEnded({ value in
//                                 self.newPosition = self.currentPosition
//                             }))
//                 .offset(self.currentPosition)
//             Button(action: {
//                 if self.imageSelected == false {
//                     self.isShowingImagePicker.toggle()
//                     self.imageZIndex = 1
//                     self.imageSelected = true
//                 }
//             }, label: {
//                 Rectangle()
//                     .opacity(0.1)
//             }
//             )
//             .layoutPriority(12)
//             .sheet(isPresented: $isShowingImagePicker , content: {
//                 ImagePickerViewScreen(isPresented: self.$isShowingImagePicker,
//                                       selectedImage: self.$imageInBlackBox)
//             }
//             
//             )
//         }
//        
//        ZStack{
//         Rectangle()
//             .fill( Color(.green))
//             .opacity(0.3)
//             .frame(width: 350, height: 350)
//            picSelector
//             .frame(width: 300, height: 300)
//             .mask(
//                 Rectangle()
//             )
//             .contentShape(
//                 Rectangle()
//             )
//            customTextField()
//        }
//        
//    }
//}
//struct SwiftUIPhotoSelectorScreen: View {
//let screenW = UIScreen.main.bounds.width
//    let screenH = UIScreen.main.bounds.height
//    var body: some View{
//        ZStack{
//                picSelectorFrame()
//                Button("Save"){
////                takeScreenshot(origin: CGPoint(x: screenW/2-175, y: screenH/2-175),size:CGSize(width: 350, height: 350))
//                }
//                .position(x: screenW/2, y: screenH-50)
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct ImagePickerViewScreen: UIViewControllerRepresentable {
//    
//    @Binding var isPresented: Bool
//    @Binding var selectedImage: UIImage
//    
//    func makeUIViewController(context:
//                                UIViewControllerRepresentableContext<ImagePickerViewScreen>) ->
//    UIViewController {
//        let controller = UIImagePickerController()
//        controller.delegate = context.coordinator
//        return controller
//    }
//    
//    func makeCoordinator() -> ImagePickerViewScreen.Coordinator {
//        return Coordinator(parent: self)
//    }
//    
//    class Coordinator: NSObject, UIImagePickerControllerDelegate,
//                       UINavigationControllerDelegate {
//        
//        let parent: ImagePickerViewScreen
//        init(parent: ImagePickerViewScreen) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
//                                    [UIImagePickerController.InfoKey : Any]) {
//            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
//                self.parent.selectedImage = selectedImageFromPicker
//            }
//            self.parent.isPresented = false
//        }
//    }
//    
//    func updateUIViewController(_ uiViewController:
//                                    ImagePickerViewScreen.UIViewControllerType, context:
//                                        UIViewControllerRepresentableContext<ImagePickerViewScreen>) {
//    }
//}
//
//extension View {
//  func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
//    let settings: selectorContainerStore = .shared
//    let window = UIWindow(frame: CGRect(origin: origin, size: size))
//    let hosting = UIHostingController(rootView: frame1())
//    
////    let rootVC = UIApplication.shared.windows.first?.rootViewController
//
//    window.rootViewController = hosting
//    window.makeKeyAndVisible()
//        let img = hosting.view.getImage()
////            .jpegData(compressionQuality: 0.8)
//    
//    let newFolder = settings.createFileDirectory(folderName: settings.templateImageName)
//    settings.saveImageToFolder(image: img, name:"scr1.jpg", folder: newFolder)
////        UIImageWriteToSavedPhotosAlbum(screenshot(), nil ,nil, nil)
//    return img
//  }
//}
//
//extension UIView {
//}
//
//extension UIView {
//    func getImage() -> UIImage {
//        let format = UIGraphicsImageRendererFormat()
//        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)
//        let image = renderer.image { rendererContext in
//            self.layer.render(in: rendererContext.cgContext)
//        }
//        return image
//    }
//}
//
//struct SwiftUIPhotoSelectorScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIPhotoSelectorScreen()
//    }
//}
