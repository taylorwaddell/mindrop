//
//  ColorDisplayView.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import SwiftUI

/// Displays the selected color and an editable hex value.
struct ColorDisplayView: View {
    @EnvironmentObject var viewModel: ColorPickerViewModel

    var body: some View {
        VStack(spacing: 8) {
            // Color preview
            Color(viewModel.selectedColor)
                .frame(width: 150, height: 150)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))

            // Editable hex input
            HStack {
                Text("Hex:")
                    .font(.headline)
                TextField(
                    "Enter Hex",
                    text: $viewModel.hexColor,
                    onCommit: {
                        viewModel.updateColorFromHex()
                    }
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
            }
        }
    }
}
