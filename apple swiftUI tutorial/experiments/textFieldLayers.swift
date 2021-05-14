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
//    @ObservedObject var data: textContainersFrameData = .shared
    @Binding var textViewItem: textFieldContainer
    var index: Int
//    @State var w: CGFloat = 100
//    @State var h: CGFloat = 100
    
//    var testW: CGFloat
    var increaser: CGFloat
    var actualTemplateWidth: CGFloat {
       
        return increaser * 1080
    }
//    @State var c1t: CGFloat = 0
//    @State var c2t: CGFloat = 0
//    @State var fieldHeight: CGFloat = 55
//    func updateWidth(widthIncreaser: CGFloat) -> CGFloat{
//        return w + widthIncreaser < 25 ? 0 : widthIncreaser
//    }
    @State var dash: Bool = true
    
    @State var anchor: UnitPoint = .center
    @State var offset: CGSize = .zero
    @State var isPinching: Bool = false
    @State var scalerPosiition: CGSize = .zero
    @State var needSynchronizeDrag: Bool = true
    @State var tempFontSize: CGFloat = 1
    @State var tempContainerW: CGFloat = 1
    @State var tempFrameCornerRadius: CGFloat = 0
    @State var needSynchronizeWidthDrag: Bool = true
    var borderWidthForTest: CGFloat = 0
    var additionComandButtonOffset: CGFloat = 22
    @State var newrotate: Double = 0.0
    @State var additionalHorizontalOffset: CGFloat = 0
    @State var additionalDiagonalOffset: CGFloat = 0
    
    @State var center: CGPoint = CGPoint(x: 0, y: 0)
     var dot: CGPoint { CGPoint(x: textViewItem.containerW/2 * increaser, y: -textViewItem.containerH/2 * increaser) }
    @State var newDot: CGPoint = CGPoint(x: 0, y: 0)
    @State var newRotate: Angle = .zero
    @State var supDegree: Double = .zero
    
    var diagonalScaleIcon: String {
        if #available(iOS 14.0, *) {
            return "arrow.up.backward.and.arrow.down.forward.circle.fill"
        } else {
            return "arrow.left.and.right.circle.fill"
        }
    }
    var diagonalScaleIconRotation: Double {
        if #available(iOS 14.0, *) {
        return 0
        } else {
            return 45
        }
    }
    let gragientColors = Gradient(colors: [.purple,.yellow])
    var body: some View{
        
        
        
        ZStack(content: {
            TextView(fieldText: textViewItem.fieldText,
                     isUppercased: textViewItem.isUppercased,
                     fontSize: textViewItem.fontSize,
                     textAlign: textViewItem.textAlign,
                     fontName: textViewItem.fontName,
                     fontColor: textViewItem.fontColor,
                     backgroundColor: textViewItem.backgroundColor,
                     frameCornerRadius: textViewItem.frameCornerRadius,
                     shadowColor: textViewItem.shadowColor,
                     glowColor: textViewItem.glowColor,
                     strokeColor: textViewItem.strokeColor,
                     index: index,
                     activeTextContainer: textViewItem.activeTextContainer,
                     isActive: textViewItem.isActive,
                     isFirstResponder: textViewItem.isFirstResponder,
                     fieldHeight: textViewItem.containerH,
                     fieldWidth: textViewItem.containerW,
                     style: textViewItem.style,
                     increaser: increaser
            )
            .rotationEffect(newRotate)
//            .background(
//                LinearGradient(gradient: gragientColors, startPoint: .bottomLeading, endPoint: .topTrailing)
//            )
            
            .clipShape(RoundedRectangle(cornerRadius: textViewItem.frameCornerRadius))
            .modifier(StrokeDashAnimation(isVisible: $textViewItem.isActive, radius: $textViewItem.frameCornerRadius))
            .scaleEffect(increaser)
            .onTapGesture{
                redactor.textFields.deactivateAllTextContainers()
                redactor.textFields.activeTextContainer = index
                textViewItem.isActive = true
                textViewItem.isFirstResponder = true
                
                redactor.redactorMode = .textEdit
                
            }

            .frame(width: textViewItem.containerW, height: textViewItem.containerH)
            .fixedSize()
            
            Rectangle()
                .frame(width: 44, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.clear)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: borderWidthForTest)
                .contentShape(Rectangle())
                .overlay(
                    Image(systemName: diagonalScaleIcon)
                        .rotationEffect(Angle(degrees: diagonalScaleIconRotation))
                        .zIndex(5)
                        .foregroundColor(Color(UIColor.label))
                )
                .offset(x: textViewItem.containerW/2 * increaser , y: textViewItem.containerH/2 * increaser )
                .offset(x: additionalDiagonalOffset, y: additionalDiagonalOffset)
                .gesture(DragGesture()
                            .onChanged({ value in
                                if needSynchronizeDrag {
                                    tempFontSize = redactor.textFields.textContainers[index].fontSize
                                    tempContainerW = redactor.textFields.textContainers[index].containerW
                                    tempFrameCornerRadius = redactor.textFields.textContainers[index].frameCornerRadius
                                    needSynchronizeDrag = false
                                }
                                withAnimation{ additionalDiagonalOffset = getAdditionalComandButtonOffset(.diagonal)}
                                withAnimation{ additionalHorizontalOffset = getAdditionalComandButtonOffset(.horizontal)}
                               
//                                if value.translation.width * (textViewItem.containerH / textViewItem.containerW) < 3 {
//                                    return
//                                }
                                
                                scalerPosiition.width = value.translation.width
                                scalerPosiition.height = value.translation.width * (textViewItem.containerH / textViewItem.containerW)
                                
                                redactor.textFields.textContainers[index].containerW = tempContainerW + (value.translation.width / increaser ) * 2
                                redactor.textFields.textContainers[index].fontSize = tempFontSize * ( redactor.textFields.textContainers[index].containerW / tempContainerW )
                                redactor.textFields.textContainers[index].frameCornerRadius = tempFrameCornerRadius * ( redactor.textFields.textContainers[index].containerW / tempContainerW )
                            })
                            .onEnded({ _ in
                                tempFontSize = redactor.textFields.textContainers[index].fontSize
                                tempContainerW = redactor.textFields.textContainers[index].containerW
                                tempFrameCornerRadius = redactor.textFields.textContainers[index].frameCornerRadius
                            })
                )
                .opacity(textViewItem.isActive ? 1 : 0)

            Rectangle()
                .frame(width: 44, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.clear)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: borderWidthForTest)
                .contentShape(Rectangle())
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle.fill")
                        .foregroundColor(Color(UIColor.label))
                )
                .offset(x: -textViewItem.containerW/2 * increaser , y: 0)
                .offset(x: -additionalHorizontalOffset)
                .gesture(DragGesture(minimumDistance: 0)
                            .onChanged{ value in
                                if  needSynchronizeWidthDrag {
                                tempContainerW = redactor.textFields.textContainers[index].containerW
                                    needSynchronizeWidthDrag = false
                                }
                                withAnimation{ additionalHorizontalOffset = getAdditionalComandButtonOffset(.horizontal)}
                                withAnimation{ additionalDiagonalOffset = getAdditionalComandButtonOffset(.diagonal)}
                                if tempContainerW - (value.translation.width / increaser ) * 2 < 3 {
                                    return
                                }
                                
                                
                                redactor.textFields.textContainers[index].containerW = tempContainerW - (value.translation.width / increaser ) * 2
                            }
                            .onEnded{_ in
                                
                                tempContainerW = redactor.textFields.textContainers[index].containerW
                            }
                )
                .opacity(textViewItem.isActive ? 1 : 0)
            
            Rectangle()
                .frame(width: 44, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.clear)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: borderWidthForTest)
                .contentShape(Rectangle())
                .overlay(
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .foregroundColor(Color(UIColor.label))
                )
                .offset(x: textViewItem.containerW/2 * increaser , y: -textViewItem.containerH/2 * increaser )
                .offset(x: additionalDiagonalOffset, y: -additionalDiagonalOffset)
                .opacity(textViewItem.isActive ? 1 : 0)
                .gesture(DragGesture()
                            .onChanged{value in
                                newDot = CGPoint(x: value.translation.width, y: value.translation.height)
                                let dotVelocity = CGPoint(x: value.translation.width + dot.x, y: value.translation.height + dot.y)
                                let degrees = Angle(degrees: Double(
                                    atan2(center.y - dotVelocity.y, center.x - dotVelocity.x) -
                                    atan2(dotVelocity.y - dot.y, dotVelocity.x - dot.x)
                                ))
                                
                                var supposedDegree = Double(degrees.degrees)
//                                if supposedDegree > .pi {
//                                    supposedDegree = supposedDegree - .pi
//                                } else if supposedDegree < -.pi {
//                                    supposedDegree = supposedDegree + .pi
//                                }
                                supDegree = abs(supposedDegree)
                                newRotate = Angle(radians: supposedDegree)
                              print(supDegree, newRotate ,newDot)
                                
                            }
                            .onEnded { _ in
                                redactor.textFields.textContainers[index].transform.rotate = 0
                            }
                                )
                
        })
      
        .modifier(makeTransformingMultilineText(
            index : index,
            increaser: increaser,
            activeContainer: $textViewItem
        ))
