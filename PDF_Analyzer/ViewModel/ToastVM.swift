//
//  ToastVM.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI
import SimpleToast

@Observable @MainActor
class ToastViewModel {
    var shouldShowToast: Bool = false
    
    /// Default May Change
    var toastOptions = SimpleToastOptions(
        hideAfter: 5
    )
    
    
    var toastMessage: String? = nil
    var toastImage  : String? = nil
    var isToastError: Bool    = false
    
    public var currentView: some View {
        HStack(spacing: 8) {
            if let symbol = toastImage, !symbol.isEmpty {
                Image(systemName: symbol)
            }
            Text(toastMessage ?? "")
                .font(.callout.weight(.semibold))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background((isToastError ? Color.red : Color.green).opacity(0.85))
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(.top)
    }
    
    public func showToast(
        message toastMessage: String,
        image toastImage  : String? = nil,
        isError isToastError: Bool
    ) {
        self.toastMessage = toastMessage
        self.toastImage  = toastImage
        self.isToastError = isToastError
        shouldShowToast = true
        print("Showing")
    }
}
