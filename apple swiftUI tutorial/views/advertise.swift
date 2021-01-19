//
//  advertise.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 24.11.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

struct ads: View {
    
    var body: some View{
        HStack{
            Rectangle()
                .frame(width: nil, height: 50)
                .foregroundColor(Color(hex: "ecc9af"))
//                .cornerRadius(20)
        }
    }
}

struct ads_Previews: PreviewProvider {
    static var previews: some View{
        ads()
    }
}
