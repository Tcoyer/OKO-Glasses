//
//  Item.swift
//  OKO-glasses
//
//  Created by Reynard Octavius Tan on 21/03/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
