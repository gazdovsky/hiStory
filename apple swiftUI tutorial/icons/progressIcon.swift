//
//  progressIcon.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 04.04.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct progressIcon: View {
    @State var circleProgress: CGFloat = 0
    var body: some View {
        Circle()
            .trim(from: 0.0, to: circleProgress)
            .stroke(Color.blue, lineWidth: 6)
            .onAppear(perform: {
                startLoading()
            })
    }
    
    func startLoading() {
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                withAnimation() {
                    self.circleProgress += 0.03
                    if self.circleProgress >= 1.0 {
                        timer.invalidate()
                    }
                }
            }
        }
}

struct progressGradientIcon: View {
    @State var circleProgress: CGFloat = 1
    @State var rotate: Double = 0
    var body: some View {
        Circle()
            .trim(from: 0.0, to: circleProgress)
            .stroke( AngularGradient(gradient: Gradient(colors: [Color.blue.opacity(0), Color.blue]), center: .center )  , lineWidth: 6)
            .rotationEffect(Angle(degrees: rotate) )
            .onAppear(perform: {
//                startLoading()
//                withAnimation{
                    startRotate()
//                }
            })
    }
    
    func startRotate() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                withAnimation() {
                    self.rotate += 50
//                    if self.rotate >= 1.0 {
//                        timer.invalidate()
//                    }
                }
            }
        }
    
    func startLoading() {
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                withAnimation() {
                    self.circleProgress += 0.03
                    if self.circleProgress >= 1.0 {
                        timer.invalidate()
                    }
                }
            }
        }
}

struct progressIcon_Previews: PreviewProvider {
    static var previews: some View {
        progressGradientIcon()
    }
}
