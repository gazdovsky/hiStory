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
    
    @State var increaser: CGFloat
//    @State var c1t: CGFloat = 0
//    @State var c2t: CGFloat = 0
//    @State var fieldHeight: CGFloat = 55
//    func updateWidth(widthIncreaser: CGFloat) -> CGFloat{
//        return w + widthIncreaser < 25 ? 0 : widthIncreaser
//    }
    @State var dash: Bool = true
    
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
                     style: textViewItem.style, //
                     increaser: increaser
            )
            .modifier(StrokeDashAnimation(isVisible: $textViewItem.isActive))
            .scaleEffect(increaser)
            .onTapGesture{
                textViewItem.isActive = true
                textViewItem.isFirstResponder = true
                redactor.redactorMode = .textEdit
            }
            .zIndex(Double(4))
            
            .frame(width: textViewItem.containerW, height: textViewItem.containerH) //* increaser
            
            .fixedSize()
            
            .modifier(makeTransformingMultilineText(
                        index : index,
                        fontSize: redactor.textFields.textContainers[index].fontSize,
                increaser: increaser
                ))
//            .gesture(MagnificationGesture(minimumScaleDelta: 1)
//                        .onChanged({ newScale in
//                            textViewItem.containerW = textViewItem.containerW * newScale
//                        })
//            )
        })
        .onAppear(perform: {
//            print("TEXT x: ",x,", y: ",y)
//            textViewItem = redactor.textFields.textContainers[index]
            
        })
        .position(x: x, y: y)
    }

    var x: CGFloat{
        if increaser < 0.1 {
            return redactor.textFields.textContainers[index].x
        } else {
            return redactor.textFields.textContainers[index].x * increaser
        }
    }
    var y: CGFloat{
        if increaser < 0.1 {
            return redactor.textFields.textContainers[index].y
        } else {
            return redactor.textFields.textContainers[index].y * increaser
        }
    }

}


struct TextView: UIViewRepresentable {
    
    var kbHandler:KeyboardHandler?
    typealias UIViewType = UITextView
    @ObservedObject var redactor: redactorViewData = .shared
    var placeholderText: String = "666"
    @State var fieldText: String //
    var fontSize: CGFloat
    var textAlign: Int
    var fontName: String
    var fontColor: String
    var backgroundColor: String
    var shadowColor: String
    var index: Int
    var activeTextContainer: Int
    var isActive: Bool
    var isFirstResponder: Bool
    var fieldHeight: CGFloat
    var fieldWidth: CGFloat
    var style: styleTextContainer
    var increaser: CGFloat
    //
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        
        textView.font = UIFont(name: fontName, size: CGFloat(fontSize))
        textView.text = redactor.textFields.textContainers[index].fieldText
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
            NSAttributedString.Key.foregroundColor: fontColor,
            NSAttributedString.Key.underlineStyle: style.underlineStyle,
            NSAttributedString.Key.strikethroughStyle: style.strikethroughStyle
        ]
//        print("textView", textView.text, "made")
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
            NSAttributedString.Key.shadow: shadow,
            NSAttributedString.Key.underlineStyle: style.underlineStyle,
            NSAttributedString.Key.strikethroughStyle: style.strikethroughStyle
        ]
        
        
        if fieldText != "" {
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
            redactor.textFields.textContainers[index].containerH = uiView.contentSize.height
        }
        redactor.textFields.textContainers[index].fieldText = fieldText
        uiView.delegate = context.coordinator
//        print("textView", redactor.textFields.textContainers[index].fieldText, "update")
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
//                    print("key hide animate", state.height)
                }
            }
            
            
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            parent.kbHandler = KeyboardHandler { state in
                let duration = state.animationDuration
                UIView.animate(withDuration: duration) {
                    self.parent.redactor.keyboardHeight = Int(state.height)
//                    self.parent.redactor.updateSupposedKeyboardHeight()
//                    print("key shows animate", state.height)
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


