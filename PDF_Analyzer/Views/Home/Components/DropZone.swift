//
//  DropZone.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI

struct DropZone: View {
    
    @Environment(FileDropViewModel.self) var fileDropVM
    @State private var targeted = false
    @State private var dashPhase: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Drop Your PDF(s) Here")
                .font(Font.title)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .opacity(targeted ? 0.9 : 0.3)
                .scaleEffect(targeted ? 1.05 : 1)
                .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.clear)
                .stroke(
                    targeted
                    ? AnyShapeStyle(Color.accentColor)
                    : AnyShapeStyle(.thickMaterial),
                    style: StrokeStyle(
                        lineWidth: targeted ? 2 : 1,
                        dash: [10],
                        dashPhase: dashPhase
                    )
                )
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: targeted)
        .dropDestination(for: URL.self) { items, location in
            fileDropVM.handleDrop(items: items)
        } isTargeted: { targeted in
            self.targeted = targeted
            if self.targeted {
                withAnimation(.linear.repeatForever(autoreverses: false)) {
                    dashPhase = -20
                }
            } else {
                dashPhase = 0
            }
        }
    }
}
