//
//  Item.swift
//  swift-animated-barnacle
//
//  Created by m1_air on 10/18/24.
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
