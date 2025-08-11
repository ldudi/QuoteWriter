//
//  QuoteWriterApp.swift
//  QuoteWriter
//
//  Created by Labhesh Dudi on 11/08/25.
//

import SwiftUI
import SwiftData


@main
struct QuoteWriterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self) // Attach SwiftData here
    }
}
