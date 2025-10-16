//
//  background.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI

extension View {
    func appBackground(material: Material = .thinMaterial, fillOpacity: CGFloat = 0.0) -> some View {
        self
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(material.opacity(fillOpacity))
                    .stroke(material)
            }
    }
}