//        .fixedSize()
//        .border(Color.black, width: 1)
        
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
    
    var isTextFieldSmall: Bool {
        if textViewItem.containerW * increaser < 80 {
            return true
        }
        return false
    }
//    var additionComandButtonHorizontalOffset: CGFloat {
//        return isTextFieldSmall ? additionComandButtonOffset : 0
//    }
//    var additionComandButtonDiagonalOffset: CGFloat {
//        let bc: CGFloat = additionComandButtonOffset
//        let ac: CGFloat = sqrt((bc * bc) / 2)
//        return isTextFieldSmall ? ac : 0
//    }
    enum comandButtonDirection {
        case horizontal, diagonal
    }
    func getAdditionalComandButtonOffset(_ direction: comandButtonDirection) -> CGFloat {
        if !isTextFieldSmall {
            return 0
        }
        switch direction {
        case .diagonal:
            let bc: CGFloat = additionComandButtonOffset
            let ac: CGFloat = sqrt((bc * bc) / 2)
            return ac
        case .horizontal:
            return additionComandButtonOffset
        }
    }
}


struct TextView: UIViewRepresentable {
    
    var kbHandler:KeyboardHandler?
    typealias UIViewType = UITextView
    @ObservedObject var redactor: redactorViewData = .shared
    var placeholderText: String = "666"
    @State var fieldText: String //
    var isUppercased: Bool
    var fontSize: CGFloat
    var textAlign: Int
    var fontName: String
    var fontColor: String
    var backgroundColor: String
    var frameCornerRadius: CGFloat
    var shadowColor: String
    var glowColor: String
    var strokeColor: String
    var index: Int
    var activeTextContainer: Int
    var isActive: Bool
    var isFirstResponder: Bool
    var fieldHeight: CGFloat
    var fieldWidth: CGFloat
    var style: styleTextContainer
    var increaser: CGFloat
    var strokewidth: CGFloat = -2
    //
    @State var anchor: UnitPoint = .center
    @State var offset: CGSize = .zero
    @State var isPinching: Bool = false
//    var pinchZoom: PinchZoom = PinchZoom(anchor: $anchor, offset: <#Binding<CGSize>#>, isPinching: <#Binding<Bool>#>)
//     var startLocation: CGPoint = .zero
//    var location: CGPoint = .zero
//    var numberOfTouches: Int = 0
    var textFontSize: CGFloat = 1
    var kern: CGFloat = 1
    var startX: CGFloat = 0
    var startY: CGFloat = 0
    
