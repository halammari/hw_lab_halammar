//
//  Emoji.swift
//  EmojiHunter
//
//  Created by H A on 07/11/2026.
//

import Foundation

protocol EmojiFoundDelegate: AnyObject {
    func emojiWasFound(result: Bool)
}

enum EmojiSearch {
    case found
    case notFound
    case searching
    case gameOver
}

struct EmojiModel: Identifiable {
    let id = UUID()
    var emoji: String
    var emojiName: String
}

let emojiObjects: [EmojiModel] = [
    EmojiModel(emoji: "💻", emojiName: "laptop"),
    EmojiModel(emoji: "✍️", emojiName: "pen"),
    EmojiModel(emoji: "⌨️", emojiName: "keyboard"),
    EmojiModel(emoji: "🖱️", emojiName: "mouse"),
    EmojiModel(emoji: "☕️", emojiName: "mug")
]
