//
//  PaletteManager.swift
//  Emoji Art
//
//  Created by Steven Shih on 12/2/24.
//  Based on CS193p from Stanford University
//

import SwiftUI

struct PaletteManager: View {
    let stores: [PaletteStore]
    
    @State private var selectedStore: PaletteStore?
    var body: some View {
        NavigationSplitView {
            List(stores, selection: $selectedStore) { store in
                // only access @ObservedObject @Published
                Text(store.name)
                    .tag(store)
            }
        } content: {
            if let selectedStore {
                EditablePaletteList(store: selectedStore)
            }
        } detail: {
            Text("Choose a palette")
        }
    }
}

//#Preview {
//    PaletteManager()
//}
