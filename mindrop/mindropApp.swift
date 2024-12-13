//
//  mindropApp.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import SwiftUI

@main
struct ColorPickerApp: App {
    @StateObject private var viewModel = ColorPickerViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .commands {
            CommandGroup(replacing: .pasteboard) {
                Button("Copy Hex Color") {
                    viewModel.copyHexToClipboard()
                }
                .keyboardShortcut("C", modifiers: [.command, .shift]) // ⌘+Shift+C for copying HEX
                
                Button("Copy RGB Color") {
                    viewModel.copyRGBToClipboard()
                }
                .keyboardShortcut("R", modifiers: [.command, .shift]) // ⌘+Shift+R for RGB
                
                Button("Eye Dropper") {
                    viewModel.openEyeDropper()
                }
                .keyboardShortcut("i", modifiers: [.command]) // ⌘+I to call eye dropper tool

                Button("Save Current Color") {
                    viewModel.saveCurrentColor()
                }
                .keyboardShortcut("s", modifiers: [.command]) // ⌘+S to save the color
            }
        }
        .defaultSize(width: 300, height: 500)
        .windowResizability(.contentSize)
    }
}
