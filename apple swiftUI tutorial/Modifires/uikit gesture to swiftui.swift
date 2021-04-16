//
//  uikit gesture to swiftui.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 16.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

var reporter = PassthroughSubject<String, Never>()

struct newView: UIViewRepresentable {
  @State var direction = ""

  typealias UIViewType = UIView
    var v = UIHostingController(rootView:  testimg()).view //UIView()

    let uiv = UIHostingController(rootView:  testimg())
    
  func updateUIView(_ uiView: UIView, context: Context) {
//    v.backgroundColor = UIColor.yellow
//    v.addSubview(uiv.view)
  }
  
    
    
  func makeUIView(context: Context) -> UIView {
    let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(sender:)))
    let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(sender:)))
    let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch(sender:)))
    let leftSwipe = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleSwipe(sender:)))
    leftSwipe.direction = .left
    let rightSwipe = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleSwipe(sender:)))
    rightSwipe.direction = .right
    
    
    v?.addGestureRecognizer(panGesture)
    v?.addGestureRecognizer(pinchGesture)
    v?.addGestureRecognizer(tapGesture)
    v?.addGestureRecognizer(leftSwipe)
    v?.addGestureRecognizer(rightSwipe)
    v?.addSubview(uiv.view)
    return v ?? UIView()
    }
    
  func makeCoordinator() -> newView.Coordinator {
    Coordinator(v ?? UIView())
  }
  
  final class Coordinator: NSObject {
    private let view: UIView
  
    init(_ view: UIView) {
        self.view = view
        super.init()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    @objc func handlePinch(sender: UIPinchGestureRecognizer) {
//      let scale = sender.scale
//      reporter.send("scale \(scale)")
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
      let location = sender.location(in: view)
      reporter.send("tap \(location)")
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {

      let translation = sender.translation(in: view)
      let location = sender.location(in: view)
      
      sender.setTranslation(.zero, in: view)
      reporter.send("pan \(location) \(translation)")
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
      if sender.direction == .left {
        let location = sender.location(in: view)
        reporter.send("left \(location)")
      } else {
        if sender.direction == .right {
          let location = sender.location(in: view)
          reporter.send("right \(location)")
        }
      }
    }
  }
}

struct ContentViewtest: View {
  @State var direction = ""
  
    var body: some View {
     return ZStack {
      newView()
      Rectangle()
        .stroke(lineWidth: 5)
        .frame(width: 256, height: 128, alignment: .center)
      Text(direction)
        .onReceive(reporter) { ( data ) in
          self.direction = data
        }
    }
}
}

struct testimg: View {
    var body: some View{
        Image("hiStoriesMainScreen")
            .resisable()
            .scaleEffect(0.2)
//            .scaledToFit()
    }
}

struct ContentViewtest_Preview: PreviewProvider {
    static var previews: some View{
        ContentViewtest()
            
    }
    
}
