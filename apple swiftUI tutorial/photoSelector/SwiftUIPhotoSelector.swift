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
    //    let screenW = UIScreen.main.bounds.width
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
//                    redactor.photoContainers.containers[index].isShowingImagePicker.toggle()
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
//            .sheet(isPresented: $redactor.photoContainers.containers[index].isShowingImagePicker, content: {
//                ImagePickerView(isPresented: $redactor.photoContainers.containers[index].isShowingImagePicker,
//                                selectedImage: $redactor.photoContainers.containers[index].imageInBlackBox, index: index)
//            }
//            )
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
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
                DispatchQueue.main.async {
                    let newFolder = self.parent.redactor.photoContainers.createFileDirectory(folderName: self.parent.redactor.storyTemplate.templateImageName)
                    self.parent.redactor.photoContainers.saveImageToFolder(image: selectedImageFromPicker, name:"t\(self.parent.index).jpg", folder: newFolder)
                }
            }
            self.parent.isPresented = false
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) -> Void{
            self.parent.redactor.photoContainers.clearContainer(index: self.parent.index)
        }
    }
    
    func updateUIViewController(_ uiViewController:
                                    ImagePickerView.UIViewControllerType, context:
                                        UIViewControllerRepresentableContext<ImagePickerView>) {
    }
    
    
}


