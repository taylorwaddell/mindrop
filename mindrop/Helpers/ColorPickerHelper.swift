//
//  ColorPickerHelper.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import Cocoa

/// Helper for opening the macOS system color picker panel.
class ColorPickerHelper: NSObject {
    static let shared = ColorPickerHelper()

    private var colorSelectedHandler: ((NSColor) -> Void)?

    func openColorPanel(onColorSelected: @escaping (NSColor) -> Void) {
        colorSelectedHandler = onColorSelected

        let colorPanel = NSColorPanel.shared
        colorPanel.setTarget(self)
        colorPanel.setAction(#selector(colorPanelChanged(_:)))

        colorPanel.styleMask.remove(.resizable)
        colorPanel.makeKeyAndOrderFront(nil)
    }

    @objc private func colorPanelChanged(_ sender: NSColorPanel) {
        let color = sender.color
        colorSelectedHandler?(color)
    }
}
