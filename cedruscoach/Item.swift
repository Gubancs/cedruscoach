//
//  Item.swift
//  cedruscoach
//
//  Created by Gabor Kokeny on 07/12/2024.
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
