//
//  MainMenu.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 27.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI
import StoreKit

struct MainMenu: View {
    @ObservedObject var settings: selectorContainerStore =  .shared
    @State var dd = StoryPreviewsCategory
    
    @State var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeigth: CGFloat = UIScreen.main.bounds.height
    
    var mainMenuOffset: CGFloat {
       -(270 + (screenWidth - 270)/2)
    }
    var mainMenuOffset2: CGFloat {
        print((screenWidth - 270)/2)
return        (screenWidth - 270)/2
    }
    
    @State var activeButton: Bool = true
    @State var hideButtons: Bool = false
    @State var showSideMenu: Bool = false
    @State var showProPurchase: Bool = false
    @State var scroll: CGFloat = 0.0
    var baseRatio: CGFloat = 1080/1920
    
    @ObservedObject var storeManager:StoreManager = .shared
   let productIDs = [
    "com.davagaz.historyPro.Month",
    "com.davagaz.historyPro.Year"
    
   ]
    
    
    var itemW: CGFloat{
        screenWidth*0.41
    }
    var itemH: CGFloat{
        itemW/baseRatio
    }
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                Group {
                    Spacer()
                    ToolbarButton(icon: "line.horizontal.3", isSelected: true, size: 25) {
                        showSideMenu.toggle()
                    }
                    .scaleEffect(CGSize(width: 1.0, height: 1.3), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(10)
                    Spacer()
                    mainNavigationButton(text: "Templates", color: settings.activeMainPage == .templates ? Color.elementAccent :  Color.white.opacity(0)) {
                        showSideMenu = false
                        settings.activeMainPage = .templates
                        settings.update.toggle()
                    }
                    mainNavigationButton(text: "My stories", color: settings.activeMainPage == .draft ? Color.elementAccent :  Color.white.opacity(0)){
                        showSideMenu = false
                        settings.activeMainPage = .draft
                        settings.update.toggle()
                    }
                    Spacer()
                    Group{
                        if #available(iOS 14.0, *) {
                            ToolbarButton(icon: "crown.fill", isSelected: true, size: 25, color: "eba147") {
                                showProPurchase =  true
                            }
                        } else {
                            Button {
                                showProPurchase =  true

                            } label: {
                                Text("PRO")
                                    .padding(2)
                                    .background(Color(hex: "eba147" ))
                                    .clipShape(RoundedRectangle(cornerRadius: 2) )
                            }

                        }
                    }
                    
                        .padding(10)
                    Spacer()
               }
                }
                .frame(width: nil, height: hideButtons ? 0 : nil)
                .padding([.top])
                .opacity(hideButtons ? 0 : 1)
//                Button(action: {
//                        storeManager.restoreProducts()
//                    }) {
//                        Text ("Restore Purchases ")
//                    }
//               
//                List(storeManager.myProducts, id: \.self) { product in
//                                               HStack {
//                                                   VStack(alignment: .leading) {
//                                                       Text(product.localizedTitle)
//                                                           .font(.headline)
//                                                       Text(product.localizedDescription)
//                                                    Text("\(UserDefaults.standard.bool(forKey: product.productIdentifier).description)")
//                                                   }
//                                                   Spacer()
//                                                   if UserDefaults.standard.bool(forKey: product.productIdentifier) {
//                                                       Text ("Purchased")
//                                                           .foregroundColor(.green)
//                                                   } else {
//                                                       Button(action: {
//                                                           //Purchase particular ILO product
//                                                        storeManager.purchaseProduct(product: product)
//                                                       }) {
//                                                           Text("Buy for \(product.price) $")
//                                                       }
//                                                           .foregroundColor(.blue)
//                                                   }
//                                               }
//                                           }
                    
                ZStack(alignment: .topLeading , content:{
                    ScrollView(.vertical, showsIndicators: false, content: {
                        ZStack {
                            Rectangle()
                                .cornerRadius(40)
                                .foregroundColor(Color.mineMenuBackground)
                                
                            
                            defaultTemplates()
                            
                               
                            
                            
                            Color.black
                                .cornerRadius(40)
                                .onTapGesture {
                                    showSideMenu = false
                                }
                                .opacity(showSideMenu ? 0.4 : 0)
                        }
                    }
                    )
                    .animation(.easeIn)
                    .offset(CGSize(width: settings.activeMainPage == .templates ? 0 : -screenWidth, height: 0))
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        ZStack{
                            Rectangle()
                                .cornerRadius(40)
                                .foregroundColor(Color.mineMenuBackground)
                            draftTemplates()
                            Color.black
                                .cornerRadius(40)
                                
                                .opacity(showSideMenu ? 0.4 : 0)
                                .onTapGesture {
                                    showSideMenu = false
                                }
                        }
                    })
                    .animation(.easeIn)
                    .offset(CGSize(width: settings.activeMainPage == .draft ? 0 : screenWidth, height: 0))
                    
