//
//  AnalyzePDFButton.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI

struct AnalyzePDFButton: View {
    
    @Environment(FileDropViewModel.self) var fileDropVM
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        ZStack {
            if !fileDropVM.droppedFilePaths.isEmpty {
                Button(action: {
                    openWindow(id: "pdfAnalyzerWindow")
                }) {
                    Text("Analyze PDF(s)")
                        .foregroundStyle(.secondary)
                        .font(Font.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .appBackground(material: .thickMaterial, fillOpacity: 0.1)
                }
                .buttonStyle(.plain)
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: fileDropVM.droppedFilePaths)
    }
}
