//
//  Book.swift
//  BookManager
//
//  Created by H A on 21/09/2026.
//

import Foundation

public struct Book: Identifiable, Comparable {
    
    // To conform to Identifiable protocol
    public var id = UUID()
    
    var title: String
    var author: String
    var gender: String
    var displayed: Bool
    
    // Init method
    init(title: String, author: String, gender: String, displayed: Bool) {
        self.title = title
        self.author = author
        self.gender = gender
        self.displayed = displayed
    }
    
    // To conform to Comparable protocol
    public static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title &&
               lhs.author == rhs.author
    }
    
    public static func < (lhs: Book, rhs: Book) -> Bool {
        return lhs.title < rhs.title
    }
}