//                    sideMenu()
//                                                .offset(x: showSideMenu ? 0 : -270, y: 0)
//                                                .animation(.linear, value: showSideMenu)
//                                                .transition(.move(edge: .leading))
                    
                })
                .overlay(
                    ZStack(alignment: .topLeading , content: {
                    sideMenu()
                        .offset(x: showSideMenu ? -mainMenuOffset2 : mainMenuOffset  , y: 0)
                                                .animation(.linear, value: showSideMenu)
                                                .transition(.move(edge: .leading))
                    })
                )
                .offset(x: 0, y: 10)
                .navigationBarColor(backgroundColor: Color.mainBeige.uiColor(), tintColor: .white)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
            }
            .background(
                Color.mainBeige
                    .edgesIgnoringSafeArea(.all)
                    
            )
        }
        
        .overlay(
            ZStack{
                VStack{
                    HStack{
                        Spacer()
                        ToolbarButton(icon: "xmark.circle", isSelected: true, size: 30, color: "000", action: {
                            showProPurchase = false
                        })
                        .padding()
                    }
                    Spacer()
                }
            }
            .background(
                ZStack{
                Group{
                Color.elementAccent
                LinearGradient(
                    gradient: .init(colors: [.clear,.black]),
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 0.6)
                  )
                }
               
                    .edgesIgnoringSafeArea(.all)
                purchasePage()
//                    .resizable()
//                    .scaledToFill()
                }
            )
            .offset(x: 0, y: showProPurchase ? 0 : screenHeigth + 100)
            .animation(.linear, value: showProPurchase)
            .transition(.move(edge: .top))
//            .onAppear(perform: {
//                print(getDocumentsDirectory().absoluteString)
//            })
        )
        
    }
}

extension UIImage {

  func getThumbnail() -> UIImage? {

    guard let imageData = self.pngData() else { return nil }

    let options = [
        kCGImageSourceCreateThumbnailWithTransform: true,
        kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceThumbnailMaxPixelSize: 300] as CFDictionary

    guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
    guard let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }

    return UIImage(cgImage: imageReference)

  }
}

struct mainMenuItem: View {
    @ObservedObject var settings: selectorContainerStore =  .shared
   @State var iPreview: String? = "bage aestetic 3"
//    @Binding var isNavigate: Bool
//    @State var color = Color.red
    @State var w: CGFloat
    @State var h: CGFloat
    @State var isDraftItem: Bool
//    @State var draftItemPreview: UIImage = UIImage()
    
    
    var previewImg: Image {
//        print(settings.templateReserveName, iPreview)
        if !isDraftItem {
            return Image(self.iPreview! + "_PREVIEW" ?? "22")
//            let bundlePath = Bundle.main.path(forResource: iPreview, ofType: "")
//            let image = UIImage(contentsOfFile: bundlePath!)
//            return Image(uiImage: UIImage(contentsOfFile: bundlePath! )!)
//            return Image( uiImage: (UIImage(named: iPreview)?.getThumbnail())! )
        } else {
            let folder = getDocumentsDirectory().appendingPathComponent(iPreview!)
            let name = folder.appendingPathComponent("draftImage.jpg")
            do {
                // note it runs in current thread
                let imageData = try Data(contentsOf: name)
                return Image(uiImage: UIImage(data: imageData)! )
                
               
                
            }
            catch {
            }
            return Image(self.iPreview!)
        }
    }
    var body: some View {
        NavigationLink(destination: redactor(restoreFromDrafts: isDraftItem), tag: iPreview ?? "02", selection: $settings.templateReserveName ){
            VStack{
                Rectangle()
                    .frame(width: self.w, height: self.h) // 169 x 301 iphone 8
                    .opacity(0)
                    .background(
                        previewImg
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                    )
                    .modifier(setPROLabel(isPro: true) )
                    .clipped()
                    .onAppear{
                        print(self.w, self.h)
                    }
            }
            .shadow(radius: 10.0)
        }
    }
}


struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
            .previewDevice("iPhone X")
    }
}


