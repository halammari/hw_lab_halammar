//
//  AppView.swift
//  BookManager
//
//  Created by H A on 21/09/2026.
//

import SwiftUI

struct AppView: View {
    
    var library = Library()
    
    var body: some View {
        TabView {
            
            LibraryView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Library")
                }
            
            NewBookView()
                .tabItem {
                    Image(systemName: "rectangle.stack.badge.plus")
                    Text("New Book")
                }
            
            ChartsView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Charts")
                }
        }
        .environmentObject(library)
    }
}
