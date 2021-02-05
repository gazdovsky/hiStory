//
//  coordinator.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 12.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI



class selectorContainerStore: systemFilesWorker, ObservableObject {
    static var shared = selectorContainerStore()
    @Published var templateName: String = "beige aesthetic 1.json"
    @Published var templateImageName: String = "beige aesthetic 1"
    
    @Published var savedStorys:[String] = [""]
    @Published var navigateToRedactor: Bool = false
    @Published var templateOpacity: Bool = false
    @Published var templateFrame: CGRect = CGRect()
    @Published var tx: CGFloat = 1
    @Published var ty: CGFloat = 1
    @Published var tw: CGFloat = 1
    @Published var th: CGFloat = 1
    @Published var screenOffset: Double = 0
    @Published var isOpenedDraft: Bool = false
    @Published var increaser: CGFloat = 1
    @Published var update: Bool = true
}
