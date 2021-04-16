////
////  SwiftUIest.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 08.02.2021.
////  Copyright © 2021 David Gaz. All rights reserved.
////
//
import SwiftUI

struct SwiftUIest: View {
    @State var circleProgress: CGFloat = 0
    var body: some View {
        Circle()
            .trim(from: 0.0, to: circleProgress)
                .stroke(Color.blue, lineWidth: 15)
                .frame(width: 200, height: 200)
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



struct SwiftUIest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIest()
    }
}
