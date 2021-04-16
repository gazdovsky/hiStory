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
                .frame( height: 50)
                .cornerRadius(20)
                .padding([.leading,.trailing])
                .foregroundColor(Color.lightBeige)
                
        }
    }
}

struct ads_Previews: PreviewProvider {
    static var previews: some View{
        ads()
    }
}
