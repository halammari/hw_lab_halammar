//
//  Coordinator.swift
//  EmojiHunter
//
//  Created by H A on 07/11/2026.
//

import Foundation
import SwiftUI

class Coordinator: NSObject, EmojiFoundDelegate {
    @Binding var emojiFound: EmojiSearch

    init(emojiFound: Binding<EmojiSearch>) {
        _emojiFound = emojiFound
    }

    func emojiWasFound(result: Bool) {
        print("emojiWasFound \(result)")
        emojiFound = .found
    }
}
