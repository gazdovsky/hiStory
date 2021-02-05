//
//  ContentView.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 14.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//
import UIKit
import SwiftUI
import Combine

enum redactorMode {
    case nothing
    case textEdit
    case imageEdit
}

class redactorViewData: ObservableObject{
        init() {
        }
    
    static var shared = redactorViewData()
    @ObservedObject var storyTemplate: selectorContainerStore = .shared
    @ObservedObject var photoContainers: photoContainersFrameData = .shared
    @ObservedObject var textFields: textContainersFrameData = .shared
    @ObservedObject var textEditor: textEditorPanelData = .shared
    @Published var redactorMode: redactorMode = .nothing
    @Published var templateOpacity: Bool = false
    @Published var keyboardHeight: Int = 0
    @Published var supposedKeyboardHeight: CGFloat = 169
    @Published var redactorOffset: Int = 0
    @Published var currentIncreaser: CGFloat = 2
    @Published var frameWidth: CGFloat = 300
    @Published var centerPhotoXLineVisible: Bool = false
    @Published var centerPhotoYLineVisible: Bool = true
    
    
    func loadAllFromDraft(){
        photoContainers.getImagesFromFolder(folderName: storyTemplate.templateImageName)
        photoContainers.getTransformFromFolder()
//        textFields.importTextFields()
        textFields.getTransformTextFromFolder(folderName: storyTemplate.templateImageName)
        print("Loaded", textFields.textContainers.count)
    }
    func saveTextContainersToItsFolder(){
        let newFolder = photoContainers.createFileDirectory(folderName: storyTemplate.templateImageName)
        textFields.saveTextContainersToFolder(folder: newFolder)
    }
    func saveDraftPreview(){
//        print(textFields.textContainers)
        let newFolder = photoContainers.createFileDirectory(folderName: storyTemplate.templateImageName)
        textFields.saveTextContainersToFolder(folder: newFolder)
//        let transformPhotoContainerForRestore = photoContainers.containers
//        let transformTextForRestore = textFields.textContainers
//        transformPhotoContainerForRender()
//        transformTextForRender()
//        print(textFields.textContainers)

        var draftView = testTextframe()
        loadAllFromDraft()
        var draftImage = draftView.asImage(width: 1080)
        
        photoContainers.saveImageToFolder(image: draftImage, name:"draftImage.jpg", folder: newFolder, compressionQuality: 0.1)
        
        //save to albums
        UIImageWriteToSavedPhotosAlbum(draftImage, nil, nil, nil)
//        photoContainers.containers = transformPhotoContainerForRestore
//        textFields.textContainers = transformTextForRestore
//        print(textFields.textContainers)
    }
    
    func saveQualityScreenShot(draftImage: frame1){
        let newFolder = photoContainers.createFileDirectory(folderName: storyTemplate.templateImageName)
        textFields.saveTextContainersToFolder(folder: newFolder)
        let transformPhotoContainerForRestore = photoContainers.containers
        let transformTextForRestore = textFields.textContainers
        transformPhotoContainerForRender()
        transformTextForRender()
        let draftImage = frame1(restoreFromDrafts: true).asImage(width: 1080)
        UIImageWriteToSavedPhotosAlbum(draftImage, nil, nil, nil)
        photoContainers.containers = transformPhotoContainerForRestore
        textFields.textContainers = transformTextForRestore
//        textFields.saveTextContainersToFolder(folder: newFolder)
    }
    
    func transformPhotoContainerForRender(){
        for i in photoContainers.containers.indices {
            photoContainers.containers[i].transform.currentPosition.width *= storyTemplate.increaser
            photoContainers.containers[i].transform.currentPosition.height *= storyTemplate.increaser
        }
    }
    
    func transformTextForRender(){
        for i in textFields.textContainers.indices {
            textFields.textContainers[i].transform.currentPosition.width *= storyTemplate.increaser
            textFields.textContainers[i].transform.currentPosition.height *= storyTemplate.increaser
        }
    }
    
    
    func saveAll(){
        let newFolder = photoContainers.createFileDirectory(folderName: storyTemplate.templateImageName)
        photoContainers.saveTransformToFolder()
        textFields.saveTextContainersToFolder(folder: newFolder)
    }
    
    func loadAllFromTemplate(){
        textFields.loadTextFieldsFromTemplate(templateImageName:storyTemplate.templateImageName)
    }
    
    
    
    func updateSupposedKeyboardHeight() {
        if keyboardHeight == 0{
        } else if keyboardHeight > 0 {
            supposedKeyboardHeight = CGFloat( keyboardHeight)
        }
    }
}

