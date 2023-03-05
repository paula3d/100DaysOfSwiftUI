//
//  AddBookView.swift
//  Bookworm
//
//  Created by Paulina Dąbrowska on 27/01/2023.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @Environment(\.dismiss) var dismiss
    
    @State private var invalidData = true
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                        .onSubmit {
                            if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                invalidData = true
                            } else {
                                invalidData = false
                            }
                        }
                    TextField("Author's name", text: $author)
                        .onSubmit {
                            if author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                invalidData = true
                            } else {
                                invalidData = false
                            }
                        }
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        // add the book
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        newBook.dateAdded = Date.now

                        try? moc.save()
                        
                        dismiss()
                    }
                    .disabled(invalidData)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
