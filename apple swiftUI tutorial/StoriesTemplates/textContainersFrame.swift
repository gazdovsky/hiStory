//
//  textContainersFrame.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 05.01.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

enum directionOfLayerMovement {
    case up, down
}
class textContainersFrameData:systemFilesWorker, ObservableObject{
    
    static var shared = textContainersFrameData()
    //    @ObservedObject var storyTemplate: selectorContainerStore = .shared
    @ObservedObject var storyTemplate: selectorContainer = .shared
    @Published var textContainers: Array<textFieldContainer> = Array(repeating:  textFieldContainer(), count: 0)
    @Published var customPhotoContainers: Array<customImageDataHolder> = Array(repeating:  customImageDataHolder(), count: 0)
    
    @Published var activeTextContainer = 0 {
        willSet{
            centerXLineVisible = false
            centerYLineVisible = false
        }
    }
    @Published var leftXLineVisible: Bool = false
    @Published var centerXLineVisible: Bool = false
    @Published var rightXLineVisible: Bool = false
    
    @Published var topYLineVisible: Bool = false
    @Published var centerYLineVisible: Bool = false
    @Published var bottomYLineVisible: Bool = false
    
    
    
    
    
    
    @Published var activeFontIndex: Int = 0
    @Published var activeFontFamilyName: String = "Arial"
    @Published var isBoldFontWeightEnable: Bool = false
    @Published var isItalicFontWeightEnable: Bool = false
    
    @Published var textIncreaser: CGFloat = 1080 / (UIScreen.main.bounds.width / CGFloat(templateWidthDivider))
    var smallIncreaser: CGFloat = (UIScreen.main.bounds.width / CGFloat(templateWidthDivider)) / 1080
    var containersPairIndexesForCopy: Array<Int> = Array( repeating: 0, count: 0)
    
    func moveTextLayer(direction: directionOfLayerMovement){
        
        let activeIndex = indexOfActiveTextContainer()
        let activeZIndex = textContainers[activeIndex].z
        let upperLayerIndex = getTextContainerIndexByZIndex(activeZIndex + 1)
        let lowerLayerIndex = getTextContainerIndexByZIndex(activeZIndex - 1)
                
        
        switch direction {
        case .up:
            if upperLayerIndex != -1 {
                textContainers[activeIndex].z += 1
                textContainers[upperLayerIndex].z -= 1
            }
            
        case .down:
            if lowerLayerIndex != -1 {
                textContainers[activeIndex].z -= 1
                textContainers[lowerLayerIndex].z += 1
            }
        }
        
    }
    
    func getTextContainerIndexByZIndex(_ zIndex: Int) -> Int {
        for i in 0..<textContainers.count {
            if textContainers[i].z == zIndex {
                return i
            }
        }
        return -1
    }
  
    
    func getNextZIndex() -> Int {
        var allZ: Array<Int> = []
        for i in 0..<textContainers.count {
            allZ.append(textContainers[i].z)
        }
//        for i in 0..<customPhotoContainers.count {
//            allZ.append(customPhotoContainers[i].imageZIndex)
//        }
        allZ.sort()
        return (allZ.max() ?? 0) + 1
    }

