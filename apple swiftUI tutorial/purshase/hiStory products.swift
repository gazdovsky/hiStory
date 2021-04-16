//
//  hiStory products.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 20.03.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation

public struct RazeFaceProducts {

  public static let SwiftShopping = "com.davagaz.history"

  private static let productIdentifiers: Set<ProductIdentifier> = [RazeFaceProducts.SwiftShopping]

  public static let store = IAPHelper(productIds: RazeFaceProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
