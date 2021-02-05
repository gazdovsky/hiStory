//
//  MainMenu.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 27.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI


struct MainMenu: View {
    @ObservedObject var settings: selectorContainerStore =  .shared
//    @State var tt = StoryPreviews
    @State var dd = StoryPreviewsCategory
//     var savedStorys:[String] {
//       return settings.getSavedTemplates()
//    }
    @State var screenWidth:CGFloat = UIScreen.main.bounds.width
//    @State var screenHeigth:CGFloat = UIScreen.main.bounds.height
    @State var activeButton: Bool = true
    @State var hideButtons: Bool = false
    @State var scroll: CGFloat = 0.0
    var baseRatio:CGFloat = 1080/1920
    var itemW:CGFloat{
        screenWidth*0.41
    }
    var itemH:CGFloat{
        itemW/baseRatio
    }
    var body: some View {

        
        NavigationView{
            VStack{
                HStack{
                    ToolbarButton(icon: "line.horizontal.3.circle", isSelected: true) {
                        
                    }
                    .scaleEffect(0.7)
                    mainNavigationButton(text: "Templates",
                                         color: !activeButton ? Color.white.opacity(0) : Color(hex: "#59361c")) {
                        activeButton.toggle()
                    }
                    mainNavigationButton(text: "My stories",
                                         color: activeButton ? Color.white.opacity(0) : Color(hex: "#59361c")){
//                        settings.getSavedTemplates()
                        activeButton.toggle()
                    }
                    ToolbarButton(icon: "star",  isSelected: true) {
                        settings.clearDrafts()
                    }
                    .scaleEffect(0.7)
                }
                .frame(width: nil, height: hideButtons ? 0 : nil)
                .padding(.bottom)
                .opacity(hideButtons ? 0 : 1)
//                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                ZStack{
                ScrollView(.vertical, showsIndicators: false, content: {
//                    ZStack{
                ZStack{
                    Rectangle()
                        .cornerRadius(40)
                        .foregroundColor(.white)
                  defaultTemplates()
                        
                        
                }
                }
                )
                .offset(CGSize(width: activeButton ? 0 : -screenWidth, height: 10.0))
                ScrollView(.vertical, showsIndicators: false, content: {
                    ZStack{
                        Rectangle()
                            .cornerRadius(40)
                            .foregroundColor(.white)
                        draftTemplates()
                    }
                    })
                .offset(CGSize(width: !activeButton ? 0 : screenWidth, height: 10.0))
                }
                .animation(.easeIn)
            .navigationBarColor(backgroundColor: UIColor.hexColor(hex: "#a07554"), tintColor: .white)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        }
            .background(
                Color(hex: "#a07554")
                            .edgesIgnoringSafeArea(.all)
            )
            
        }
        
}
}

struct mainMenuItem: View {
    @ObservedObject var settings: selectorContainerStore =  .shared
    var iPreview: itemPreview
    @Binding var isNavigate: Bool
    @State  var color = Color.red
    @State  var w:CGFloat
    @State  var h:CGFloat
    @State var isDraftItem: Bool
    @State var draftItemPreview: UIImage = UIImage()
    var previewImg: Image {
        if !isDraftItem {
        return Image(self.iPreview.image)
        } else {
            let folder = getDocumentsDirectory().appendingPathComponent(iPreview.name)
            let name = folder.appendingPathComponent("draftImage.jpg")
            
            do {
                // note it runs in current thread
                let imageData = try Data(contentsOf: name)
                return Image(uiImage: UIImage(data: imageData)!)
            }
            catch {
            }
            return Image(self.iPreview.image)
        }
    }
    var body: some View {
        NavigationLink(destination: redactor(restoreFromDrafts: isDraftItem), isActive: $isNavigate ){
            VStack{
                Rectangle()
                    .frame(width: self.w, height: self.h)
                    .opacity(0)
                    .background(
                        
                        previewImg
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                    )
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


