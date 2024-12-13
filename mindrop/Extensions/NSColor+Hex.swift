//
//  NSColor+Hex.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import Cocoa

/// Extension for NSColor to provide a hex string representation.
extension NSColor {
    var hexString: String? {
        guard let rgbColor = usingColorSpace(.deviceRGB) else { return nil }
        let red = Int(rgbColor.redComponent * 255)
        let green = Int(rgbColor.greenComponent * 255)
        let blue = Int(rgbColor.blueComponent * 255)
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}

extension NSColor {
    convenience init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        guard let int = Int(hex, radix: 16) else { return nil }

        let red, green, blue: CGFloat
        switch hex.count {
        case 6: // RGB (24-bit)
            red = CGFloat((int >> 16) & 0xFF) / 255.0
            green = CGFloat((int >> 8) & 0xFF) / 255.0
            blue = CGFloat(int & 0xFF) / 255.0
        default:
            return nil
        }

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
