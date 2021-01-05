//
//  makeEquitableView.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 18.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation
import SwiftUI

extension View where Self: Equatable {
    public func equatable() -> EquatableView<Self> {
return EquatableView(content: self)
}
}
