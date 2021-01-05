//
//  saveTest.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.


import SwiftUI

struct saveTest: View {
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        HStack{
          Button(action: {
            saveImg()
            
          }, label: {
            Rectangle()
            .size(width: 100, height: 100)
                .fill(Color.green)
          })
        }
    }
}
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    print(paths[0])
    return paths[0]
}

func saveImg(){
//if let image = UIImage(named: "frame1") {
//    if let data = image.jpegData(compressionQuality: 0.8) {
//        let filename = getDocumentsDirectory().appendingPathComponent("copyoiio.png")
//        try? data.write(to: filename)
//    }
//}
    
    UIImageWriteToSavedPhotosAlbum(UIImage(named: "frame1")!, nil ,nil, nil)
    
}
struct saveTest_Previews: PreviewProvider {
    static var previews: some View {
        saveTest()
    }
}

