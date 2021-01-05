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
    @ObservedObject var settings: selectorContainerStore = .shared
    @Binding var textViewItem: textFieldContainer
    var index: Int
    @State var w: CGFloat = 100
    @State var h: CGFloat = 100
    
    @State var c1t: CGFloat = 0
    @State var c2t: CGFloat = 0
    @State var fieldHeight: CGFloat = 55
    func updateWidth(widthIncreaser: CGFloat) -> CGFloat{
        return w + widthIncreaser < 25 ? 0 : widthIncreaser
    }
    var body: some View{
        HStack{
            Circle()
                .offset(CGSize(width: c1t, height: 0))
                .frame(width: 20, height: 20)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .gesture(DragGesture()
                            .onChanged({
                                value in
                                let increaser = updateWidth(widthIncreaser: -value.translation.width)
                                if increaser != 0 {
                                    c1t = value.translation.width
                                    w += increaser
                                }
                            })
                )
                .opacity(settings.activeTextContainer == index && settings.indexOfActiveTextContainer() != -1 ? 1 : 0)
            TextView(fieldText: $textViewItem.fieldText,
                     fontSize: $textViewItem.fontSize,
                     textAlign: textViewItem.textAlign,
                     fontName: textViewItem.fontName,
                     fontColor: textViewItem.fontColor,
                     index: index,
                     activeTextContainer: $textViewItem.activeTextContainer,
                     isActive: $textViewItem.isActive,
                     isFirstResponder: $textViewItem.isFirstResponder,
                     fieldHeight: $fieldHeight,
                     fieldWidth: $w,
                     style: $textViewItem.style
            )
            .onTapGesture{
                settings.textContainers[index].isActive = true
                settings.textContainers[index].isFirstResponder = true
                settings.redactorMode = .textEdit
            }
            .zIndex(Double(4))
            .frame(width: w, height: fieldHeight)
            .fixedSize()
            
            Circle()
                .offset(CGSize(width: c2t, height: 0))
                .frame(width: 20, height: 20)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .gesture(DragGesture()
                            .onChanged({
                                value in
                                let increaser = updateWidth(widthIncreaser: value.translation.width)
                                if increaser != 0 {
                                    c2t = value.translation.width
                                    w += increaser
                                }
                            })
                )
                .opacity(settings.activeTextContainer == index && settings.indexOfActiveTextContainer() != -1 ? 1 : 0)
        }
    }
}


struct TextView: UIViewRepresentable {
    var kbHandler:KeyboardHandler?
    typealias UIViewType = UITextView
    var settings: selectorContainerStore = .shared
    var placeholderText: String = "666"
    @Binding var fieldText: String
    @Binding var fontSize: CGFloat
    var textAlign: Int
    var fontName: String
    var fontColor: String
    var index: Int
    @Binding var activeTextContainer: Int
    
    @Binding var isActive: Bool
    @Binding var isFirstResponder: Bool
    @Binding var fieldHeight: CGFloat
    @Binding var fieldWidth: CGFloat
    var kern: CGFloat = 0.3
    @Binding var style: styleTextContainer
    //
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont(name: fontName, size: CGFloat(fontSize))
        textView.text = placeholderText
        textView.textColor = Color(hex:fontColor).uiColor()
        textView.backgroundColor = .none
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.allowsEditingTextAttributes = true
        
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowColor = Color.gray.uiColor()
        shadow.shadowBlurRadius = 1
        
        textView.typingAttributes = [
            NSAttributedString.Key.kern: $style.kern,
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
        uiView.typingAttributes = [
            NSAttributedString.Key.kern: $style.kern
        ]
        
        
        if fieldText != "" || uiView.textColor == .label {
            uiView.text = fieldText
            uiView.font = UIFont(name: fontName, size: CGFloat(fontSize))
            uiView.textColor = Color(hex:fontColor).uiColor()
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
            self.fieldHeight = uiView.contentSize.height
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
            
            
            
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            parent.kbHandler = KeyboardHandler { state in
                let duration = state.animationDuration
                UIView.animate(withDuration: duration) {
                    self.parent.settings.keyboardHeight = Int(state.height)
                    self.parent.settings.updateSupposedKeyboardHeight()
                    print("key shows animate", state.height)
                }
            }
            parent.settings.activeTextContainer = parent.index
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
            }
        }
    }
}


