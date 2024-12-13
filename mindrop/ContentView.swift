import SwiftUI

/// The main content view that organizes and displays the color picker UI components.
struct ContentView: View {
    @EnvironmentObject var viewModel: ColorPickerViewModel

    var body: some View {
        VStack(spacing: 20) {
            ColorDisplayView()
            RGBSlidersView()
            HStack {
                EyeDropperButton()
                Button(action: viewModel.copyHexToClipboard) {
                    Image(systemName: "doc.on.doc.fill")
                    Text("Hex")
                }
                .help("⌘+Shift+C")
                Button(action: viewModel.copyRGBToClipboard) {
                    Image(systemName: "doc.on.doc.fill")
                    Text("RGB")
                }
                .help("⌘+Shift+R")
                Button(action: viewModel.saveCurrentColor) {
                    Image(systemName: "square.and.arrow.down.fill")
                }
                .help("⌘+S")
            }
            ColorGridView()
        }
        .padding()
        .frame(width: 300, height: 500)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ColorPickerViewModel())
    }
}
