//
//  pPage.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 25.03.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import SwiftUI
import UIKit
import StoreKit

import Foundation

enum selectedItemToPurchase {
    case year, month
}

struct pPage: View {
    @State var activeButton: selectedItemToPurchase = .month
    @State var yearActive: Bool = true
    @State var monthActive: Bool = false
    
    @ObservedObject var manager:manager = .shared
    let productIDs = [
     "com.davagaz.historyPro.Month",
     "com.davagaz.historyPro.Year"
    ]
    
    
    var body: some View {
        ZStack{
            Color(hex: "59361c")
                            .edgesIgnoringSafeArea(.all)
            LinearGradient(
                gradient: .init(colors: [.clear,.black]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
              )
            
        VStack{
//            Text("Прокачай свои сториз с hiStory PRO")
//                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//                .foregroundColor(.white)
//                .font(.custom("Arial", size: 40))
//                .background(Color.black)
//            purchaseTitle()
            splitedTextViewUI()
                
                .frame(width: nil, height: 150)
                
//                .padding(.top,53)
            VStack(alignment: .leading , spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Group{
                featureRow(NSLocalizedString("Over 100 unique photo frames", comment: "Over 100 unique photo frames")) //over 100 unique photo frames
                featureRow(NSLocalizedString("Over 50 fonts - all with Cyrillic support!", comment: "Over 30 fonts - all with Cyrillic support!")) //over 30 fonts - all with Cyrillic support!
                featureRow(NSLocalizedString("Effects and styles for text with the ability\nto add shadows, neon, frames and strokes", comment: "Effects")) //effects and styles for text with the ability to add shadows, neon, frames and strokes
                featureRow(NSLocalizedString("Ultra HD 4K quality", comment: "Ultra HD!")) //Ultra HD 4K quality
                featureRow(NSLocalizedString("Exclusive templates designs", comment: "Exclusive templates designs"))//smart copying to create color style and mood
                
                }
                .padding([.top,.bottom], 3)
            })
            .padding(.bottom)
          
            
            
            VStack{
                let yearArr = manager.myProducts.filter {
                    $0.productIdentifier == "com.davagaz.historyPro.Year"
                }
                let year = yearArr.count > 0 ? yearArr[0] : SKProduct()
                let yearPrice = yearArr.count > 0 ? year.localizedPrice : "0"
                let monthArr = manager.myProducts.filter {
                    $0.productIdentifier == "com.davagaz.historyPro.Month"
                }
                let month = monthArr.count > 0 ? monthArr[0] : SKProduct()
                let monthPrice = monthArr.count > 0 ? month.localizedPrice : "0"
                
                let sale = (( 1 - (year.price as Decimal) / ( (month.price as Decimal) * 12)) * 100)
                HStack {
                    pButton(isSelected: $yearActive, title: year.localizedTitle , price: yearPrice, info: "*\(NSLocalizedString("only", comment: "word before calculated price of year subscription divided on 12 month")) \( ((year.price as Decimal)/12).rounded(2, NSDecimalNumber.RoundingMode.plain) ) / \(NSLocalizedString("month", comment: "month"))", sale:
                                    "\(sale.rounded(0, NSDecimalNumber.RoundingMode.down ))"
                    ){
                yearActive = true
                monthActive = false
            }
                    pButton(isSelected: $monthActive, title: month.localizedTitle , price: monthPrice , info: ""){
                yearActive = false
                monthActive = true
            }
        }
            
            Button(action: {
                if yearActive {
                    manager.purchaseProduct(product: year)
                } else if monthActive{
                    manager.purchaseProduct(product: month)

                }
                
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 60)
                    .foregroundColor(.mainBeige)
                    .overlay(Text(NSLocalizedString("Subscript", comment: "Subscription button"))
                                .foregroundColor(.white)
                    )
            })

                Button(action: {
                    manager.restoreProducts()
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 60)
                        .foregroundColor(.clear)
                        .overlay(Text(NSLocalizedString("Restore purchase", comment: "Restore purchase button"))
                                    .foregroundColor(.white)
                        )
                })
         
            }
            
            .fixedSize()
        }
      
        .fixedSize()
        
        .onAppear(perform: {
                          manager.getProducts(productIDs: productIDs)
            SKPaymentQueue.default().add(manager)
            
                      })
    }
    }
}

struct featureRow: View {
    init( _ description: String) {
        self.description = description
    }
    var description: String
    var body: some View {
        HStack{
            Image(systemName: "checkmark")
                .foregroundColor(.orange)
            Text(description)
                .foregroundColor(.white)
        }
    }
}



struct splitedTextViewUI: UIViewRepresentable {
    func updateUIView(_ uiView: splitedTextView, context: Context) {
        
    }
    
    typealias UIViewType = splitedTextView
    
    func makeUIView(context: UIViewRepresentableContext<splitedTextViewUI>) -> splitedTextView {
        
//        let container = NSTextContainer()
     
        
        
        
        let textv = splitedTextView( )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        textv.typingAttributes = [
//            NSAttributedString.Key.backgroundColor: UIColor.black,
//            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        textv.font = UIFont(name: "Arial", size: CGFloat(39))
        textv.text = NSLocalizedString("Upgrade\nyour stories\nwith hiStory PRO", comment: "Upgrade") //upgrade your stories with hiStorys PRO
        textv.textColor = .white
        textv.backgroundColor = .clear
        textv.isScrollEnabled = false
        textv.isEditable = false
        textv.isSelectable = false
//        textv.contentInset = UIEdgeInsets(top: 0,left: 1,bottom: 0,right: 0);
     
        
        
        
        return textv
    }
    
    
    
}

class splitedTextView: UITextView, NSLayoutManagerDelegate {

    override func awakeFromNib() {
        self.layoutManager.delegate = self
    }
    
    override func draw(_ rect: CGRect) {
        self.layoutManager.enumerateLineFragments(forGlyphRange: NSMakeRange(0, self.text.count)) { (rect, usedRect, textContainer, glyphRange, Bool) in
            let rectanglePath = UIBezierPath(rect:
                                                CGRect(x: usedRect.origin.x, y: usedRect.origin.y+11,
                                                       width: usedRect.size.width, height: usedRect.size.height-5))
            UIColor.black.setFill()
            rectanglePath.fill()
        }
    }
    

    func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 25
    }
}

struct pPage_Previews: PreviewProvider {
    var grad:LinearGradient = LinearGradient(
        gradient: .init(colors: [.clear,.black]),
        startPoint: .init(x: 0.5, y: 0),
        endPoint: .init(x: 0.5, y: 0.6)
      )
    
    static var previews: some View {
        ZStack{
            Image("hiStory PRO")
                .resizable()
                .scaledToFill()
            Group{
                Color(hex: "59361c")
            LinearGradient(
                gradient: .init(colors: [.clear,.black]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
              )
            }
           
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            pPage()
//                .opacity(0.3)
        }
     
    }
}

extension Decimal {
    mutating func round(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) {
        var localCopy = self
        NSDecimalRound(&self, &localCopy, scale, roundingMode)
    }

    func rounded(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, scale, roundingMode)
        return result
    }
}