    var blurStyle: UIBlurEffect.Style = .systemUltraThinMaterialLight
    
      
    
    func makeShadow() -> NSShadow {
        let shadow = NSShadow()
        shadow.shadowOffset = shadowColor == "00000000" ? .zero : CGSize(width: fontSize/15, height: fontSize/15)
        shadow.shadowColor =  shadowColor == "00000000" ? Color(hex:glowColor).uiColor() : Color(hex:shadowColor).uiColor()
        shadow.shadowBlurRadius = shadowColor == "00000000" ? fontSize/10 : 1
        return shadow
    }
    var shadow: NSShadow{ makeShadow()}
    
     func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        var isshadowup: Bool = false
//        bufText = redactor.textFields.textContainers[index].fieldText
        
        textView.font = UIFont(name: fontName, size: CGFloat(fontSize))
//        textView.autocapitalizationType = .allCharacters
//        textView.text = redactor.textFields.textContainers[index].fieldText
        switch isUppercased {
        case false:
            textView.text = redactor.textFields.textContainers[index].fieldText
        case true:
            textView.text = redactor.textFields.textContainers[index].fieldText.uppercased()
        }
        
        

        textView.textColor = Color(hex:fontColor).uiColor()
        
        textView.backgroundColor = Color(hex:backgroundColor).uiColor() //UIColor(hex: backgroundColor)
       
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.allowsEditingTextAttributes = true
        
       
        
      
        textView.typingAttributes = [
            NSAttributedString.Key.kern: style.kern,
//            NSAttributedString.Key.obliqueness: 0,
            NSAttributedString.Key.shadow: isshadowup ? nil : shadow,

            NSAttributedString.Key.strokeWidth: strokewidth,
            NSAttributedString.Key.strokeColor: Color(hex: strokeColor).uiColor(),
           
            NSAttributedString.Key.foregroundColor: fontColor,
            NSAttributedString.Key.underlineStyle: style.underlineStyle,
            NSAttributedString.Key.strikethroughStyle: style.strikethroughStyle
        ]
//        print("textView", textView.text, "made")
        DispatchQueue.main.async {
            if index < redactor.textFields.textContainers.count{
                redactor.textFields.textContainers[index].containerH = textView.contentSize.height
                isshadowup = true
            }
            }
        
