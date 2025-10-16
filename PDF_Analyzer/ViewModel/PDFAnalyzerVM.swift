//
//  PDFAnalyzerVM.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI
import PDFKit

struct UserDroppedPDF: Identifiable, Hashable {
    let id : UUID = UUID()
    var url: URL
    var pages: [String]
}

@Observable @MainActor
final class PDFAnalyzerViewModel {
    
    var pdfs : [UserDroppedPDF] = []
    var isInspectorShowing = false
    var pdfAnalyzer : any PDFAnalyzerProviding
    
    var analyzedPDF : AnalyzedPDF.PartiallyGenerated?
    var analyzedPDFDone : AnalyzedPDF.PartiallyGenerated?
    
    init(_ urls: [URL]) {
        self.pdfAnalyzer = PDFAnalyzerService()
        for url in urls {
            let pdf = UserDroppedPDF(
                url: url,
                pages: extractTextByPage(url)
            )
            pdfs.append(pdf)
        }
    }
    
    func extractTextByPage(_ url: URL) -> [String] {
        guard let doc = PDFDocument(url: url) else { return [] }
        var out: [String] = []
        for i in 0..<doc.pageCount {
            if let page = doc.page(at: i),
               let s = page.attributedString?.string, !s.isEmpty {
                out.append(s)
            }
        }
        return out
    }
    
    func beginAnalyzing(pdf: UserDroppedPDF) async {
        do {
            try await pdfAnalyzer.sendMessage(
                pdf.pages,
                completion: { analyzedPDF in
                    self.analyzedPDF = analyzedPDF
                    print("Getting Back Completion")
                },
                finalText: { finalAnalyzed in
                    print("FINISHED")
                    self.analyzedPDF = finalAnalyzed
                    self.analyzedPDFDone = finalAnalyzed
                }
            )
        } catch {
            print("Something went wrong: \(error)")
        }
    }
}

