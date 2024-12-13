//
//  EyeDropperButton.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import SwiftUI

/// A button that triggers the macOS eye dropper tool.
struct EyeDropperButton: View {
    @EnvironmentObject var viewModel: ColorPickerViewModel

    var body: some View {
        Button(action: openEyeDropper) {
            Image(systemName: "eyedropper")
        }
        .help("⌘+I")
    }

    func openEyeDropper() {
        NSColorSampler().show { selectedColor in
            guard let selectedColor = selectedColor,
                  let rgbColor = selectedColor.usingColorSpace(.deviceRGB) else {
                return
            }
            viewModel.red = Int(rgbColor.redComponent * 255)
            viewModel.green = Int(rgbColor.greenComponent * 255)
            viewModel.blue = Int(rgbColor.blueComponent * 255)
            viewModel.updateHexColor()
        }
    }
}
