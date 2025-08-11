//
//  ContentView.swift
//  QuoteWriter
//
//  Created by Labhesh Dudi on 11/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: [SortDescriptor(\Note.createdAt, order: .reverse)]) private var notes: [Note]
    
    @State private var newTitle = ""
    @State private var newContent = ""
    @State private var editingNote: Note? // Tracks the note being edited

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .onTapGesture {
                            // Tap to edit
                            editingNote = note
                            newTitle = note.title
                            newContent = note.content
                        }
                    }
                    .onDelete(perform: deleteNotes) // Swipe-to-delete
                }

                Divider()
                
                VStack {
                    TextField("Title", text: $newTitle)
                        .textFieldStyle(.roundedBorder)
                    TextField("Content", text: $newContent)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(editingNote == nil ? "Add Note" : "Update Note") {
                        if let note = editingNote {
                            // Update existing note
                            note.title = newTitle
                            note.content = newContent
                            try? context.save()
                            editingNote = nil
                        } else {
                            // Add new note
                            let note = Note(title: newTitle, content: newContent)
                            context.insert(note)
                            try? context.save()
                        }
                        newTitle = ""
                        newContent = ""
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationTitle("Notes")
        }
    }
    
    // MARK: - Delete Logic
    private func deleteNotes(at offsets: IndexSet) {
        for index in offsets {
            let note = notes[index]
            context.delete(note)
        }
        try? context.save()
    }
}

#Preview {
    let previewContainer = try! ModelContainer(for: Note.self, configurations: .init(isStoredInMemoryOnly: true))
    let context = previewContainer.mainContext
    context.insert(Note(title: "First Note", content: "This is some sample text"))
    context.insert(Note(title: "Second Note", content: "Another note here"))

    return ContentView()
        .modelContainer(previewContainer)
}
