//
//  Flashcards.swift
//  RailsCards
//
//  Created by H A on 10/09/2026.
//

import Foundation

struct Flashcard {
    let command: String
    let definition: String
    
    init(command: String, definition: String) {
        self.command = command
        self.definition = definition
    }
}
