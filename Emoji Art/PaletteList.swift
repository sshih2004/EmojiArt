//
//  PaletteList.swift
//  Emoji Art
//
//  Created by Steven Shih on 12/2/24.
//  Based on CS193p from Stanford University
//

import SwiftUI

struct EditablePaletteList: View {
    @ObservedObject var store: PaletteStore
    @State var showCursorPalette = false
    var body: some View {
            List {
                ForEach(store.palettes) { palette in
                    // takes a view builder
                    NavigationLink(value: palette.id) {
                        VStack(alignment: .leading, content: {
                            Text(palette.name)
                            Text(palette.emojis).lineLimit(1)
                        })
                    }
                }
                .onDelete(perform: { indexSet in
                    withAnimation {
                        store.palettes.remove(atOffsets: indexSet)
                    }
                })
                .onMove(perform: { indices, newOffset in
                    store.palettes.move(fromOffsets: indices, toOffset: newOffset)
                })
            }
            // outside of list
            .navigationDestination(for: Palette.ID.self) { paletteId in
                if let index = store.palettes.firstIndex(where: {$0.id == paletteId}) {
                    PaletteEditor(palette: $store.palettes[index])
                }
            }
            .navigationDestination(isPresented: $showCursorPalette, destination: {
                PaletteEditor(palette: $store.palettes[store.cursorIndex])
            })
            // inside of navigation stack
            .navigationTitle("\(store.name) Palettes")
            .toolbar(content: {
                Button {
                    store.insert(name: "", emojis: "")
                    showCursorPalette = true
                } label: {
                    Image(systemName: "plus")
                }
            })
        }
}

struct PaletteList: View {
    @EnvironmentObject var store: PaletteStore
    var body: some View {
        NavigationStack {
            List(store.palettes) { palette in
                // takes a view builder
                NavigationLink(value: palette) {
                    Text(palette.name)
                }
            }
            // outside of list
            .navigationDestination(for: Palette.self) { palette in
                PaletteView(palette: palette)
            }
            // inside of navigation stack
            .navigationTitle("\(store.name) Palettes")
        }
    }
}

struct PaletteView: View {
    let palette: Palette
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(palette.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    NavigationLink(value: emoji) {
                        Text(emoji)
                    }
                }
            }
            .navigationDestination(for: String.self) { emoji in
                Text(emoji).font(.system(size: 300))
            }
            Spacer()
        }
        .padding()
        .font(.largeTitle)
        .navigationTitle(palette.name)
    }
}

#Preview {
    PaletteList()
}
