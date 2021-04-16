//
//  conditionalDissapear.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 22.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct conditionalDissapear: View {
    @State var testum: switcher = .nothing
    func stateCheck(_ state: switcher) -> Bool {
       return testum == state || testum == .nothing
    }
    var body: some View {
        VStack{
            HStack{
                Button("First") { testum.toggle(.first)}
                Text("\(testum == .first ? "on" : "off")")
            }
            .frame(width: nil, height: stateCheck(.first) ? nil : 0)
            .opacity(stateCheck(.first) ? 1 : 0)
            
            
            HStack{
                Button("second") { testum.toggle(.second)}
                Text("\(testum == .second  ? "on" : "off")")
            }
            .frame(width: nil, height: stateCheck(.second) ? nil : 0)
            .opacity(stateCheck(.second) ? 1 : 0)
            
            
            HStack{
                Button("third") { testum.toggle(.third)}
                Text("\(testum == .third  ? "on" : "off")")
            }
            .frame(width: nil, height: stateCheck(.third) ? nil : 0)
            .opacity(stateCheck(.third) ? 1 : 0)
            
            
            
         
        }
    }
}

enum switcher: String {
    case first = "first"
    case second = "second"
    case third = "third"
    case nothing = "nothing"
    mutating func toggle(_ state: switcher){
        self = self == state ? .nothing : state
    }
}

extension View{
    func makeDissapearWithCondition<T: RawRepresentable>(main: T, condition: T) -> some View{
        let i:String = main.self.rawValue as! String
        let b:String = condition.self.rawValue as! String
        return self.modifier(dissapearWithCondition(isDissapear: b == i || b != "nothing" ? false : true))
    }
    
    func makeDissapearWithCondition2<T: RawRepresentable>(main: T, condition: T) -> some View{
        let i:String = main.self.rawValue as! String
        let b:String = condition.self.rawValue as! String
        return self.modifier(dissapearWithCondition2(isDissapear: b == i || b != "nothing" ? false : true))
    }
    
}


struct dissapearWithCondition2: ViewModifier{
    @State var isDissapear: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: nil, height: isDissapear ? 0 : nil)
            .opacity(isDissapear ? 0 : 1)
    }
}

struct dissapearWithCondition: ViewModifier{
    @State var isDissapear: Bool
    func body(content: Content) -> some View {
        content
            .frame(width: nil, height: isDissapear ? 0 : nil)
            .opacity(isDissapear ? 0 : 1)
    }
}




struct dissapear: ViewModifier{
    
    @Binding var isDissapear: Bool
    
    func body(content: Content) -> some View {
        
        content
            .frame(width: nil, height: isDissapear ? 0 : nil)
            .opacity(isDissapear ? 0 : 1)
        
    }
}

extension View{
    func makeDissapear(isDissapear : Binding<Bool>) -> some View{
        self.modifier(dissapear(isDissapear: isDissapear))
    }
}

struct conditionalDissapear_Previews: PreviewProvider {
    static var previews: some View {
        conditionalDissapear()
    }
}
