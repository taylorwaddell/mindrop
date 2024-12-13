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
        VStack(spacing: 16) {
            SliderWithInput(
                label: "Red",
                value: $viewModel.red,
                maxValue: 255,
                gradient: Gradient(colors: [
                    Color.black,
                    Color.red.opacity(0.3),
                    Color.red
                ])
            )

            SliderWithInput(
                label: "Green",
                value: $viewModel.green,
                maxValue: 255,
                gradient: Gradient(colors: [
                    Color.black,
                    Color.green.opacity(0.3),
                    Color.green
                ])
            )

            SliderWithInput(
                label: "Blue",
                value: $viewModel.blue,
                maxValue: 255,
                gradient: Gradient(colors: [
                    Color.black,
                    Color.blue.opacity(0.3),
                    Color.blue
                ])
            )
        }
    }
}
