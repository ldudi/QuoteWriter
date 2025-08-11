//
//  Note.swift
//  QuoteWriter
//
//  Created by Labhesh Dudi on 11/08/25.
//

import SwiftData
import Foundation


@Model
class Note {
    var id: UUID
    var title: String
    var content: String
    var isSynced: Bool
    var createdAt: Date

    init(title: String, content: String, isSynced: Bool = false) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.isSynced = isSynced
        self.createdAt = Date()
    }
}
