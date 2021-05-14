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
    @ObservedObject var storyTemplate: selectorContainer = .shared
    @ObservedObject var photoContainers: photoContainersFrameData = .shared
    @ObservedObject var textFields: textContainersFrameData = .shared
    @ObservedObject var textEditor: textEditorPanelData = .shared
    
    @ObservedObject var colorPickerData: textEditorColorPickerData = .shared
    
    @Published var redactorMode: redactorMode = .nothing
    @Published var templateOpacity: Bool = false
    @Published var keyboardHeight: Int = 0
    @Published var supposedKeyboardHeight: CGFloat = 169
    @Published var redactorOffset: Int = 0
    @Published var templateOffset: CGFloat = 0
    @Published var newTemplateOffset: CGFloat = 0
    @Published var currentIncreaser: CGFloat = 2
    @Published var frameWidth: CGFloat = 300
    @Published var centerPhotoXLineVisible: Bool = false
    @Published var centerPhotoYLineVisible: Bool = true
    @Published var progress: CGFloat = 1
    
    @Published var isAnySheetPresent: Bool = false
    
    func getTemplateOffset() -> CGFloat{
        switch redactorMode {
        case .textEdit:
            if keyboardHeight > 0 {
                if abs(templateOffset) < CGFloat(keyboardHeight) - 30 {
                    return templateOffset
                } else {
                    return CGFloat(-keyboardHeight) + 30
                }
            } else {
                if abs(templateOffset) < CGFloat(supposedKeyboardHeight) - 30 {
                    return templateOffset
                } else {
                    return CGFloat(-supposedKeyboardHeight) + 30
                }
            }
        default:
            return 0
        }
        
    }
    
    func loadAllFromDraft(){
        photoContainers.getImagesFromFolder(folderName: storyTemplate.templateImageName)
        photoContainers.getTransformFromFolder()
//        textFields.importTextFields()
        textFields.getTransformTextFromFolder(folderName: storyTemplate.templateImageName)
//        print("Load text: ", textFields.textContainers.count)
        textFields.getTransformCustomPhotoFromFolder()
//        print("Load custom photos: ", textFields.customPhotoContainers.count)
    }
    func saveTextContainersToItsFolder(){
        let newFolder = photoContainers.createFileDirectory(folderName: storyTemplate.templateImageName)
        textFields.saveTextContainersToFolder(folder: newFolder)
    }
    func saveDraftPreview(){
        //        print(textFields.textContainers)
        let newFolder = photoContainers.createFileDirectory(folderName: storyTemplate.templateImageName)
        textFields.saveTextContainersToFolder(folder: newFolder)
        let draftView = testTextframe(resolution: .low)
//        loadAllFromDraft()
        let draftImage = draftView.asImage(resolution: .low) //.size.applying(CGAffineTransform(scaleX: 0.2, y: 0.2))
//        let draftImageSize
//        let draftImageScale
        photoContainers.saveImageToFolder(image: draftImage, name:"draftImage.jpg", folder: newFolder, compressionQuality: 0.1)
        
        //save to albums
//        UIImageWriteToSavedPhotosAlbum(draftImage, nil, nil, nil)
        //        photoContainers.containers = transformPhotoContainerForRestore
        //        textFields.textContainers = transformTextForRestore
        //        print(textFields.textContainers)
  
//        var newRecentColors = data.newRecentColors
//        newRecentColors.append(colorTarget)
//        UserDefaults.standard.set(newRecentColors, forKey:"newRecentColors")
//        data.newRecentColors = UserDefaults.standard.stringArray(forKey: "newRecentColors") ?? ["ccc"]
        
        storyTemplate.draftStories.addNameToDrafts(storyTemplate.templateImageName)
       
    }
    
    func saveQualityScreenShot(){
        let newFolder = photoContainers.createFileDirectory(folderName: storyTemplate.templateImageName)
        textFields.saveTextContainersToFolder(folder: newFolder)
        let draftView = testTextframe(resolution: .high)
//        loadAllFromDraft()
        let draftImage = draftView.asImage(resolution: .high)
        photoContainers.savePngImageToFolder(image: draftImage, name:"finImage.png", folder: newFolder, compressionQuality: 1)
        //save to albums
        UIImageWriteToSavedPhotosAlbum(draftImage, nil, nil, nil)
    }
    
