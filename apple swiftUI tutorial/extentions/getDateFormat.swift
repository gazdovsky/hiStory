//
//  getDateFormat.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 19.02.2021.
//  Copyright © 2021 David Gaz. All rights reserved.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
