//
//  ColorPickerViewModel.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import SwiftUI

/// ViewModel for managing the color picker's state and logic.
class ColorPickerViewModel: ObservableObject {
    @Published var red: Int = 0 {
        didSet { updateHexColor() }
    }
    @Published var green: Int = 0 {
        didSet { updateHexColor() }
    }
    @Published var blue: Int = 0 {
        didSet { updateHexColor() }
    }
    @Published var savedColors: [String] = [] {
        didSet { saveColorsToUserDefaults() }
    }
    @Published var hexColor: String = "#000000"
    private let userDefaultsKey = "savedColors"

    init() {
        loadColorsFromUserDefaults()
    }

    /// Converts the RGB values to an NSColor.
    var selectedColor: NSColor {
        NSColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0
        )
    }

    /// Updates the hex color value based on the current RGB values.
    func updateHexColor() {
        hexColor = selectedColor.hexString ?? "#000000"
    }

    /// Updates the RGB values from a hex string.
    func updateColorFromHex() {
        guard let color = NSColor(hex: hexColor) else { return }
        red = Int(color.redComponent * 255)
        green = Int(color.greenComponent * 255)
        blue = Int(color.blueComponent * 255)
    }

    /// Copies the current hex color value to the clipboard.
    func copyHexToClipboard() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(hexColor, forType: .string)
    }

    /// Copies the RGB value in `rgb(255, 0, 0)` format to the clipboard.
    func copyRGBToClipboard() {
        let rgbString = "rgb(\(red), \(green), \(blue))"
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(rgbString, forType: .string)
    }

    /// Copies a hex value to the clipboard.
    func copyToClipboard(hex: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(hex, forType: .string)
    }

    /// Copies an RGB value to the clipboard from a hex color.
    func copyToClipboardRGB(fromHex hex: String) {
        guard let color = NSColor(hex: hex) else { return }
        let red = Int(color.redComponent * 255)
        let green = Int(color.greenComponent * 255)
        let blue = Int(color.blueComponent * 255)
        let rgbString = "rgb(\(red), \(green), \(blue))"

        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(rgbString, forType: .string)
    }

    /// Opens the macOS eye dropper tool to select a color from the screen.
    func openEyeDropper() {
        NSColorSampler().show { selectedColor in
            guard let selectedColor = selectedColor,
                  let rgbColor = selectedColor.usingColorSpace(.deviceRGB) else {
                return
            }
            self.red = Int(rgbColor.redComponent * 255)
            self.green = Int(rgbColor.greenComponent * 255)
            self.blue = Int(rgbColor.blueComponent * 255)
            self.updateHexColor()
        }
    }

    /// Saves the current hex color to the saved colors array.
    func saveCurrentColor() {
        guard !savedColors.contains(hexColor) else { return } // Avoid duplicates
        if savedColors.count >= 20 {
            savedColors.removeFirst() // Keep only the latest 10 colors
        }
        savedColors.append(hexColor)
    }

    /// Loads a saved color from the grid.
    func loadColor(from hex: String) {
        guard let color = NSColor(hex: hex) else { return }
        red = Int(color.redComponent * 255)
        green = Int(color.greenComponent * 255)
        blue = Int(color.blueComponent * 255)
        updateHexColor()
    }

    /// Saves the saved colors array to UserDefaults.
    private func saveColorsToUserDefaults() {
        UserDefaults.standard.set(savedColors, forKey: userDefaultsKey)
    }

    /// Loads the saved colors array from UserDefaults.
    private func loadColorsFromUserDefaults() {
        if let loadedColors = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            savedColors = loadedColors
        }
    }
    
    func deleteColor(hex: String) {
        if let index = savedColors.firstIndex(of: hex) {
            savedColors.remove(at: index)
        }
    }
}
