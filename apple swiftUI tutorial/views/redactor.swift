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
    @Published var redactorMode: redactorMode = .nothing
    @Published var templateOpacity: Bool = false
    @Published var keyboardHeight: Int = 0
    @Published var supposedKeyboardHeight: Int = 260
    @Published var redactorOffset: Int = 0
    
    func updateSupposedKeyboardHeight() {
        if keyboardHeight == 0{
        } else if keyboardHeight > 0 {
            supposedKeyboardHeight = keyboardHeight
        }
    }
}

struct redactor: View {
    @ObservedObject var redactor: redactorViewData = .shared
//    @ObservedObject var settings: selectorContainerStore = .shared
//    @ObservedObject var settings2: photoContainersFrameData = .shared
    @State var h:CGFloat = 330
    @State var w:CGFloat = 180
    @State var barOp = true
    @State private var sharedImage: UIImage?
    @State private var shotting = false
    @State var scaleRed:CGFloat = 1
    let screenW = UIScreen.main.bounds.width
    let screenH = UIScreen.main.bounds.height
//    @State var redactorMode: redactorMode = .nothing
    var tGeom: CGRect = CGRect()
    @State var tx: CGFloat = 0
    @State var ty: CGFloat = 0
    @State var tw: CGFloat = 0
    @State var th: CGFloat = 0
    @State var needUpdate: Bool = false
    @State var saveScreenShot: Bool = false
    var body: some View {
        ZStack{
 VStack{
    HStack{
        ToolbarButton(icon: "chevron.backward", isSelected: true, size: 15) {
            redactor.storyTemplate.navigateToRedactor = false
            redactor.photoContainers.clearAllContainers()
        }
        .padding()
        Spacer()
    ToolbarButton(icon: "square.and.arrow.down", isSelected: true, size: 25, action: {
//                                        self.settings.redactorTransform = transformContainer()
//        saveScreenShot = true
        //        let image = screenshot(
//            origin: CGPoint(x: settings.tx, y: settings.ty),
//            size: CGSize(width: settings.tw, height: settings.th)
//        )
//                                        let newFolder = settings.createFileDirectory(folderName: settings.templateImageName)
//                                        settings.saveImageToFolder(image: image, name:"scr.jpg", folder: newFolder)
//        if let pngImage = image.toJPG() {
//            UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
//        }
        let draftImage = frame1(restoreFromDrafts: true).asImage()
        UIImageWriteToSavedPhotosAlbum(draftImage, nil, nil, nil)
        
        let newFolder = redactor.photoContainers.createFileDirectory(folderName: redactor.storyTemplate.templateImageName)
        redactor.photoContainers.saveImageToFolder(image: draftImage, name:"draftImage.jpg", folder: newFolder)
    })
    .padding()
    }
    .padding([.leading,.trailing])
//    .padding(.bottom,0)
    .padding(.top, 15)
            ads()
                .padding(0)
                .overlay(
                    VStack{
                        Text("\(redactor.storyTemplate.tx.description) \(redactor.storyTemplate.ty.description) \(redactor.storyTemplate.tw.description) \(redactor.storyTemplate.th.description)")
                    }
                )
            ZStack{
            frame1()
                .scaleEffect(scaleRed)
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
                            .overlay(
//                                    VStack{
                                //button always works properly if it here
                                    Button(action: {
                                        let image = screenshot(
                                            origin: CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY),
                                            size: CGSize(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
                                        )
//                                            let newFolder = settings.createFileDirectory(folderName: settings.templateImageName)
//                                            settings.saveImageToFolder(image: image, name:"scr.jpg", folder: newFolder)

                                        if let pngImage = image.toJPG() {
                                            UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
                                        }

//                                        UIImageWriteToSavedPhotosAlbum(frame1().asImage(), nil, nil, nil)
                                        
                                    }, label: {
                                        Text("Save")
                                    })
                                    .fixedSize()
                                    .position(x: 0, y: 0)
                                    .offset(x: 0, y: -50)
                                    )
                                        
                                    //next commented lines for somereasons gives different values
//                                        Text("3 \(geo.frame(in: .global).debugDescription)")
//                                        geometryReaderTransfer(geo: geo.frame(in: .global), geoStr: geo.frame(in: .global).debugDescription)
//                                        Text("\(geo.frame(in: .global).midX)")
//                                        Text("\(geo.frame(in: .global).midY)")
//                                        Text("\(geo.frame(in: .global).width)")
//                                        Text("\(geo.frame(in: .global).height)")
//                                        Text("\(settings.tx) \(settings.ty) \(settings.tw) \(settings.th)") //text checker if one of values is 0 - its brake
//                                    }
//                                )
                        }
                    }
                )
//                    .modifier(makeTransformingRedaktorView())
//                .offset(x: 0, y: settings.redactorMode == .textEdit &&
//                            settings.indexOfActiveTextContainer() != -1 &&
//                            settings.keyboardHeight > 0 &&
//                            settings.textContainers[settings.activeTextContainer].transform.currentPosition.height < 0 ?
//                            -(settings.textContainers[settings.activeTextContainer].transform.currentPosition.height -
//                             (screenH - CGFloat(settings.keyboardHeight))/4) : 0)
//                .offset(x:0, y:CGFloat(settings.screenOffset))
            }
    ZStack{
        MainEditorPanel()
            .opacity(0)
    }
    .padding([.leading,.trailing],21)
    .padding([.top, .bottom], 15)
        }
 .offset(CGSize(width: 0, height: redactor.keyboardHeight > 0 || redactor.redactorMode != .textEdit ? -redactor.keyboardHeight : redactor.redactorOffset))
        .background(Color(hex: "#bb8a62"))
 .edgesIgnoringSafeArea([.bottom,.top])
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarItems(trailing:
                                HStack(alignment: .bottom){
                                    Button("Save"){
                                        redactor.storyTemplate.saveTransformToFolder()
                                        redactor.storyTemplate.saveTextContainersToFolder()
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
                MainEditorPanel()
                    .opacity(redactor.redactorMode == .nothing ? 1 : 0)
                ImageEditorPanel()
                    .opacity(redactor.redactorMode == .imageEdit ? 1 : 0)
                TextEditorPanel()
                    .opacity(redactor.redactorMode == .textEdit ? 1 : 0)
                    
            })
            .offset(CGSize(width: 0, height: -redactor.keyboardHeight))
            .padding([.leading,.trailing],21)
            .padding([.top, .bottom], 15)
            .edgesIgnoringSafeArea(.bottom)
            
        }
        
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            redactor()
            //            .previewDevice("iPhone X")
        }
        .navigationBarColor(backgroundColor: UIColor.hexColor(hex: "#bb8a62"), tintColor: .black)
        .previewDevice("iPhone 11 Pro Max")
        //    redactor()
    }
}
