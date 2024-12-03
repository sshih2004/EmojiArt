//
//  Emoji_ArtApp.swift
//  Emoji Art
//
//  Created by Steven Shih on 12/1/24.
//  Based on CS193p from Stanford University
//

import SwiftUI

@main
struct Emoji_ArtApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: { EmojiArtDocument() }) { config in
            EmojiArtDocumentView(document: config.document)        }
    }
}