    func addSmartCopy(){
        if indexOfActiveTextContainer() == -1 {return}
        if containersPairIndexesForCopy.count == 0 {
            let originalContainerIndex = indexOfActiveTextContainer()
            let originalContainer = textContainers[originalContainerIndex]
            containersPairIndexesForCopy.append(originalContainerIndex)
            
            var firstCopyOfContainer = originalContainer
            firstCopyOfContainer.y += originalContainer.containerH
            firstCopyOfContainer.z = getNextZIndex()
            deactivateAllTextContainers()
            firstCopyOfContainer.isActive = true
            firstCopyOfContainer.isFirstResponder = true
            
            textContainers.append(firstCopyOfContainer)
            activeTextContainer = textContainers.count - 1
            
            containersPairIndexesForCopy.append(textContainers.count - 1)
//            print(containersPairIndexesForCopy)
        } else if containersPairIndexesForCopy.count == 2 {
            let originalContainer = textContainers[containersPairIndexesForCopy[0]]
            let firstCopyOfContainer = textContainers[containersPairIndexesForCopy[1]]
            var nextCopyOfContainer = textFieldContainer(
                fieldText: firstCopyOfContainer.fieldText,
                fontSize: aproximateCGFloat(originalContainer.fontSize, firstCopyOfContainer.fontSize),
                fontName: firstCopyOfContainer.fontName,
                fontColor: aproximateColorbyHex(originalContainer.fontColor, firstCopyOfContainer.fontColor),
                backgroundColor: aproximateColorbyHex(originalContainer.backgroundColor, firstCopyOfContainer.backgroundColor),
                frameCornerRadius: aproximateCGFloat(originalContainer.frameCornerRadius, firstCopyOfContainer.frameCornerRadius),
                shadowColor: aproximateColorbyHex(originalContainer.shadowColor, firstCopyOfContainer.shadowColor),
                glowColor: aproximateColorbyHex(originalContainer.glowColor, firstCopyOfContainer.glowColor),
                strokeColor: aproximateColorbyHex(originalContainer.strokeColor, firstCopyOfContainer.strokeColor),
                textAlign: firstCopyOfContainer.textAlign,
                x: aproximateCGFloat(originalContainer.x, firstCopyOfContainer.x) + (firstCopyOfContainer.containerW - originalContainer.containerW),
                y: aproximateCGFloat(originalContainer.y, firstCopyOfContainer.y) + (firstCopyOfContainer.containerH - originalContainer.containerH),
                containerW: aproximateCGFloat(originalContainer.containerW, firstCopyOfContainer.containerW) ,
                z: getNextZIndex(),
                transform: transformTextContainer(
                    currentPosition: CGSize(
                        width: aproximateCGFloat(originalContainer.transform.currentPosition.width, firstCopyOfContainer.transform.currentPosition.width),
                        height: aproximateCGFloat(originalContainer.transform.currentPosition.height, firstCopyOfContainer.transform.currentPosition.height)
                    )
                    //                    rotate: <#T##Double#>
                    //                )
                    //            style: <#T##styleTextContainer#>,
                    //            kern: <#T##CGFloat#>
                )
            )
            deactivateAllTextContainers()
            nextCopyOfContainer.isActive = true
            nextCopyOfContainer.isFirstResponder = true
            textContainers.append(nextCopyOfContainer)
            activeTextContainer = textContainers.count - 1
            containersPairIndexesForCopy = [containersPairIndexesForCopy[1],textContainers.count - 1]
        }
        
       
    }
    
    func clearContainersPairIndexesForCopy(){
        containersPairIndexesForCopy = Array( repeating: 0, count: 0)
    }
    
    func aproximateCGFloat(_ f1:CGFloat,_ f2:CGFloat) -> CGFloat {
        let resValue = f2 + (f2 - f1)
        return resValue
    }
    
    func aproximateCGFloatBelowOne(_ f1:CGFloat,_ f2:CGFloat) -> CGFloat {
        let resValue = abs(f2 + (f2 - f1))
        return resValue > 1 ? 1 : resValue
    }
    
    func aproximateColor(_ cs1: String, _ cs2: String) -> String {
        if(cs1 == "00000000" || cs2 == "00000000"){
            return cs1
        }
        let c1 = UIColor.hexColor(hex:cs1)
        let c2 = UIColor.hexColor(hex:cs2)
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        c1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        c2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r3: CGFloat = aproximateCGFloatBelowOne(r1,r2)
        let g3: CGFloat = aproximateCGFloatBelowOne(g1,g2)
        let b3: CGFloat = aproximateCGFloatBelowOne(b1,b2)
        let a3: CGFloat = aproximateCGFloatBelowOne(a1,a2)
        
        let newColor = UIColor(red: r3, green: g3, blue: b3, alpha: a3).toHexString()
//        print(newColor)
        return newColor
    }
    
