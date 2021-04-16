//
//  UIPicker.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 30.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

struct pickerFontsUI: View {
    var body: some View{
        VStack{
            pickerFonts()
//                .scaleEffect(0.1)
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .fixedSize()
                .border(Color.black, width: 1)
                .mask(
                Rectangle()
                    .frame(width: nil, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                )
        }
    }
}

struct pickerFontsUI_Preview: PreviewProvider {
    static var previews: some View{
        pickerFontsUI()
    }
}


let fontsNamesGlobal = fonts()
struct pickerFonts: UIViewRepresentable {
    typealias UIViewType = UIPickerView
//    var settings: selectorContainerStore = .shared
    var textFields: textContainersFrameData = .shared
//    var fontsList = fonts()
    var activeTextContainer: Int {
        textFields.indexOfActiveTextContainer()
    }
//    let fontsList =
    var dataSource = fontsNamesGlobal.regularNames()
//        ["AmericanTypewriter", "Arial", "Baskerville", "Bradley Hand", "ChalkboardSE-Regular", "Cochin", "Copperplate", "Courier", "DINCondensed", "Didot", "Georgia", "GillSans", "Helvetica", "HoeflerText", "Menlo", "MarkerFelt","Noteworthy","Palatino", "PingFangHK", "SavoyeLet", "SnellRoundhand", "Verdana", "Zapfino", "20db", "Accuratist", "Ardeco", "Bender","Cuprum", "Days", "DitaSweet", "EleventhSquare"]
    
    
    
    func makeUIView(context: UIViewRepresentableContext<pickerFonts>) -> UIPickerView {
        let picker = UIPickerView()
        
        picker.clipsToBounds = true
        
        picker.dataSource = context.coordinator
        
        picker.delegate = context.coordinator
        
        let fontFamily = textFields.textContainers[activeTextContainer].getFontFamily()
        
        for (index, name ) in dataSource.enumerated() {
            if name[0] == fontFamily {
                textFields.activeFontIndex = index
            }
        }
        
        picker.selectRow(textFields.activeFontIndex, inComponent: 0, animated: false)
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: UIViewRepresentableContext<pickerFonts>) {
        
//        settings.textContainers[activeTextContainer].fontName = dataSource[uiView.selectedRow(inComponent: 0)]
    }
    
    func makeCoordinator() -> pickerFonts.Coordinator {
        return pickerFonts.Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate{
        var parent: pickerFonts
        init(_ pickerView: pickerFonts) {
            self.parent = pickerView
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            parent.textFields.textContainers[parent.activeTextContainer].fontName = parent.dataSource[row][1]
            parent.textFields.activeFontFamilyName = parent.dataSource[row][0]
            parent.textFields.activeFontIndex = row
            parent.textFields.updateWeghtsEnable()
            parent.textFields.textContainers[parent.activeTextContainer].setWeight(.regular)
        }
        
        //number of components
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
//        func selectRow(3,1,false){}
        //number of rows
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return parent.dataSource.count
        }
        //height of each row
//        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//            return 40
//        }
        
        //view of row
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 150))
            let pickerLabel = UILabel(frame: view.bounds)
            pickerLabel.textAlignment = .center
            pickerLabel.font = UIFont(name: parent.dataSource[row][1], size: 18)
            pickerLabel.text = parent.dataSource[row][0]
            view.addSubview(pickerLabel)
            
            return view
        }
        
        
    }
    
    
}


