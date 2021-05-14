//
//  lazyStack.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 07.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI

struct lazyStack<Content: View>: View {
    let elements: Int
    let elementsInRow: Int
    let spacing: CGFloat
//    let screenW = UIScreen.main.bounds.width
    var rows: Int {
        return Int(ceil(Double(elements / elementsInRow)))
    }
    let content: (Int) -> Content
    var body: some View {
        VStack (spacing: spacing, content: {
            ForEach(0..<rows) { row in
                HStack(spacing: spacing, content: {
                    ForEach(0..<elementsInRow) { elementNumberInRow -> Content in
                            content((row + elementNumberInRow) + (elementsInRow - 1) * row)
                    }
                })
            }
        })
    }
    init(elements: Int, elementsInRow: Int, spacing: CGFloat = 12, @ViewBuilder content: @escaping (Int) -> Content) {
        self.elements = elements
        self.elementsInRow = elementsInRow
        self.spacing = spacing
        
        self.content = content
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
        
    }
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct lazyStackText: View{
    var chosableColors: [String] = [
        "FDAC53",
        "9BB7D4",
        "B55A30",
        "F5DF4D",
        "0072B5",
        "A0DAA9",
        "E9897E",
        "00A170",
        "926AA6",
        "D2386C",
        "9A8B4F",
        "E0B589",
        "EFE1CE",
        "939597",
        "363945"
    ]
    
    var body: some View {
        lazyStack(elements: chosableColors.count, elementsInRow: 2) {e in
            colorCircleChoser3(color: chosableColors[e]){
                
            }
        }
    }
}

struct lazyStack_Previews: PreviewProvider {
    static var previews: some View {
        lazyStackText()
    }
}
