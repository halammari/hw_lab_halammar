//
//  CardViewModelTests.swift
//  RailsCards
//
//  Created by H A on 13/09/2026.
//

import Testing
@testable import RailsCards

@MainActor
struct CardViewModelTests {
    
    @Test func initialCardIsFromDeck() {
        let vm = CardViewModel()
        
        #expect(vm.deck.cards.contains { $0.command == vm.flashcard.command })
    }
    
    @Test func drawNewCardChangesCardEventually() {
        let vm = CardViewModel()
        let original = vm.flashcard.command
        
        // Draw up to 50 times looking for a change
        var changed = false
        
        for _ in 0..<50 {
            vm.drawNewCard()
            
            if vm.flashcard.command != original {
                changed = true
                break
            }
        }
        
        #expect(changed)
    }
}