//    func transformPhotoContainerForRender(){
//        for i in photoContainers.containers.indices {
//            photoContainers.containers[i].transform.currentPosition.width *= storyTemplate.increaser
//            photoContainers.containers[i].transform.currentPosition.height *= storyTemplate.increaser
//        }
//    }
//    
//    func transformTextForRender(){
//        for i in textFields.textContainers.indices {
//            textFields.textContainers[i].transform.currentPosition.width *= storyTemplate.increaser
//            textFields.textContainers[i].transform.currentPosition.height *= storyTemplate.increaser
//        }
//    }
    
    
    func saveAll(){
        let newFolder = photoContainers.createFileDirectory(folderName: storyTemplate.templateImageName)
        photoContainers.saveTransformToFolder()
        textFields.saveTextContainersToFolder(folder: newFolder)
        textFields.saveTransformCustomPhotoToFolder()
    }
    
    func loadAllFromTemplate(){
        textFields.loadTextFieldsFromTemplate(templateImageName:storyTemplate.templateImageName)
        
    }
    
    
    
    func updateSupposedKeyboardHeight() {
        if keyboardHeight == 0 {
        } else if keyboardHeight > 0 {
            supposedKeyboardHeight = CGFloat( keyboardHeight)
        }
    }
    
    func startRender(){
        
        withAnimation() {
            self.progress = 0
        }
        photoContainers.deactivateAllPhotoContainers()
        textFields.deactivateAllTextContainers()
        redactorMode = .nothing
        DispatchQueue.main.async {
            self.saveDraftPreview()
            self.saveQualityScreenShot()
            _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    withAnimation() {
                        self.progress = 1
    //                    if self.rotate >= 1.0 {
    //                        timer.invalidate()
    //                    }
                    }
                }
           
        }
    }
    
    func updateAll(){
        storyTemplate.update.toggle()
    }
    
    
}

struct redactor: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var redactor: redactorViewData = .shared
    
