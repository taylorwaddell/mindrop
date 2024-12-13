//
//  CustomSlider.swift
//  mindrop
//
//  Created by Taylor Waddell on 12/12/24.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    let maxValue: Double
    let gradient: Gradient
    let onEditingChanged: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                LinearGradient(
                    gradient: gradient,
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 14)
                .cornerRadius(5)

                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 12, height: 24)
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                    .overlay(
                        Rectangle()
                            .frame(width: 2, height: 14)
                            .foregroundColor(.gray)
                            .cornerRadius(3)
                    )
                    .offset(x: handlePosition(for: geometry.size.width))
            }
            .frame(height: 24)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let dragX = min(max(gesture.location.x, 0), geometry.size.width)
                        let newValue = round(Double(dragX / geometry.size.width) * maxValue)
                        
                        if newValue != value {
                            withTransaction(Transaction(animation: .none)) {
                                value = newValue
                            }
                            onEditingChanged()
                        }
                    }
            )
        }
        .frame(height: 24)
        .padding(.horizontal)
    }

    private func handlePosition(for trackWidth: CGFloat) -> CGFloat {
        let handleWidth: CGFloat = 12
        let position = CGFloat(value / maxValue) * trackWidth
        return min(max(position - handleWidth / 2, 0), trackWidth - handleWidth)
    }
}
