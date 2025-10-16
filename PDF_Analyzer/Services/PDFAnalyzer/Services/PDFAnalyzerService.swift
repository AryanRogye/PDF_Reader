//
//  PDFAnalyzerService.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import Foundation
import FoundationModels

final class PDFAnalyzerService: PDFAnalyzerProviding {
    
    var session : LanguageModelSession?
    internal var availabilityReason: String? = nil
    
    init() {
        Task { [weak self] in
            await self?.checkModelAvailability()
        }
        setupLanguageModel()
    }
}
