//
//  PDFAnalyzerProviding.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

protocol PDFAnalyzerProviding {
    func sendMessage(
        _ content: [String],
        completion: @escaping (AnalyzedPDF.PartiallyGenerated?) -> Void,
        finalText: @escaping (AnalyzedPDF.PartiallyGenerated?) -> Void
    ) async throws
}
