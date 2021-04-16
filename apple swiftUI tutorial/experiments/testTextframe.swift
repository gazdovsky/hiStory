//
//  testTextframe.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 03.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct testTextframe: View {
    @ObservedObject var data: textContainersFrameData = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    @State var imageWidth: CGFloat = 2160
    var resolution: imageResolution
        
    var increasedSize: CGSize {
        switch resolution {
        case .low: return CGSize(width: 540, height: 960)
        case .normal: return CGSize(width: 1080, height: 1920)
        case .high: return CGSize(width: 2160, height: 3840)
        case .ultra:  return CGSize(width: 3240, height: 5760)
        }
    }
        
    @State var screenWidth: CGFloat = UIScreen.main.bounds.width
    var body: some View {
        Image(redactor.storyTemplate.templateImageName)
            .resizable()
            .overlay(
        ZStack{
            photoContainersFrame(templateWidth: increasedSize.width)
//        ForEach(0 ..< data.textContainers.count, id: \.self){ u  -> AnyView  in
//            if data.textContainers[u].fieldText != "invisibletextview" {
//                return AnyView( textViewWrapper(
//            textViewItem: $data.textContainers[u],
//            index: u,
//            increaser: imageWidth/1080)
//            .zIndex(Double(data.textContainers[u].z))
//                )
//            } else {
//                return AnyView(EmptyView())
//            }
//        }
            textContainersFrame(templateWidth: increasedSize.width)
            
//            ForEach(data.customPhotoContainers.indices, id: \.self){ u  -> AnyView in // -> AnyView
//                if(data.customPhotoContainers.count <= u ){
//                    return AnyView(EmptyView())
//                }
//                if u < data.customPhotoContainers.count {
//                    return AnyView(
//                        customImageContainer(index: u, increaser: imageWidth/1080)
//                            .frame(width: data.customPhotoContainers[u].width, height: data.customPhotoContainers[u].height)
//
//                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//
//                            .scaleEffect(data.customPhotoContainers[u].transform.currentScale, anchor: .topLeading )
//
//                            .rotationEffect(Angle(degrees: data.customPhotoContainers[u].transform.rotate * 180 / .pi))
//                            .offset(
//                                x: (data.customPhotoContainers[u].transform.currentPosition.width ) * data.increaser ,
//                                y: (data.customPhotoContainers[u].transform.currentPosition.height ) * data.increaser)
//                            .sheet(isPresented: $data.customPhotoContainers[u].isShowingImagePicker, content: {
//                                imagePickerUIView(isPresented: $data.customPhotoContainers[u].isShowingImagePicker,
//                                                 index: u)
//                            }
//                            )
//                        .zIndex(Double(data.customPhotoContainers[u].imageZIndex))
//                    )
//                } else {
//                    return AnyView(EmptyView())
//                }
//            }
            
        }
//        .onAppear(perform: {
//            print("imageWidth: ", imageWidth / 1080, "data.increaser: ", data.increaser, "screenW: ", UIScreen.main.bounds.width )
//        })
            )
//            .scaleEffect(0.2)
    }
    
}

//struct testTextframe_Previews: PreviewProvider {
//    static var previews: some View {
//        testTextframe()
//    }
//}