        let tapGesture = UIPinchGestureRecognizer(target: context.coordinator,
               action: #selector(Coordinator.handleTap(gesture:)))
        textView.addGestureRecognizer(tapGesture)
//         return v
        
//        let contentSize = textView.sizeThatFits(textView.bounds.size)
//        textView.frame.size = textView.sizeThatFits(textView.bounds.size)

        
//        print("textView", textView.text, "made")
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        let selectedRange = uiView.selectedRange
        uiView.allowsEditingTextAttributes = true
        
//        let shadow = NSShadow()
//        shadow.shadowOffset = shadowColor == "00000000" ? .zero : CGSize(width: fontSize/10, height: fontSize/10)
//        shadow.shadowColor =  shadowColor == "00000000" ? Color(hex:glowColor).uiColor() : Color(hex:shadowColor).uiColor()
//        shadow.shadowBlurRadius = shadowColor == "00000000" ? fontSize/5 : 1
//        uiView.autocapitalizationType = .allCharacters
        
        uiView.typingAttributes = [
            NSAttributedString.Key.kern: style.kern,
            NSAttributedString.Key.shadow: shadow,
            NSAttributedString.Key.strokeWidth: strokewidth,
            NSAttributedString.Key.strokeColor: Color(hex: strokeColor).uiColor(),
            
    
            NSAttributedString.Key.underlineStyle: style.underlineStyle,
            NSAttributedString.Key.strikethroughStyle: style.strikethroughStyle
        ]
        
        
//        if fieldText != "" {
      
//        uiView.text = redactor.textFields.textContainers[index].fieldText.uppercased()
//            uiView.text = redactor.textFields.textContainers[index].fieldText //fieldText
            
            uiView.font = UIFont(name: fontName, size: CGFloat(fontSize))
            uiView.textColor = Color(hex:fontColor).uiColor()
        

        uiView.backgroundColor = Color(hex:backgroundColor).uiColor() //UIColor(hex: backgroundColor)
//        if style.backgroundBlur != -1 && backgroundColor == "00000000"{
//            uiView.addBlurredBackground(style: UIBlurEffect.Style(rawValue: style.backgroundBlur ) ?? .regular )
            
//            uiView.addSubview( UIImageView(image: UIImage(named: "tOp")))
            
//        }
        
        
            uiView.textAlignment = NSTextAlignment(rawValue: textAlign) ?? .center
//        }
        if !isActive {
            uiView.endEditing(true)
        }
        if isFirstResponder {
//            uiView.becomeFirstResponder()
           
        } else {
            uiView.endEditing(true)
        }
      
        DispatchQueue.main.async {
            if index < redactor.textFields.textContainers.count && redactor.textFields.textContainers[index].containerH != uiView.contentSize.height {
                redactor.textFields.textContainers[index].containerH = uiView.contentSize.height
            }
            }

//        redactor.textFields.textContainers[index].fieldText = uiView.text // break capitalisation if turn on

        
        switch isUppercased {
        case false:
            uiView.text = redactor.textFields.textContainers[index].fieldText
        case true:
            uiView.text = redactor.textFields.textContainers[index].fieldText.uppercased()
        }
        
//       print(redactor.textFields.textContainers[index].fieldText)
//        print(uiView.text)
        uiView.delegate = context.coordinator
        uiView.selectedRange = selectedRange
//        print("update", redactor.textFields.textContainers[index].fieldText)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        @objc func handleTap(gesture: UIPinchGestureRecognizer) {

            switch gesture.state {
            case .began:
                parent.textFontSize = parent.redactor.textFields.textContainers[parent.index].fontSize
                parent.fieldWidth = parent.redactor.textFields.textContainers[parent.index].containerW
                parent.frameCornerRadius = parent.redactor.textFields.textContainers[parent.index].frameCornerRadius
                parent.kern = parent.redactor.textFields.textContainers[parent.index].style.kern
                
                parent.startX = parent.redactor.textFields.textContainers[parent.index].x
                parent.startY = parent.redactor.textFields.textContainers[parent.index].y
                
            case .changed:
                parent.redactor.textFields.textContainers[parent.index].fontSize = parent.textFontSize * gesture.scale
                parent.redactor.textFields.textContainers[parent.index].containerW = parent.fieldWidth * gesture.scale
                parent.redactor.textFields.textContainers[parent.index].frameCornerRadius = parent.frameCornerRadius * gesture.scale
                parent.redactor.textFields.textContainers[parent.index].style.kern =  parent.kern * gesture.scale
         
            case .ended, .cancelled, .failed: break
            default:
                break
            }
          }
        
        
        
