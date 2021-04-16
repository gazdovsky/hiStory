//
//  customGradient.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 25.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI


struct icontest: View {
    let gragientColors = Gradient(colors: [.purple,.yellow])
    var body: some View {
        VStack{
            Image(systemName: "doc.on.doc")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0)
                .overlay(
                    LinearGradient(gradient: gragientColors, startPoint: .bottomLeading, endPoint: .topTrailing)
                        .mask(
                            Image(systemName: "doc.on.doc")
                                .resizable()
                        )
                )
                .frame(width: 50, height: 50)
            
            LinearGradient(gradient: gragientColors, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                .mask(
                    Image(systemName: "doc.on.doc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                )
                .frame(width: 50, height: 50)
            gradientIcon(iconName: "doc.on.doc.fill", size: 25)
                
            Image("tOp")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 200, alignment: .center)
                .overlay(Color.red
                            .mask(Image("tOp")
                                    .resizable()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 200, alignment: .center)
                            )
                )
        }
       
    }
}



struct gradientIcon: View{
    var iconName: String = "doc.on.doc"
    var gradient: Gradient = Gradient(colors: [.purple,.yellow])
    
    @State var animateStage: Bool = true
    var size:CGFloat = 40
    var action: (()->()) = {}
    var body: some View {
        Button(action: {
            action()
        }, label: {
            LinearGradient(gradient: gradient,
                           startPoint: animateStage ? .bottomLeading : .bottomTrailing,
                           endPoint: animateStage ? .topTrailing : .topLeading)
                .mask(
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                )
                .animation(Animation.linear(duration: 4).repeatForever(autoreverses: true).speed(2), value: animateStage)
                .onAppear(perform: {
                    withAnimation {
                        animateStage.toggle()
                    }
                })
                .frame(width: size, height: size)
        })
        
    }
}
struct customGradient: View {
    @State var p1: CGFloat = 150
    @State var p2: CGFloat = 300
    @State var p3: CGFloat = 50
    @State var p4: CGFloat = 300
    var body: some View {
        
            ZStack{
//                Path{
//                    path in
//                            path.move(to: CGPoint(x: 0, y: 100))
//                            path.addQuadCurve(to: CGPoint(x: 50, y: 0), control: CGPoint(x: 0, y: 0))
//                            path.addQuadCurve(to: CGPoint(x: 200, y: 100), control: CGPoint(x: 200, y: 0))
//                            path.addQuadCurve(to: CGPoint(x: 100, y: 200), control: CGPoint(x: 200, y: 200))
//                            path.addQuadCurve(to: CGPoint(x: 0, y: 100), control: CGPoint(x: 0, y: 200))
//                }
//                .fill(Color.purple)
                
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                Path{
//                    path in
//                            path.move(to: CGPoint(x: 0, y: 100))
//                            path.addQuadCurve(to: CGPoint(x: 110, y: 69), control: CGPoint(x: 116, y: 134))
//                            path.addQuadCurve(to: CGPoint(x: 200, y: 100), control: CGPoint(x: 200, y: 0))
//                            path.addQuadCurve(to: CGPoint(x: 100, y: 200), control: CGPoint(x: 200, y: 200))
//                            path.addQuadCurve(to: CGPoint(x: 0, y: 100), control: CGPoint(x: 0, y: 200))
//                }
                
//
//                .fill(Color.blue)
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                VStack(spacing: 0,content:{
                    Color.lightBeige
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Color.textAccent
                        
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                })
                blurCircle(style: .light)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                Circle()
//                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .overlay(
//                    Blur(style: .systemThinMaterial )
//                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                )
                
            }
//            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
          
       
//        .offset(CGSize(width: 80, height: -200.0))
            
    }
}

struct blurCircle: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIView {
        let circle = UIView()
        circle.layer.cornerRadius = 50
        circle.layer.masksToBounds = true
        circle.addBlurredBackground(style: style)
//        UIVisualEffectView(effect: UIBlurEffect(style: style))
        return circle
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
//        uiView.addBlurredBackground(style: .light)

    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

class CircleView: UIView {

    override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = bounds.size.width / 2
            layer.masksToBounds = true
        }
}

struct customGradient_Previews: PreviewProvider {
    static var previews: some View {
        icontest()
    }
}
