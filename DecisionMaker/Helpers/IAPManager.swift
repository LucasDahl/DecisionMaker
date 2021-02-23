//
//  IAPManager.swift
//  DecisionMaker
//
//  Created by Lucas Dahl on 2/23/21.
//

import StoreKit
import Foundation

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //=================
    // MARK: Properties
    //=================
    
    var products = [SKProduct]()
    var productBeingPurcahsed: SKProduct?
    
    // Sharred singleton
    static let shared = IAPManager()
    
    // These are the products, this way they can be expanded
    enum Product: String, CaseIterable {
        case adsRemoved
    }
    
    
    //==============
    // MARK: Methods
    //==============
    
    // Fetch objects from Apple
    public func fetchProducts() {
        
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue })))
        request.delegate = self
        request.start()
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
//        products = response.products
//
//        // Check if there is a first product
//        guard let product = products.first else {
//            return
//        }
//
//        purchase(product: product)
        
        self.products = response.products
        
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        guard request is SKProductsRequest else {
            return
        }
        
        // TODO: Add popup action
        print("Failed fetch request")
        
    }
    
    // Promot a product payment transaction
    public func purchase(product: Product) {
        
        // Checks if the user can make payments
        guard SKPaymentQueue.canMakePayments() else {
            return
        }

        // Presents the payment
        guard let storeKitProduct = products.first(where: { $0.productIdentifier == product.rawValue }) else {
            return
        }
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        transactions.forEach { (transaction) in
            
            switch transaction.transactionState {
                case .purchasing:
                    break
                case .purchased:
                    handlePurchase(transaction.payment.productIdentifier)
                    break
                case .restored:
                    handlePurchase(transaction.payment.productIdentifier)
                    break
                case .failed:
                    print("failed")
                    break
                case .deferred:
                    break
            @unknown default:
                break
            }
        }//19:32 and 5:32
        
    }
    
    // Removes ads once purchased
    private func handlePurchase(_ id: String) {
        
        UserDefaults.standard.set(true, forKey: "adsRemoved")
        
    }
    
}