        var parent: TextView;
        
        
        init(_ parent: TextView) {
            self.parent = parent
        }
      
        func textViewDidChange(_ textView: UITextView) {
            parent.redactor.textFields.textContainers[parent.index].fieldText = textView.text
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
                }
            }
            if self.parent.redactor.keyboardHeight > 0 {
                self.parent.redactor.textEditor.aTool = .nothing
            }
            if parent.redactor.textFields.textContainers[parent.index].fieldText == "Your text"{
                parent.redactor.textFields.textContainers[parent.index].fieldText = ""
            }
            parent.redactor.textFields.activeTextContainer = parent.index
        }
        
        func textViewShouldEndEditing (_ textView: UITextView) -> Bool {

            return true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {

            if textView.text == "" {
                textView.text = parent.placeholderText
            }
        }
    }
}

extension UIView{
func addBlurredBackground(style: UIBlurEffect.Style) {
    deleteBlurredBackground()
    let blurEffect = UIBlurEffect(style: style)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = self.frame
//    blurView.alpha = 0.5
    blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.addSubview(blurView)
    self.sendSubviewToBack(blurView)
}
    func deleteBlurredBackground(){
        if self.subviews.filter({$0 is UIVisualEffectView}).count > 0 {
        self.subviews.filter{$0 is UIVisualEffectView}[0].removeFromSuperview()
        }
    }
    
}
