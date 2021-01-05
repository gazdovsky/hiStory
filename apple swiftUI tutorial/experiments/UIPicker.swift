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
        }
    }
}

struct pickerFontsUI_Preview: PreviewProvider {
    static var previews: some View{
        pickerFontsUI()
    }
}



struct pickerFonts: UIViewRepresentable {
    typealias UIViewType = UIPickerView
    var settings: selectorContainerStore = .shared

    var activeTextContainer: Int {
        settings.indexOfActiveTextContainer()
    }
    var dataSource = ["Cochin-BoldItalic", "Didot", "Georgia", "Helvetica", "Helvetica-Light", "HelveticaNeue-UltraLight", "HoeflerText-BlackItalic", "HoeflerText-Italic", "IowanOldStyle-BoldItalic", "MarkerFelt-Thin", "Noteworthy-Bold", "Palatino-BoldItalic"]
    
    func makeUIView(context: UIViewRepresentableContext<pickerFonts>) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
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
            parent.settings.textContainers[parent.activeTextContainer].fontName = parent.dataSource[row]
        }
        
        //number of components
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
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
            pickerLabel.font = UIFont(name: parent.dataSource[row], size: 18)
            pickerLabel.text = parent.dataSource[row]
            
            view.addSubview(pickerLabel)
            
            return view
        }
        
        
    }
    
    
}