//    @ObservedObject var settings: selectorContainerStore =  .shared
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
    @State var redactorOffset: CGFloat = 0
    @Binding var isNavigateToRedactor: Bool {
        didSet{
            print("back tap")
        }
    }
    var verticalScrollLimit: ClosedRange<CGFloat> {
        if redactor.keyboardHeight > 0 {
//            print(screenH , redactor.storyTemplate.ty , redactor.storyTemplate.th , CGFloat(redactor.keyboardHeight))
            let limit = (screenH - redactor.storyTemplate.ty - redactor.storyTemplate.th - CGFloat(redactor.supposedKeyboardHeight) - 60)
            if limit > 0 {
                return 0...limit
            } else {
               return limit...0
            }
        } else if redactor.redactorMode == .textEdit {
            let limit = (screenH - redactor.storyTemplate.ty - redactor.storyTemplate.th - CGFloat(redactor.supposedKeyboardHeight) - 60)
            if limit > 0 {
                return 0...limit
            } else {
               return limit...0
            }
        }
        return 0...1
    }
    
    var isTemplateScrollNeeded: Bool {
        
//        print( screenH , redactor.storyTemplate.ty , redactor.storyTemplate.th , redactor.getTemplateOffset(),  CGFloat(redactor.keyboardHeight))
        var isKeyboardOverlapTemplate: Bool {
            redactor.keyboardHeight > 0 &&
                screenH - redactor.storyTemplate.ty - (redactor.storyTemplate.th + redactor.getTemplateOffset()) < CGFloat(redactor.keyboardHeight) + 60
        }
//        print(screenH , redactor.storyTemplate.ty , redactor.storyTemplate.th , redactor.supposedKeyboardHeight)
        var isToolBarOverlapTemplate: Bool {
            redactor.keyboardHeight == 0 &&
                screenH - redactor.storyTemplate.ty - redactor.storyTemplate.th < redactor.supposedKeyboardHeight
        }
//        print(isKeyboardOverlapTemplate , isToolBarOverlapTemplate)
       if redactor.redactorMode == .textEdit && ( isKeyboardOverlapTemplate || isToolBarOverlapTemplate ) {
        return true
       }
        return false
    }
    
    var body: some View {
        ZStack(alignment: .top, content:{
            VStack{
                HStack{
                    ToolbarButton(icon: "chevron.left", isSelected: true, size: 25) {
                        // end editing
                        redactor.textFields.deactivateAllTextContainers()
                        redactor.photoContainers.deactivateAllPhotoContainers()
                        redactor.redactorOffset = 0
                        redactor.textEditor.aTool = .nothing
                        redactor.redactorMode = .nothing
                        redactor.saveAll()
                        // go to menu
                        
                        redactor.saveDraftPreview()
//                        redactor.storyTemplate.navigateToRedactor = false
                        isNavigateToRedactor = false
                        redactor.storyTemplate.templateReserveName = "zero"
                        // clear all containers
                        redactor.photoContainers.clearAllContainers()
                        redactor.textFields.clearAllContainers()
//                        redactor.textFields.clearAllCustomPhotoContainers()
                        
                        
                        redactor.updateAll()
                    }
                    .padding(7)
                    
                    //        Spacer()
                    ToolbarButton(icon: "trash", isSelected: true, size: 25){ //icon_trashBusket
                        
                        switch redactor.redactorMode {
                        case .textEdit:
                            redactor.textFields.deleteActiveTextContainer()
                            redactor.textFields.deactivateAllTextContainers()
                            redactor.redactorMode = .nothing
                        //                                redactor.textFields.normalizeZIndexes()
                        case .imageEdit:
                            redactor.photoContainers.refreshPhotoContainer()
                            redactor.redactorMode = .nothing
                        case .nothing:
                            return
                        }
                    }
                    
                    .opacity(redactor.redactorMode == .nothing ? 0 : 1)
                    
                    Spacer()
                    
                    //        ToolbarButton(icon: "doc.on.doc.fill", isSelected: true, size: 25) {
                    //            redactor.textFields.addSmartCopy()
                    //        }
                    
                    Group{ () -> AnyView in
                        switch redactor.redactorMode{
                        case .nothing, .imageEdit : return AnyView(EmptyView())
                        //                case .imageEdit : return AnyView(ImageEditorPanel())
                        case .textEdit : return AnyView(textEditorTopPanel())
                        }
                    }
                    ZStack{
                        Group{
                            
                            ToolbarButton(icon: "checkmark", isSelected: true, size: 25, color: "aaccbb") {
                            }
                            .opacity(redactor.progress == 0 ? 1 : 0)
                            
                            ToolbarButton(icon: "square.and.arrow.down", isSelected: true, size: 25) {
                                redactor.startRender()
                            }
                            
                            .opacity(redactor.progress == 1 ? 1 : 0)
                        }
                        .animation(.easeInOut)
                    }
//                    .zIndex(100)
                    .padding(10)
                }
              
                
                .padding([.leading,.trailing])
                //    .padding(.top, 19)
                .frame(width: screenW )
//                ads()
//                    .overlay(
//                        Text("\(redactor.templateOffset)")
//                    )
//                    .padding([.leading,.trailing])
//                    .cornerRadius(15)
//                Rectangle()
//                    .foregroundColor(Color(hex: "#a07554"))
//                    .frame(height: 20)
                ZStack(alignment: .top, content: {
                   
                    Color(hex: "#a07554")
                        .onTapGesture {
                            redactor.textFields.deactivateAllTextContainers()
                            redactor.redactorOffset = 0
                            redactor.textEditor.aTool = .nothing
                            
                            redactor.redactorMode = .nothing
                            
                            redactor.photoContainers.deactivateAllCContainers()
                            redactor.saveTextContainersToItsFolder()
                            redactor.templateOffset = 0
                            redactor.newTemplateOffset = 0
                            
                            redactor.textFields.clearContainersPairIndexesForCopy()
                        }
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged{ val in
//                                    print(verticalScrollLimit, redactor.newTemplateOffset + val.translation.height)
                                    if verticalScrollLimit ~= redactor.newTemplateOffset + val.translation.height {
                                        redactor.templateOffset = redactor.newTemplateOffset + val.translation.height
                                    }
                                }
                                .onEnded{ val in
                                    if redactor.redactorMode == .textEdit{
                                        redactor.newTemplateOffset = redactor.templateOffset
                                    }
                                }
                        )
//                    Rectangle()
//                        .frame(width: screenW / 1.7, height: screenW / 1.7 * 1.7777777)
//                        .foregroundColor(Color(hex: "#a07554"))
////                        .opacity(0)
//                        .shadow(radius: 10)
//                        .offset(x: 0, y: redactor.getTemplateOffset() )
                    frame1(restoreFromDrafts: restoreFromDrafts)
                        .frame(width: screenW / CGFloat(templateWidthDivider))
                        .aspectRatio(contentMode: .fit)

                        .onAppear {
                            
                            //                     unkomment before build
                            if redactor.storyTemplate.isOpenedDraft {
                                redactor.loadAllFromDraft()
                            } else {
                                redactor.loadAllFromTemplate()
                            }
                        }
                        .background(
                            Color(hex: "#a07554")
                                .aspectRatio(1080/1920, contentMode: .fit)
                                
                        )
                        
                        .mask(Rectangle())
//                        .contentShape(Rectangle())
                        .offset(x: 0, y: redactor.getTemplateOffset() )
                        .shadow(radius: 8)
                        .padding(.top)
                    
                    
                })
//                .overlay(
//                    Rectangle()
//                        .foregroundColor(Color.green)
//                        .opacity(0.4)
//                        .frame(width: 277.875, height: 200)
//                )
                .mask(Rectangle())
                ZStack{
                    MainEditorPanel()
                        .opacity(0)
                }
                
                .padding([.leading,.trailing],21)
                .padding([.top, .bottom], 15)
            }
            .background(
                Color(hex: "#a07554")
                    .edgesIgnoringSafeArea([.bottom,.top])
            )
            //        .edgesIgnoringSafeArea([.bottom,.top]) // if hidden - template compressed when keyboard active
            .edgesIgnoringSafeArea([.bottom])
                    .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            //        .navigationBarItems(trailing:
            //                                HStack(alignment: .bottom){
            //                                    Button("Save"){
            //                                        redactor.saveAll()
            //                                    }
            //
            //                                    .foregroundColor(Color.lightBeige)
            //                                    .padding(.trailing)
            //                                    .font(.custom("Times New Roman", size: 15))
            //                                    ToolbarButton(icon: "square.and.arrow.down", isSelected: true, size: 25, action: {
            ////                                        self.settings.redactorTransform = transformContainer()
            //
            //                                        let image = screenshot(
            //                                            origin: CGPoint(x: redactor.storyTemplate.tx, y: redactor.storyTemplate.ty),
            //                                            size: CGSize(width: redactor.storyTemplate.tw, height: redactor.storyTemplate.th)
            //                                        )
            ////                                        let newFolder = settings.createFileDirectory(folderName: settings.templateImageName)
            ////                                        settings.saveImageToFolder(image: image, name:"scr.jpg", folder: newFolder)
            //                                        if let pngImage = image.toJPG() {
            //                                            UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
            //                                        }
            //
            //                                    })
            //                                }
            //                                .padding()
            //        )
            ZStack(alignment: .bottom, content: {
                Color.clear
                Group{ () -> AnyView in
                    
                    switch redactor.redactorMode{
                    case .nothing, .imageEdit : return AnyView(MainEditorPanel())
                    //                case .imageEdit : return AnyView(ImageEditorPanel())
                    case .textEdit : return AnyView(
                        TextEditorPanel()
                    )
                    }
                }
                //                .frame(width: screenW)
                //                .edgesIgnoringSafeArea([.bottom, .top])
                //                .offset(x: 0, y: 50)
            })
            //            .offset(x: 0, y: 50)
            //            .offset(CGSize(width: 0, height: -redactor.keyboardHeight ))
            //            .padding([.leading,.trailing],21)
            //            .padding([.top, .bottom], 5)
            .edgesIgnoringSafeArea(.bottom)
        })
       
    }
}

struct topPanelButton: View {
    
    var text: String
    var action: () -> () = {}
    var body: some View {
        
        Button(action: {
            
            action()
        }){
            Text(NSLocalizedString(text, comment: "Text format"))
                .padding([.leading,.trailing])
                .padding([.top,.bottom],12)
                .foregroundColor( Color.lightBeige)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        NavigationView {
//            redactor(restoreFromDrafts: false)
//            //            .previewDevice("iPhone X")
//        }
//        .navigationBarColor(backgroundColor: Color.mainBeige.uiColor(), tintColor: .black)
//        .previewDevice("iPhone 8 plus")
//        //    redactor()
//    }
//}
