//
//  TextFieldInputView.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import SwiftUI

/// A custom slider with an input field for direct RGB value adjustment.
struct SliderWithInput: View {
    let label: String
    @Binding var value: Int
    let maxValue: Int
    let gradient: Gradient

    var body: some View {
        HStack {
            // Label for the slider
//            Text(label)
//                .frame(width: 50, alignment: .leading)

            // Custom slider
            CustomSlider(
                value: Binding(
                    get: { Double(value) },
                    set: { value = Int(round($0)) }
                ),
                maxValue: Double(maxValue),
                gradient: gradient
            ) {}

            // Text input for the slider value
            TextField(
                "0",
                value: $value,
                format: .number
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 50)
            .onChange(of: value) { newValue, oldValue in
                value = min(max(newValue, 0), maxValue) // Clamp the new value
            }
        }
    }
}
