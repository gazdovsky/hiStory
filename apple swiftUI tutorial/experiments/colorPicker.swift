//
//  colorPicker.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 10.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI


struct colorPicker: View {
    @State var size: CGSize = CGSize(width: 250, height: 85)
    private var colors: [Color] = {
        // 1
        let hueValues = Array(0...359)
        // 2
        return hueValues.map {
            Color(UIColor(hue: CGFloat($0) / 359.0 ,
                          saturation: 1.0,
                          brightness: 1.0,
                          alpha: 1.0))
        }
    }()
    var linearGradientHeight: CGFloat = 200
    @State var hexColor: String = "ecc9af"
    @Binding var chosenColor: Color
    private var currentColor: Color {
        Color(UIColor.init(hue: self.normalizeGesture() / linearGradientHeight, saturation: 1.0, brightness: 1.0, alpha: 1.0))
    }
    // 1
    @State private var isDragging: Bool = false
    
    // 2
    private var circleWidth: CGFloat {
        isDragging ? 15 : 15
    }
    /// 2
    /// Normalize our gesture to be between 0 and 200, where 200 is the height.
    /// At 0, the users finger is on top and at 200 the users finger is at the bottom
    private func normalizeGesture() -> CGFloat {
        let offset = startLocation + dragOffset.width // Using our starting point, see how far we've dragged +- from there
        let maxX = max(0+2, offset) // We want to always be greater than 0, even if their finger goes outside our view
        let minX = min(maxX, linearGradientHeight-2) // We want to always max at 200 even if the finger is outside the view.
        
        return minX
    }
    
    @State private var startLocation: CGFloat = .zero // 2
    @State private var dragOffset: CGSize = .zero // 3
    // 4
    init(chosenColor: Binding<Color>) {
        self._chosenColor = chosenColor
    }
    var body: some View{
        
        
        VStack{
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: colors),
                               startPoint: .leading,
                               endPoint: .trailing)
                    .frame(width: 200, height: 10)
                    .cornerRadius(5)
                    .shadow(radius: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2.0)
                    )
                    .gesture(
                        DragGesture()
                            .onChanged({ (value) in
                            self.dragOffset = value.translation
                            self.startLocation = value.startLocation.x
                            self.chosenColor = self.currentColor
                                self.isDragging = true
                        })
                                                    .onEnded({ (_) in
                                                        self.isDragging = false
                                                    })
                    )
                Circle()
                    .foregroundColor(self.currentColor)
                    .frame(width: self.circleWidth, height: self.circleWidth, alignment: .center)
                    .shadow(radius: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: self.circleWidth / 2.0).stroke(Color.white, lineWidth: 2.0)
                    )
                    .offset(x: self.normalizeGesture() - linearGradientHeight / 2, y: self.isDragging ? 0.0 : 0.0 )
                    .animation(Animation.spring().speed(2))
//                    .opacity(0.1)
            }
//            Rectangle()
//                .frame(width: nil, height: size.height, alignment: .center)
//                .cornerRadius(20)
//                .foregroundColor(currentColor)
//            Text("\(normalizeGesture())")
        }
    }
}


struct colorPickerHex: View {
    @State var size: CGSize = CGSize(width: 250, height: 85)
    private var colors: [Color] = {
        // 1
        let hueValues = Array(0...359)
        // 2
        return hueValues.map {
            Color(UIColor(hue: CGFloat($0) / 359.0 ,
                          saturation: 1.0,
                          brightness: 1.0,
                          alpha: 1.0))
        }
    }()
    var linearGradientHeight: CGFloat = 200
//    var hexColor = "ecc9af"
    @Binding var chosenColor: String // 1
    private var currentColor: Color {
        Color(UIColor.init(hue: self.normalizeGesture() / linearGradientHeight, saturation: 1.0, brightness: 1.0, alpha: 1.0))
    }
    // 1
    @State private var isDragging: Bool = false
    
    // 2
    private var circleWidth: CGFloat {
        isDragging ? 15 : 15
    }
    /// 2
    /// Normalize our gesture to be between 0 and 200, where 200 is the height.
    /// At 0, the users finger is on top and at 200 the users finger is at the bottom
    private func normalizeGesture() -> CGFloat {
        let offset = startLocation + dragOffset.width // Using our starting point, see how far we've dragged +- from there
        let maxX = max(0+2, offset) // We want to always be greater than 0, even if their finger goes outside our view
        let minX = min(maxX, linearGradientHeight-2) // We want to always max at 200 even if the finger is outside the view.
        
        return minX
    }
    
