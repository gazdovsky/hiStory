//
//  getCreationDateByURL.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 16.12.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import Foundation

extension URL {
    var customModificationDate: Date? {
        
        let attributes = try? FileManager.default.attributesOfItem(atPath: self.path)
//        let creationDate = attributes[.creationDate] as! Date
        
        
        return attributes?[.modificationDate] as? Date
    }
}