    func aproximateColorbyHex(_ cs1: String, _ cs2: String) -> String {
        if(cs1 == "00000000" || cs2 == "00000000"){
            return cs1
        }
        if cs1 == cs2 {
            return cs1
        }
        let c1 = UIColor.hexColor(hex:cs1)
        let c2 = UIColor.hexColor(hex:cs2)
        
        var h1: CGFloat = 0, s1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        c1.getHue(&h1, saturation: &s1, brightness: &b1, alpha: &a1)
        
        var h2: CGFloat = 0, s2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        c2.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)
        
     
        a1 = CGFloat(getClearAlphaFromHexString(cs1)) / 255
        a2 = CGFloat(getClearAlphaFromHexString(cs2)) / 255
//print("a1: ", a1," a2: ", a2)
        
        let h3: CGFloat = aproximateCGFloatBelowOne(h1,h2)
        let s3: CGFloat = aproximateCGFloatBelowOne(s1,s2)
        let b3: CGFloat = aproximateCGFloatBelowOne(b1,b2)
        let a3: CGFloat = aproximateCGFloatBelowOne(a1,a2)
        print("hex1: ", cs1, " a1: ", a1," a2: ", a2, " a3: ", a3)
        let newColor = UIColor(hue: h3, saturation: s3, brightness: b3, alpha: 1).toHexString()