struct photoSelectorWithParams: View{
    //    @ObservedObject var testPhoto: photoAdderData = .shared
    @ObservedObject var settings2: photoContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    var actualTemplateWith: CGFloat
    //    var actualTemplateHeight: CGFloat
    var konstantTemplateWith: CGFloat
    @State var container:container
    @Binding var redactorActive: Bool
    @Binding var templateOpacity: Bool
    @State var isPresentPhotoPicker: Bool = false
    @State var index: Int
    @State var increaser: CGFloat
    @State var dashRadius: CGFloat = 3
    var relativeW: CGFloat {
        return actualTemplateWith / konstantTemplateWith
    }
    var w: CGFloat{
        //        print("increaser: ",increaser)
        return relativeW * (container.w)
    }
    var h: CGFloat{
        return relativeW * (container.h)
    }
    var x: CGFloat{
        return relativeW * (container.x) + w / 2 //uncomment for SwiftUIPhotoSelector
    }
    var y: CGFloat{
        return relativeW * (container.y) + h / 2 //uncomment for SwiftUIPhotoSelector
    }
    var offset: CGSize {
        if increaser == 2 || increaser == 0.5 {
//            print( "1", actualTemplateWith, increaser, settings2.increaser, redactor.photoContainers.containers[index].transform.currentPosition.debugDescription )
            return CGSize(
                width: redactor.photoContainers.containers[index].transform.currentPosition.width * increaser * redactor.photoContainers.photoIncreaser, //8.747152
                height: redactor.photoContainers.containers[index].transform.currentPosition.height * increaser * redactor.photoContainers.photoIncreaser)
        } else {
//            print( "2", actualTemplateWith, increaser, settings2.increaser, redactor.photoContainers.containers[index].transform.currentPosition.debugDescription )
            return redactor.photoContainers.containers[index].transform.currentPosition
        }
    }
    var body: some View {
        Image(uiImage: redactor.photoContainers.containers[index].imageInBlackBox)
            .resizable()
            .scaledToFill()
            .frame(width: w, height: h)
            .contentShape(Rectangle()
                            .size(.zero))
            .scaleEffect(redactor.photoContainers.containers[index].transform.currentScale)
            .rotationEffect(Angle(degrees: redactor.photoContainers.containers[index].transform.rotate * 180 / .pi))
            .rotationEffect(Angle(degrees: Double(container.angle)))
           
            .offset(offset)
            .mask(
                Rectangle()
                    .frame(width : redactorActive ? w : w, height: redactorActive ? h : h)
                    .rotationEffect(Angle(degrees: Double(container.angle)))
            )
            
            .overlay(
                customPhotoContainer(index: $index, x: x, y: y, w: w, h: h)
            .rotationEffect(Angle(degrees: Double(container.angle)))
//            .frame(width: w, height: h)
//            .border(Color.blue, width: 2)
//            .fixedSize()
//            .scaleEffect(redactor.photoContainers.containers[index].transform.currentScale)
//            .rotationEffect(Angle(degrees: redactor.photoContainers.containers[index].transform.rotate * 180 / .pi))
//
           
//            .offset(x: redactor.photoContainers.containers[index].transform.currentPosition.width, y: redactor.photoContainers.containers[index].transform.currentPosition.height)
//            .mask(
//                Rectangle()
//                    .frame(width : redactorActive ? w : w, height: redactorActive ? h : h)
//            )
//            .contentShape(
//                Rectangle()
//                    .size(CGSize(width: w, height: h))
//            )
//            .frame(width: w, height: h)
            
//            .position(x: x, y: y)
//            .border(Color.red, width: 1)
//            .opacity(0.3)
//            .opacity(redactorActive ? 1 : 0)
         )
            .overlay(
                ToolbarButton(icon: "plus", isSelected: true, size: 25, action: {
//                    print("clear container tap at index: ", index)
//                    if settings2.containers[index].isShowingImagePicker != true {
//                        settings2.containers[index].isShowingImagePicker = true
//                    }
                    settings2.deactivateAllPhotoContainers()
                    settings2.containers[index].redactorActive = true
                    settings2.containers[index].isShowingImagePicker = true
                    //                    isPresentPhotoPicker = true
                })
                .opacity(settings2.containers[index].imageSelected ? 0 : 1 )
                )
//                
            .sheet(isPresented: $settings2.containers[index].isShowingImagePicker, content: {
                PhotoPickerUIView()
            })
            
//            )
            
            
            
//            .overlay(
//                ZStack{
//                    Group{
//                        Rectangle()
//                            .frame(width: 1, height: w)
//                        Rectangle()
//                            .frame(width: w , height: 1)
//                        Rectangle()
//                            .frame(width: 1, height: w)
//                            .position(x: 0, y: h/2)
//                        Rectangle()
//                            .frame(width: w , height: 1)
//                            .position(x: w/2, y: 0)
//                        Rectangle()
//                            .frame(width: w , height: 1)
//                            .position(x: w/2, y: h)
//                        Rectangle()
//                            .frame(width: 1, height: w)
//                            .position(x: w, y: h/2)
//                    }
//                    .rotationEffect(Angle(degrees: Double(container.angle)) )
//                    .foregroundColor(Color.white)
//                }
//            )
            .position(x: x, y: y)
//            .onAppear(perform: {
//                print("photoSelectorWithParams", actualTemplateWith)
                                             //check photo container
//                settings2.activeContainerSize = CGSize(width: w, height: h)
//                settings2.activeContainerPointX = x
//                settings2.activeContainerPointY = y
//                print("load")
                
//            })
            
            

            //            .offset(x: testPhoto.img1.transform.currentPosition.width, y: testPhoto.img1.transform.currentPosition.height)
            
//            .modifier(StrokeDashAnimation(isVisible: $redactorActive, radius: $dashRadius))
            
            

//            .sheet(isPresented: $testPhoto.img1.isShowingImagePicker, content: {
//                PhotoPickerUIView(isPresented: $testPhoto.img1.isShowingImagePicker,
//                                 index: index)
//            }                )
        
//        SwiftUIPhotoSelector(index: index)
//            .frame(width: w, height: h)
//            .modifier(makeTransformingImage(index: index, transforming: $redactorActive, increaser: increaser))
//            .mask(
//                Rectangle()
//                    .frame(width : redactorActive ? w : w, height: redactorActive ? h : h)
//            )
//            .contentShape(
//                Rectangle()
//            )
//            .position(x: x, y: y)
//            .zIndex(2)
    }
}

struct SwiftUIPhotoSelector_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
