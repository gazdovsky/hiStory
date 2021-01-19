//
//  textFieldLayers.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 27.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import SwiftUI
import UIKit

struct textViewWrapper: View {
//    @ObservedObject var settings: selectorContainerStore = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    @Binding var textViewItem: textFieldContainer
    var index: Int
//    @State var w: CGFloat = 100
//    @State var h: CGFloat = 100
    
    var increaser: CGFloat
    
//    @State var c1t: CGFloat = 0
//    @State var c2t: CGFloat = 0
//    @State var fieldHeight: CGFloat = 55
//    func updateWidth(widthIncreaser: CGFloat) -> CGFloat{
//        return w + widthIncreaser < 25 ? 0 : widthIncreaser
//    }
    var body: some View{
        
        HStack(alignment: .firstTextBaseline, content: {
           
//            Circle()
//                .offset(CGSize(width: c1t, height: 0))
//                .frame(width: 20, height: 20)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                .gesture(DragGesture()
//                            .onChanged({
//                                value in
//                                let increaser = updateWidth(widthIncreaser: -value.translation.width)
//                                if increaser != 0 {
//                                    c1t = value.translation.width
//                                    w += increaser
//                                }
//                            })
//                )
//                .opacity(redactor.textFields.activeTextContainer == index && redactor.textFields.indexOfActiveTextContainer() != -1 ? 1 : 0)
            TextView(fieldText: textViewItem.fieldText, //
                     fontSize: textViewItem.fontSize, // * increaser
                     textAlign: textViewItem.textAlign,
                     fontName: textViewItem.fontName,
                     fontColor: textViewItem.fontColor,
                     backgroundColor: textViewItem.backgroundColor,
                     shadowColor: textViewItem.shadowColor,
                     index: index,
                     activeTextContainer: textViewItem.activeTextContainer, //
                     isActive: textViewItem.isActive, //
                     isFirstResponder: textViewItem.isFirstResponder, //
                     fieldHeight: textViewItem.containerH, //
                     fieldWidth: textViewItem.containerW,
                     kern: textViewItem.kern,// * increaser
                     style: textViewItem.style, //
                     increaser: increaser
            )
            .scaleEffect(increaser)
            .onTapGesture{
//                redactor.textFields.textContainers[index].isActive = true
//                redactor.textFields.textContainers[index].isFirstResponder = true
                
                textViewItem.isActive = true
                textViewItem.isFirstResponder = true
                
                redactor.redactorMode = .textEdit
            }
            .zIndex(Double(4))
            .frame(width: textViewItem.containerW, height: textViewItem.containerH) //* increaser
            .fixedSize()
            .modifier(makeTransformingMultilineText(
                        index : index,
                        fontSize: redactor.textFields.textContainers[index].fontSize
                ))
//            Circle()
//                .offset(CGSize(width: c2t, height: 0))
//                .frame(width: 20, height: 20)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                .gesture(DragGesture()
//                            .onChanged({
//                                value in
//                                let increaser = updateWidth(widthIncreaser: value.translation.width)
//                                if increaser != 0 {
//                                    c2t = value.translation.width
//                                    w += increaser
//                                }
//                            })
//                )
//                .opacity(redactor.textFields.activeTextContainer == index && redactor.textFields.indexOfActiveTextContainer() != -1 ? 1 : 0)
            
        })
        .position(x: redactor.textFields.textContainers[index].x * increaser, y: redactor.textFields.textContainers[index].y * increaser)
         //textData.textContainers[index].transform.currentPosition.width * 2 * (1080/231)
        //        Circle()
//            .frame(width: 5, height: 5)
//            .position(x: redactor.textFields.textContainers[index].x * increaser, y: redactor.textFields.textContainers[index].y * increaser)
        
    }
}


struct TextView: UIViewRepresentable {
    
    
    var kbHandler:KeyboardHandler?
    typealias UIViewType = UITextView
//    var settings: selectorContainerStore = .shared
    @ObservedObject var redactor: redactorViewData = .shared
    
//    var textFields: textContainersFrameData = .shared
    var placeholderText: String = "666"
    @State var fieldText: String //
    var fontSize: CGFloat
    var textAlign: Int
    var fontName: String
    var fontColor: String
    var backgroundColor: String
    var shadowColor: String
    var index: Int
     var activeTextContainer: Int //
     var isActive: Bool //
     var isFirstResponder: Bool //
     var fieldHeight: CGFloat //
     var fieldWidth: CGFloat
     var kern: CGFloat
    var style: styleTextContainer //
    var increaser: CGFloat
    //
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont(name: fontName, size: CGFloat(fontSize))
        textView.text = fieldText
        textView.textColor = Color(hex:fontColor).uiColor()
        textView.backgroundColor = Color(hex:backgroundColor).uiColor()
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.allowsEditingTextAttributes = true
        
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: fontSize/10, height: fontSize/10)
        shadow.shadowColor = Color(hex:shadowColor).uiColor()
        shadow.shadowBlurRadius = 1
        
        textView.typingAttributes = [
            NSAttributedString.Key.kern: style.kern,
            NSAttributedString.Key.obliqueness: 0,
            NSAttributedString.Key.shadow: shadow,
            NSAttributedString.Key.strokeWidth: 0,
            NSAttributedString.Key.strokeColor: Color.black.uiColor(),
            NSAttributedString.Key.foregroundColor: fontColor
        ]
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        
        uiView.allowsEditingTextAttributes = true
        
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: fontSize/10, height: fontSize/10)
        shadow.shadowColor = Color(hex:shadowColor).uiColor()
        shadow.shadowBlurRadius = 1
        
        uiView.typingAttributes = [
            NSAttributedString.Key.kern: style.kern,
            NSAttributedString.Key.shadow: shadow
        ]
        
        
        if fieldText != "" || uiView.textColor == .label {
            uiView.text = fieldText
            
            uiView.font = UIFont(name: fontName, size: CGFloat(fontSize))
            uiView.textColor = Color(hex:fontColor).uiColor()
            uiView.backgroundColor = Color(hex:backgroundColor).uiColor()
            uiView.textAlignment = NSTextAlignment(rawValue: textAlign) ?? .center
        }
        if !isActive {
            uiView.endEditing(true)
        }
        if isFirstResponder {
            uiView.becomeFirstResponder()
        } else {
            uiView.endEditing(true)
        }
        DispatchQueue.main.async {
//            fieldHeight = uiView.contentSize.height
            redactor.textFields.textContainers[index].containerH = uiView.contentSize.height
        }
        
        uiView.delegate = context.coordinator
        
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView;
        
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.fieldText = textView.text
            parent.kbHandler = KeyboardHandler { state in
                let duration = state.animationDuration
                UIView.animate(withDuration: duration) {
                    self.parent.redactor.keyboardHeight = Int(state.height)
//                    self.parent.redactor.updateSupposedKeyboardHeight()
                    print("key hide animate", state.height)
                }
            }
            
            
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            parent.kbHandler = KeyboardHandler { state in
                let duration = state.animationDuration
                UIView.animate(withDuration: duration) {
                    self.parent.redactor.keyboardHeight = Int(state.height)
//                    self.parent.redactor.updateSupposedKeyboardHeight()
                    print("key shows animate", state.height)
                }
            }
            if self.parent.redactor.keyboardHeight > 0 {
                self.parent.redactor.textEditor.aTool = .nothing
            }
            parent.redactor.textFields.activeTextContainer = parent.index
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
            }
        }
    }
}