        var alpha = String(Int(a3*255), radix: 16)
        alpha.append(newColor)
        return alpha
        
    }

    func getClearAlphaFromHexString(_ hex: String) -> Int {
        let hexWithoutSharp = hex.hasPrefix("#") ? String(hex.dropFirst(1)) : hex
        
        
        if hexWithoutSharp.count == 6 || hexWithoutSharp.count == 3 {return 255}
        let value: Int = Int(hexWithoutSharp.dropLast(6), radix: 16) ?? 255
        
        return value
    }
    
    func updateWeghtsEnable(){
        let fontsList = fontsNamesGlobal
        if fontsList.names[activeFontFamilyName]?.bold == "" {
            isBoldFontWeightEnable = false
        } else {
            isBoldFontWeightEnable = true
        }
        if fontsList.names[activeFontFamilyName]?.italic == "" {
            isItalicFontWeightEnable = false
        } else {
            isItalicFontWeightEnable = true
        }
        
    }
    func clearAllContainers() -> Void{
        textContainers = Array(repeating:  textFieldContainer() , count: textContainers.count)
        for i in textContainers.indices {
            textContainers[i].setTextFieldStatus(.invisible)
        }
    }

    func clearAllCustomPhotoContainers() -> Void{
        customPhotoContainers = Array(repeating:  customImageDataHolder() , count: 0)
//        for i in textContainers.indices {
//            textContainers[i].setTextFieldStatus(.invisible)
//        }
    }

    
    
    func deleteActiveTextContainer() -> Void {

        textContainers[activeTextContainer].setTextFieldStatus(.invisible)
    }
    
    func loadTextFieldsFromTemplate(templateImageName: String) -> Void {
//        print(templateImageName + "texts.JSON")
        if (Bundle.main.path(forResource: templateImageName + "texts.json", ofType: nil) != nil){
//            print("havwetec")
            let newContainers:[textFieldContainer] = readPlst(templateImageName + "texts.json")
            if textContainers.count < newContainers.count {
                textContainers = Array(repeating: textFieldContainer(), count: newContainers.count )
            }
            for i in 0..<newContainers.count{
                textContainers[i] = newContainers[i]
//                print("load", newContainers[i].fieldText, textContainers[i].fieldText)
            }
            
        } else {
        }
    }
    
    func indexOfActiveTextContainer() -> Int{
        var active = 0
        var activeCount = 0
        for i in 0..<textContainers.count {
            if textContainers[i].isActive == true{
                active = i
                activeCount += 1
            }
        }
        active = activeCount > 0 ? active : -1
        return active
    }
    
    func deactivateAllTextContainers(){
        activeTextContainer = 0
        for i in 0..<textContainers.count {
            self.textContainers[i].isActive = false
            self.textContainers[i].isFirstResponder = false
            
        }
    }
    func importTextFields() -> Void{
        if textContainers[0].fieldText != "default" {
            for i in textContainers.indices {
                textContainers[i] = textContainers[i]
            }
            
        }
    }
    func saveTextContainersToFolder(folder: URL){
        let textData = textContainers
//        for i in textData.indices {
//            textData[i].x += textData[i].transform.currentPosition.width / smallIncreaser
//            textData[i].y += textData[i].transform.currentPosition.height / smallIncreaser
//            
//            textData[i].transform.currentPosition.width = 0
//            textData[i].transform.currentPosition.height = 0
//        }
        let encoderText = JSONEncoder()
        let newFolder = folder//createFileDirectory(folderName: templateImageName)
        let filenameText = newFolder.appendingPathComponent("texts.JSON")
        do{let file = try encoderText.encode(textData)
            try file.write(to: filenameText)
        } catch {
        }
        
    }
    func getTransformTextFromFolder(folderName: String){
        
        let decoder = JSONDecoder()
        let folder = getDocumentsDirectory().appendingPathComponent(folderName)
        let name = folder.appendingPathComponent("texts.JSON")
        //        textContainers[0].transform.currentPosition.width *= 2 * (1080/231)
        //        textContainers[0].transform.currentPosition.height *= 2 * (1080/231)
        guard let transformData = try? Data(contentsOf: name) else { return }
        do{
            let textData:[textFieldContainer] = try decoder.decode([textFieldContainer].self, from: transformData)
            
            if textContainers.count < textData.count {
                textContainers = Array(repeating: textFieldContainer(), count: textData.count )
            }
//            print(textContainers.count)
//            print(textData.count)
            
            for i in 0..<textData.count{
                textContainers[i] = textData[i]
                //                print(textData[i].fieldText)
            }
        } catch {
        }
        
    }
    
    func saveCustomPhotoContainerImage(index: Int) -> Void {
        let newFolder = createFileDirectory(folderName: storyTemplate.templateImageName)
         saveImageToFolder(image: customPhotoContainers[index].imageInBlackBox, name:"customPhoto\(index).png", folder: newFolder)
    }
    
    func saveTransformCustomPhotoToFolder(){
        let transformData = customPhotoContainers.map { (x: customImageDataHolder) -> transformContainer in
            return x.transform
        }//[containers[0].transform, containers[1].transform]
        let encoder = JSONEncoder()
        let newFolder = createFileDirectory(folderName: storyTemplate.templateImageName) //story
//        let newFolder = getDocumentsDirectory().appendingPathComponent(templateImageName)
        let filename = newFolder.appendingPathComponent("customImageData.JSON")
        do{let file = try encoder.encode(transformData)
            try file.write(to: filename)
//            savedStorys = getSavedTemplates()
        } catch {
        }
    }
    
    func getTransformCustomPhotoFromFolder(){
        let decoder = JSONDecoder()
        let folder = getDocumentsDirectory().appendingPathComponent(storyTemplate.templateImageName)
        let name = folder.appendingPathComponent("customImageData.JSON")
        guard let transformData = try? Data(contentsOf: name) else { return }
        
        do{
            let file:[transformContainer] = try decoder.decode([transformContainer].self, from: transformData)

            if customPhotoContainers.count < file.count {
                customPhotoContainers = Array(repeating: customImageDataHolder(isShowingImagePicker: false), count: file.count )
            }
            
            for i in 0..<file.count {
                customPhotoContainers[i].transform = file[i]
                            let customImageName = folder.appendingPathComponent("customPhoto\(i).png")
                            let imageData = try? Data(contentsOf: customImageName)
                if imageData == nil {continue}
                else {
                                let image = UIImage(data: imageData!)
                    customPhotoContainers[i].imageInBlackBox = image!
                    customPhotoContainers[i].imageZIndex = 1
                            }
            }
            
//            for i in 0...customPhotoContainers.count-1 {
//                if i < file.count {
//                    customPhotoContainers[i].transform = file[i]
//                }
//            }
//           savedStorys = getSavedTemplates()
        } catch {
        }
    }
}