struct redactor: View {
    @ObservedObject var redactor: redactorViewData = .shared
    @State var h:CGFloat = 330
    @State var w:CGFloat = 180
    @State var barOp = true
    @State private var sharedImage: UIImage?
    @State private var shotting = false
    @State var scaleRed:CGFloat = 1
    let screenW = UIScreen.main.bounds.width
    let screenH = UIScreen.main.bounds.height
    var tGeom: CGRect = CGRect()
    @State var tx: CGFloat = 0
    @State var ty: CGFloat = 0
    @State var tw: CGFloat = 0
    @State var th: CGFloat = 0
    @State var needUpdate: Bool = false
    @State var saveScreenShot: Bool = false
    @State var restoreFromDrafts: Bool = true
//    let draftImage = frame1(restoreFromDrafts: false)
    var body: some View {
        
        ZStack(alignment: .top, content:{
            

 VStack{
    HStack{
        ToolbarButton(icon: "chevron.backward", isSelected: true, size: 15) {
            // end editing
            redactor.textFields.deactivateAllTextContainers()
            redactor.redactorOffset = 0
            redactor.textEditor.aTool = .nothing
            redactor.redactorMode = .nothing
            // go to menu
//            redactor.saveDraftPreview()
            redactor.storyTemplate.navigateToRedactor = false
            // clear all containers
            redactor.photoContainers.clearAllContainers()
            redactor.textFields.clearAllContainers()
        }
        .padding(7)
//        Spacer()
                        ToolbarButton(icon: "trash", isSelected: true, size: 25){ //icon_trashBusket
                            
                            switch redactor.redactorMode {
                            case .textEdit:
                                redactor.textFields.deleteActiveTextContainer()
                                redactor.textFields.deactivateAllTextContainers()
                                redactor.redactorMode = .nothing
                            case .imageEdit:
                                redactor.photoContainers.refreshPhotoContainer()
                                redactor.redactorMode = .nothing
                            case .nothing:
                                return
                            }
                        }
                        .opacity(redactor.redactorMode == .nothing ? 0 : 1)
        
        Spacer()
    ToolbarButton(icon: "square.and.arrow.down", isSelected: true, size: 25) {
            redactor.saveDraftPreview()
    }
    .padding(10)
    }
    .padding([.leading,.trailing])
    .padding(.top, 19)
    .frame(width: screenW )
//            ads()
//                .padding([.leading,.trailing])
//                .cornerRadius(15)
    ZStack{
        Color(hex: "#a07554")
            .onTapGesture {
                redactor.textFields.deactivateAllTextContainers()
                redactor.redactorOffset = 0
                redactor.textEditor.aTool = .nothing
                redactor.redactorMode = .nothing
                redactor.photoContainers.deactivateAllCContainers()
                redactor.saveTextContainersToItsFolder()
            }
        
        
       
        frame1(restoreFromDrafts: restoreFromDrafts)
            .frame(width: 300)
                .aspectRatio(contentMode: .fit)
                .overlay(
                    GeometryReader{geo in
                        ZStack{
                        Rectangle()
                            .opacity(0)
                            .contentShape(
                                Rectangle()
                                    .size(CGSize(width: 1.0, height: 1.0))
                            )
                            .zIndex(0)
                            .onAppear(perform: {
                                if(geo.frame(in: .global).midX > 0){
                                    redactor.storyTemplate.tx = geo.frame(in: .global).midX
                                    redactor.storyTemplate.ty = geo.frame(in: .global).midY
                                    redactor.storyTemplate.tw = geo.frame(in: .global).width
                                    redactor.storyTemplate.th = geo.frame(in: .global).height
                                }
                            })
                        }
                    }
                )
                
                .onAppear {
//                     unkomment before build
                    if redactor.storyTemplate.isOpenedDraft {
                        redactor.loadAllFromDraft()
                    } else {
                        redactor.loadAllFromTemplate()
                    }
                }
    }
    ZStack{
        MainEditorPanel()
            .opacity(0)
    }
//    .frame(height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    .padding([.leading,.trailing],21)
    .padding([.top, .bottom], 15)
        }
// .offset(CGSize(width: 0,
//                height: redactor.keyboardHeight > 0 || redactor.redactorMode != .textEdit ? -redactor.keyboardHeight : redactor.redactorOffset))
        .background(Color(hex: "#a07554"))
 
        .edgesIgnoringSafeArea([.bottom,.top])
 
        .navigationBarTitle("", displayMode: .inline)
 
        .navigationBarHidden(true)
        .navigationBarItems(trailing:
                                HStack(alignment: .bottom){
                                    Button("Save"){
                                        redactor.saveAll()
                                    }
                                    
                                    .foregroundColor(Color(hex: "f4d8c8"))
                                    .padding(.trailing)
                                    .font(.custom("Times New Roman", size: 15))
                                    ToolbarButton(icon: "square.and.arrow.down", isSelected: true, size: 25, action: {
//                                        self.settings.redactorTransform = transformContainer()
                                        
                                        let image = screenshot(
                                            origin: CGPoint(x: redactor.storyTemplate.tx, y: redactor.storyTemplate.ty),
                                            size: CGSize(width: redactor.storyTemplate.tw, height: redactor.storyTemplate.th)
                                        )
//                                        let newFolder = settings.createFileDirectory(folderName: settings.templateImageName)
//                                        settings.saveImageToFolder(image: image, name:"scr.jpg", folder: newFolder)
                                        if let pngImage = image.toJPG() {
                                            UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
                                        }
                                        
                                    })
                                }
                                .padding()
        )
   
            ZStack(alignment: .bottom, content: {
                Color.clear
                Group{ () -> AnyView in
                switch redactor.redactorMode{
                case .nothing, .imageEdit : return AnyView(MainEditorPanel())
//                case .imageEdit : return AnyView(ImageEditorPanel())
                case .textEdit : return AnyView(TextEditorPanel())
                }
                }
                
                .frame(width: screenW)
                
            }
            
//                MainEditorPanel()
//                    .opacity(redactor.redactorMode == .nothing ? 1 : 0)
//                ImageEditorPanel()
//                    .opacity(redactor.redactorMode == .imageEdit ? 1 : 0)
//                TextEditorPanel()
//                    .opacity(redactor.redactorMode == .textEdit ? 1 : 0)
            )
            .offset(CGSize(width: 0, height: -redactor.keyboardHeight ))
//            .padding([.leading,.trailing],21)
//            .padding([.top, .bottom], 5)
            .edgesIgnoringSafeArea(.bottom)
            
        })
        
    }


    
}





struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            redactor(restoreFromDrafts: false)
            //            .previewDevice("iPhone X")
        }
        .navigationBarColor(backgroundColor: UIColor.hexColor(hex: "#bb8a62"), tintColor: .black)
        .previewDevice("iPhone 8 plus")
        //    redactor()
    }
}
