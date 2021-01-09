//
//  SwiftUIPhotoSelector.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 16.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//
import Foundation
import Combine
import Photos
import PhotosUI
import SwiftUI

struct SwiftUIPhotoSelector: View {
//    @ObservedObject var settings: selectorContainerStore = .shared
    @ObservedObject var settings2: photoContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    @State var index: Int = 0
    @State var isShowingImagePicker = false
    @State var imageInBlackBox = UIImage()
    @State var imageSelected = false
    @State var imageZIndex = 0.0
    
    var body: some View{
        ZStack{
            Image(uiImage: redactor.photoContainers.containers[index].imageInBlackBox)
                .resizable()
                .scaledToFill()
                .background(
                    Color(hex: "#bbbbbb")
                )
                .layoutPriority(10)
                .zIndex(redactor.photoContainers.containers[index].imageZIndex)
            Button(action: {
                if  !redactor.photoContainers.containers[index].imageSelected && redactor.redactorMode == .nothing {
                    redactor.photoContainers.containers[index].isShowingImagePicker.toggle()
                    redactor.photoContainers.containers[index].imageZIndex = 1
                    redactor.photoContainers.containers[index].imageSelected = true
                }
            }, label: {
                Image("img2")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.1)
                    .foregroundColor(.white)
            }
            )
            .opacity(redactor.photoContainers.containers[index].imageSelected ? 0 : 1)
            .sheet(isPresented: $redactor.photoContainers.containers[index].isShowingImagePicker , content: {
                ImagePickerView(isPresented: $redactor.photoContainers.containers[index].isShowingImagePicker,
                                selectedImage: $redactor.photoContainers.containers[index].imageInBlackBox, index: index)
            }
            )
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
//    @ObservedObject var settings: selectorContainerStore = .shared
//    @ObservedObject var settings2: photoContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    var index:Int = 1
    
    func makeUIViewController(context:
                                UIViewControllerRepresentableContext<ImagePickerView>) ->
    UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate,
                       UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
                                    [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                self.parent.selectedImage = selectedImageFromPicker
                
                let newFolder = parent.redactor.photoContainers.createFileDirectory(folderName: parent.redactor.storyTemplate.templateImageName) //story
                parent.redactor.photoContainers.saveImageToFolder(image: selectedImageFromPicker, name:"t\(parent.index).jpg", folder: newFolder)
                parent.redactor.saveDraftPreview()
                
            }
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController:
                                    ImagePickerView.UIViewControllerType, context:
                                        UIViewControllerRepresentableContext<ImagePickerView>) {
    }
}


struct photoSelectorWithParams: View{
//    @ObservedObject var settings: selectorContainerStore = .shared
    var actualTemplateWith: CGFloat
    var actualTemplateHeight: CGFloat
    var konstantTemplateWith: CGFloat
    var container:container
    @Binding var redactorActive: Bool
    @Binding var templateOpacity: Bool
    var index: Int
    var relativeW: CGFloat {
        return actualTemplateWith / konstantTemplateWith
    }
    var w: CGFloat{
        return relativeW * (container.w)
    }
    var h: CGFloat{
        return relativeW * (container.h)
    }
    var x: CGFloat{
        return relativeW * (container.x) + w / 2
    }
    var y: CGFloat{
        return relativeW * (container.y) + h / 2
    }
    var body: some View {
        
        SwiftUIPhotoSelector(index: index)
            .frame(width: w, height: h)
            .modifier(makeTransformingImage(index: index, transforming: $redactorActive))
            .mask(
                Rectangle()
                    .frame(width : redactorActive ? actualTemplateWith : w, height: redactorActive ? actualTemplateHeight : h)
                    .offset(CGSize(width: redactorActive ?  (actualTemplateWith / 2) - x : 0, height: redactorActive ? (actualTemplateHeight / 2) - y : 0))
            )
            .contentShape(
                Rectangle()
            )
            .position(x: x, y: y)
            .opacity(!redactorActive && templateOpacity ? 0.5 : 1)
            .zIndex(2)
    }
}

struct SwiftUIPhotoSelector_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
