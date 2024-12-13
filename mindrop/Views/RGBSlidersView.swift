//
//  RGBSlidersView.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import SwiftUI

/// Displays RGB sliders and their corresponding text inputs for adjusting the color.
struct RGBSlidersView: View {
    @EnvironmentObject var viewModel: ColorPickerViewModel

    var body: some View {
        // Extract the current selected color in device RGB space
        let currentColor = viewModel.selectedColor.usingColorSpace(.deviceRGB)!
        let rVal = Double(currentColor.redComponent)
        let gVal = Double(currentColor.greenComponent)
        let bVal = Double(currentColor.blueComponent)

        VStack(spacing: 16) {
            // Red Slider
            SliderWithInput(
                label: "Red",
                value: $viewModel.red,
                maxValue: 255,
                gradient: Gradient(colors: [
                    Color(red: 0, green: gVal, blue: bVal),
                    Color(red: 1, green: gVal, blue: bVal)
                ])
            )

            // Green Slider
            SliderWithInput(
                label: "Green",
                value: $viewModel.green,
                maxValue: 255,
                gradient: Gradient(colors: [
                    Color(red: rVal, green: 0, blue: bVal),
                    Color(red: rVal, green: 1, blue: bVal)
                ])
            )

            // Blue Slider
            SliderWithInput(
                label: "Blue",
                value: $viewModel.blue,
                maxValue: 255,
                gradient: Gradient(colors: [
                    Color(red: rVal, green: gVal, blue: 0),
                    Color(red: rVal, green: gVal, blue: 1)
                ])
            )
        }
    }
}