struct textContainersFrame: View {
    let screenW = UIScreen.main.bounds.width
    @ObservedObject var data: textContainersFrameData = .shared // slower
    @ObservedObject var redactor: redactorViewData = .shared
//    var customPhotoContainers: [customImageDataHolder] {
//        redactor.textFields.customPhotoContainers
//    }
    var textCtrs: [textFieldContainer] {
        redactor.textFields.textContainers
    }
//    @ObservedObject var imageData: imageAdderData = .shared
    var templateWidth: CGFloat
    var body: some View {
        Image(redactor.storyTemplate.templateImageName)
            .resizable()
//            .aspectRatio(1080/1920, contentMode: .fit)
            .opacity(0)
            .overlay(
                ZStack{
                    Rectangle()
//                            .resisable()
                        .shadow(radius: 20)
                        
                        .foregroundColor(Color.white)
                        .opacity(0.0)
                ForEach(textCtrs.indices, id: \.self){ u  -> AnyView in
                    if(textCtrs.count <= u ){
                        return AnyView(EmptyView())
                    }
                    if u < redactor.textFields.textContainers.count && redactor.textFields.textContainers[u].fieldText != "invisibletextview" {
//                        print("increaser", templateWidth / 1080)
                        return AnyView(
                            textViewWrapper(
                                textViewItem: $redactor.textFields.textContainers[u],
                                index: u,
                                increaser: templateWidth / 1080
                            )
                            .zIndex(Double(redactor.textFields.textContainers[u].z))
                        )
                    } else {
                        return AnyView(EmptyView())
                    }
                }
            }
            )
//            .overlay(
//                GeometryReader{ g in
//                    let w = g.size.width / CGFloat(1080)
//
                    .overlay(
                        ZStack{
                            Group{
                                Group{
                                    Rectangle()
                                        .offset(x: -templateWidth/2 + 10, y: 0)
                                        .opacity(redactor.textFields.leftXLineVisible ? 1 : 0)
                                    Rectangle()
                                        .opacity(redactor.textFields.centerXLineVisible ? 1 : 0)
                                    Rectangle()
                                        .offset(x:templateWidth/2 - 10, y: 0)
                                        .opacity(redactor.textFields.rightXLineVisible ? 1 : 0)
                                }
                                .frame(width: 1, height: 1500)
                                Group{
                                    Rectangle()
                                        .offset(x: 0, y: -templateWidth * CGFloat(1.7777)/2 + 40) // 1.7777
                                        .opacity(redactor.textFields.topYLineVisible ? 1 : 0)
                                    Rectangle()
                                        .opacity(redactor.textFields.centerYLineVisible ? 1 : 0)
                                    Rectangle()
                                        .offset(x: 0, y: templateWidth * CGFloat(1.7777)/2 - 40) // 1.7777
                                        .opacity(redactor.textFields.bottomYLineVisible ? 1 : 0)
                                }
                                .frame(width: 1500 , height: 1)
                               
                            }
                            .foregroundColor(Color(hex: "00FFFF"))
                        }
//                        .border(Color.red, width: 1)
                    )
//
////                    ForEach(customPhotoContainers.indices, id: \.self){ u  -> AnyView in // -> AnyView
////                        if(customPhotoContainers.count <= u ){
////                            return AnyView(EmptyView())
////                        }
////                        if u < redactor.textFields.customPhotoContainers.count {
////                            return AnyView(
////                                customImageContainer(index: u, increaser: w)
////                                    .frame(width: redactor.textFields.customPhotoContainers[u].width , height: redactor.textFields.customPhotoContainers[u].height )
////                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
////                                    .scaleEffect(redactor.textFields.customPhotoContainers[u].transform.currentScale * w, anchor: .topLeading )
////                                    .rotationEffect(Angle(degrees: redactor.textFields.customPhotoContainers[u].transform.rotate * 180 / .pi))
//////                                    .overlay(Text("\(redactor.textFields.customPhotoContainers[u].imageZIndex)"))
////                                    .offset(x: (1080/2 - redactor.textFields.customPhotoContainers[u].width / 2) * w  , y: (1920/2  - redactor.textFields.customPhotoContainers[u].height / 2 ) * w)
////                                    .offset(x: redactor.textFields.customPhotoContainers[u].transform.currentPosition.width , y: redactor.textFields.customPhotoContainers[u].transform.currentPosition.height )
////                                    .sheet(isPresented: $redactor.textFields.customPhotoContainers[u].isShowingImagePicker, content: {
////                                        imagePickerUIView(isPresented: $redactor.textFields.customPhotoContainers[u].isShowingImagePicker,
////                                                         index: u)
////                                    }
////                                    )
////                                    .gesture(DragGesture()
////                                                .onChanged({ value in
////                                                    redactor.textFields.customPhotoContainers[u].transform.currentPosition.width = value.translation.width
////                                                    redactor.textFields.customPhotoContainers[u].transform.currentPosition.height = value.translation.height
////                                                })
////                                    )
////                                .zIndex(Double(redactor.textFields.customPhotoContainers[u].imageZIndex))
////                            )
////                        } else {
////                            return AnyView(EmptyView())
////                        }
////                    }
//
//                    .onAppear(
//                        perform: {
//                            if g.size.width < 1080 && redactor.storyTemplate.increaser == 1 {
//                                redactor.storyTemplate.increaser = 1080 / g.size.width
//                                data.increaser = 1080 / g.size.width
//                            }
//                            print(g.size.width)
////                            print("g.size.width: ", g.size.width, "screenW: ", UIScreen.main.bounds.width)
//                        }
//                    )
//                }
//
//            )
//            .border(Color.blue, width: 1)
            //            .mask(Rectangle().frame(width: 300, height: 550))
//            .onAppear {
//                //                     unkomment before build
//                if redactor.storyTemplate.isOpenedDraft {
//                    redactor.loadAllFromDraft()
//                    
//                } else {
////                    redactor.loadAllFromTemplate()
//                }
//            }
    }
}

