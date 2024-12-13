//
//  ColorGridView.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import SwiftUI

struct ColorGridView: View {
    @EnvironmentObject var viewModel: ColorPickerViewModel

    private let columns = Array(repeating: GridItem(.flexible()), count: 10)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 5) {
            ForEach(0..<20, id: \.self) { index in
                if index < viewModel.savedColors.count {
                    let hex = viewModel.savedColors[index]
                    Color(hex: hex)
                        .frame(width: 20, height: 20)
                        .cornerRadius(2)
                        .onTapGesture {
                            viewModel.loadColor(from: hex)
                        }
                        .contextMenu {
                            Button("Copy Hex") {
                                viewModel.copyToClipboard(hex: hex)
                            }
                            Button("Copy RGB") {
                                viewModel.copyToClipboardRGB(fromHex: hex)
                            }
                            Button("Delete") {
                                viewModel.deleteColor(hex: hex)
                            }
                        }
                } else {
                    // If there aren't enough colors, show an empty placeholder
                    Color.clear
                        .frame(width: 20, height: 20)
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.gray, lineWidth: 1))
                }
            }
        }
        .padding()
        .frame(height: 80)
    }
}

extension Color {
    init(hex: String) {
        let color = NSColor(hex: hex) ?? NSColor.black
        self.init(color)
    }
}
