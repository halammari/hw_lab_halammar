//
//  LibraryView.swift
//  BookManager
//
//  Created by H A on 21/09/2026.
//
import SwiftUI

struct LibraryView: View {
    
    @EnvironmentObject var library: Library
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(library.books) { book in
                    BookRowView(book: book)
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("Library")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        library.books.remove(atOffsets: offsets)
    }
}

struct BookRowView: View {
    
    var book: Book
    
    var body: some View {
        NavigationLink(
            destination: BookDetailView(book: book)
        ) {
            VStack(alignment: .leading) {
                Text(book.title)
                    .fontWeight(.bold)
                    .font(.body)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
