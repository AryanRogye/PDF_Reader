//
//  AIHelperService+Helpers.swift
//  VocalMe
//
//  Created by Aryan Rogye on 10/14/25.
//

import FoundationModels
import Foundation

extension PDFAnalyzerService {
    internal func checkModelAvailability() async {
        // Check availability of the system language model and store a human-readable reason if unavailable.
        let availability = SystemLanguageModel.default.availability
        switch availability {
        case .available:
            availabilityReason = nil
        case .unavailable(let reason):
            switch reason {
            case .appleIntelligenceNotEnabled:
                availabilityReason = "Apple Intelligence is not enabled in Settings."
            case .deviceNotEligible:
                availabilityReason = "This device is not eligible for Apple Intelligence."
            case .modelNotReady:
                availabilityReason = "The on-device model is downloading or not ready."
            default:
                availabilityReason = "The language model is currently unavailable."
            }
        }
    }
    
    func buildContent(from pages: [String]) -> String {
        var s = ""
        for (i, text) in pages.enumerated() {
            s += "<<<PAGE \(i+1)>>>\n"
            s += text
            s += "\n"
        }
        return s
    }
}
