//
//  BookDetailView.swift
//  BookManager
//
//  Created by H A on 21/09/2026.
//

import SwiftUI

struct BookDetailView: View {
    
    var book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Author: \(book.author)")
                .font(.title3)
                .fontWeight(.bold)
                .padding(5)
            
            Text("Author Gender: \(book.gender)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .padding(20)
            
            Spacer()
        }
        .navigationTitle("Book Details")
    }
}