    @State private var startLocation: CGFloat = .zero // 2
    @State private var dragOffset: CGSize = .zero // 3
    // 4
    init(chosenColor: Binding<String>) {
        self._chosenColor = chosenColor
    }
    var body: some View{
        
        
        VStack{
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: colors),
                               startPoint: .leading,
                               endPoint: .trailing)
                    .frame(width: 200, height: 10)
                    .cornerRadius(5)
                    .shadow(radius: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2.0)
                    )
                    .gesture(
                        DragGesture()
                            .onChanged({ (value) in
                            self.dragOffset = value.translation
                            self.startLocation = value.startLocation.x
                                self.chosenColor = self.currentColor.uiColor().toHexString()
                                self.isDragging = true
                        })
                                                    .onEnded({ (_) in
                                                        self.isDragging = false
                                                    })
                    )
                Circle()
                    .foregroundColor(self.currentColor)
                    .frame(width: self.circleWidth, height: self.circleWidth, alignment: .center)
                    .shadow(radius: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: self.circleWidth / 2.0).stroke(Color.white, lineWidth: 2.0)
                    )
                    .offset(x: self.normalizeGesture() - linearGradientHeight / 2, y: self.isDragging ? 0.0 : 0.0 )
                    .animation(Animation.spring().speed(2))
//                    .opacity(0.1)
            }
//            Rectangle()
//                .frame(width: nil, height: size.height, alignment: .center)
//                .cornerRadius(20)
//                .foregroundColor(currentColor)
//            Text("\(normalizeGesture())")
        }
    }
}


struct colorPickerHexWithSaturation: View {
//    @State var size: CGSize = CGSize(width: 250, height: 85)
    private var colors: [Color] = {
        // 1
        let hueValues = Array(0...359)
        // 2
        return hueValues.map { hue in
            Color(UIColor(hue: CGFloat(hue) / 359.0,
                          saturation: CGFloat(hue) / 359.0,
                          brightness: 1.0,
                          alpha: 1.0))
        }
    }()
    func gradientGet(sat: CGFloat) -> [Color] {
        let hueValues = Array(0...359)
        return hueValues.map { hue in
            Color(UIColor(hue: CGFloat(hue) / 359.0,
                          saturation: CGFloat(sat),
                          brightness: 1.0,
                          alpha: 1.0))
        }
    }
    func gradientGetBri(bri: CGFloat) -> [Color] {
        let hueValues = Array(0...359)
        return hueValues.map { hue in
            Color(UIColor(hue: CGFloat(hue) / 359.0,
                          saturation: 1.0,
                          brightness: 1 - CGFloat(bri),
                          alpha: 1.0))
        }
    }
    var gradientWidth: CGFloat = 300
    var gradientHeight: CGFloat = 150
    var gradientResolution: CGFloat = 50
    
    @Binding var chosenColor: String // 1
    private var currentColor: Color {
        Color(UIColor.init(hue: 0.5 + 1/gradientWidth * pickerPosition.width,
                           saturation: pickerPosition.height < 0 ? 1 + (1/(gradientHeight/2)) * pickerPosition.height : 1,
                           brightness: pickerPosition.height > 0 ? 1 - (1/(gradientHeight/2)) * pickerPosition.height : 1,
                           alpha: 1))
    }
    
    @State var pickerPosition: CGSize = CGSize()
    // 1
    @State private var isDragging: Bool = false
    
    // 2
    private var circleWidth: CGFloat {
        isDragging ? 15 : 15
    }
    /// 2
    /// Normalize our gesture to be between 0 and 200, where 200 is the height.
    /// At 0, the users finger is on top and at 200 the users finger is at the bottom
   
    
    @State private var startLocation: CGFloat = .zero // 2
    @State private var dragOffset: CGSize = .zero // 3
    // 4
    init(chosenColor: Binding<String>) {
        self._chosenColor = chosenColor
    }
    var body: some View{
        VStack{
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Rectangle()
                    .frame(width: gradientWidth, height: gradientHeight)
                    .overlay(
                        ZStack{
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                            ForEach (0..<Int(gradientResolution)) { s in
                        LinearGradient(gradient: Gradient(colors: gradientGet(sat: CGFloat(s)/gradientResolution) ),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                            .frame(width: gradientWidth, height: gradientHeight/2/gradientResolution)
                            .padding(0)
                        }
                            ForEach (0..<Int(gradientResolution)) { s in
                        LinearGradient(gradient: Gradient(colors: gradientGetBri(bri: CGFloat(s)/gradientResolution) ),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                            .frame(width: gradientWidth, height: gradientHeight/2/gradientResolution)
                            .padding(0)
                        }
                        }
                        )
                            Circle()
                                .strokeBorder(currentColor, lineWidth: 8)
                                .frame(width: 20, height: 20)
                                .offset(pickerPosition)
                                .gesture(DragGesture()
                                            .onChanged({value in
                                                pickerPosition = value.translation
                                                self.chosenColor = self.currentColor.uiColor().toHexString()
                                            }
                                            )
                                )
                        }
                    )
            })
        }
    }
}


struct colorPickerHexTest: View{
    @Binding var color: String
    var body: some View{
        colorPickerHexWithSaturation(chosenColor: self.$color)
    }
}

struct colorPicker_Previews: PreviewProvider {
    static var previews: some View {
        colorPickerHexTest(color: Binding.constant( "ecc9af"))
    }
}