//struct textContainersFrame_Previews: PreviewProvider {
//    static var previews: some View {
//        textContainersFrame()
//    }
//}


//.overlay(
//    GeometryReader{ g in
//        let w = g.size.width / CGFloat(1080)
//        ZStack{
//            Rectangle()
////                            .resisable()
//                .shadow(radius: 20)
//
//                .foregroundColor(Color.white)
//                .opacity(0.0)
//        ForEach(textCtrs.indices, id: \.self){ u  -> AnyView in
//            if(textCtrs.count <= u ){
//                return AnyView(EmptyView())
//            }
//            if u < redactor.textFields.textContainers.count && redactor.textFields.textContainers[u].fieldText != "invisibletextview" {
//                return AnyView(
//                    textViewWrapper(
//                        textViewItem: $redactor.textFields.textContainers[u],
//                        index: u,
//                        testW: w
//                    )
//                    .zIndex(Double(redactor.textFields.textContainers[u].z))
//                )
//            } else {
//                return AnyView(EmptyView())
//            }
//        }
//    }
//        .overlay(
//            ZStack{
//                Group{
//                    Group{
//                        Rectangle()
//                            .offset(x: -g.size.width/2 + 10, y: 0)
//                            .opacity(redactor.textFields.leftXLineVisible ? 1 : 0)
//                        Rectangle()
//                            .opacity(redactor.textFields.centerXLineVisible ? 1 : 0)
//                        Rectangle()
//                            .offset(x:g.size.width/2 - 10, y: 0)
//                            .opacity(redactor.textFields.rightXLineVisible ? 1 : 0)
//                    }
//                    .frame(width: 1, height: 1500)
//                    Group{
//                        Rectangle()
//                            .offset(x: 0, y: -g.size.height/2 + 40)
//                            .opacity(redactor.textFields.topYLineVisible ? 1 : 0)
//                        Rectangle()
//                            .opacity(redactor.textFields.centerYLineVisible ? 1 : 0)
//                        Rectangle()
//                            .offset(x: 0, y: g.size.height/2 - 40)
//                            .opacity(redactor.textFields.bottomYLineVisible ? 1 : 0)
//                    }
//                    .frame(width: 1500 , height: 1)
//
//                }
//                .foregroundColor(Color(hex: "00FFFF"))
//                Rectangle()
//                    .frame(width:g.size.width, height: g.size.height )
//                    .scaleEffect(0.9)
//                    .foregroundColor(.clear)
//                    .border(Color.white, width: 1)
//                Text("\(g.size.width) \(g.size.height) ")
//            }
//            .border(Color.red, width: 1)
//        )
//
////                    ForEach(customPhotoContainers.indices, id: \.self){ u  -> AnyView in // -> AnyView
////                        if(customPhotoContainers.count <= u ){
////                            return AnyView(EmptyView())
////                        }
////                        if u < redactor.textFields.customPhotoContainers.count {
////                            return AnyView(
////                                customImageContainer(index: u, increaser: w)
////                                    .frame(width: redactor.textFields.customPhotoContainers[u].width , height: redactor.textFields.customPhotoContainers[u].height )
////                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
////                                    .scaleEffect(redactor.textFields.customPhotoContainers[u].transform.currentScale * w, anchor: .topLeading )
////                                    .rotationEffect(Angle(degrees: redactor.textFields.customPhotoContainers[u].transform.rotate * 180 / .pi))
//////                                    .overlay(Text("\(redactor.textFields.customPhotoContainers[u].imageZIndex)"))
////                                    .offset(x: (1080/2 - redactor.textFields.customPhotoContainers[u].width / 2) * w  , y: (1920/2  - redactor.textFields.customPhotoContainers[u].height / 2 ) * w)
////                                    .offset(x: redactor.textFields.customPhotoContainers[u].transform.currentPosition.width , y: redactor.textFields.customPhotoContainers[u].transform.currentPosition.height )
////                                    .sheet(isPresented: $redactor.textFields.customPhotoContainers[u].isShowingImagePicker, content: {
////                                        imagePickerUIView(isPresented: $redactor.textFields.customPhotoContainers[u].isShowingImagePicker,
////                                                         index: u)
////                                    }
////                                    )
////                                    .gesture(DragGesture()
////                                                .onChanged({ value in
////                                                    redactor.textFields.customPhotoContainers[u].transform.currentPosition.width = value.translation.width
////                                                    redactor.textFields.customPhotoContainers[u].transform.currentPosition.height = value.translation.height
////                                                })
////                                    )
////                                .zIndex(Double(redactor.textFields.customPhotoContainers[u].imageZIndex))
////                            )
////                        } else {
////                            return AnyView(EmptyView())
////                        }
////                    }
//
//        .onAppear(
//            perform: {
//                if g.size.width < 1080 && redactor.storyTemplate.increaser == 1 {
//                    redactor.storyTemplate.increaser = 1080 / g.size.width
//                    data.increaser = 1080 / g.size.width
//                }
////                            print("g.size.width: ", g.size.width, "screenW: ", UIScreen.main.bounds.width)
//            }
//        )
//    }
//
//)
