//
//  storeHelper.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 24.03.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    static var shared = StoreManager()
    @Published var myProducts = [SKProduct]()
//    storeManager.getProducts(productIDs: productIDs)
//SKPaymentQueue.default().add(storeManager)
//
    let productIDs = [
     "com.davagaz.historyPro.Month",
     "com.davagaz.historyPro.Year"
    ]
    @Published var transactionState: SKPaymentTransactionState?
    
    var request: SKProductsRequest!
    
//    init() {
//        self.getProducts(productIDs: productIDs)
//    }
    

    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Did receive response")
        
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
        print(response.invalidProductIdentifiers.description )
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid identifiers found: \(invalidIdentifier)")
        }
        
    }
    
    func getProducts(productIDs: [String]) {
        print("Start requesting products ...")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                print("Purchased purchase/restored")
                
                transactionState = .restored
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                queue.finishTransaction(transaction)
                
                transactionState = .failed
            default:
                queue.finishTransaction(transaction)
            }
        }
        
    }
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User can't make payment.")
        }
    }
    
    func restoreProducts() {
        print("Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        // ...
        //        UserDefaults.standard.setValue(true, forKey: queue.transactions[0].payment.productIdentifier )
        print("success restored")
    }
    
  
    
}


extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale //Locale(identifier: "ru_EU")
        return formatter.string(from: price)!
    }
}
