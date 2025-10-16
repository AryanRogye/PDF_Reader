//
//  AnalyzedPDF.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import FoundationModels

@Generable
struct AnalyzedPage {
    @Guide(description: "Key points from this page. Bullet-y, short.")
    var keyPoints: [String] = []
    
    @Guide(description: "Questions a student could answer from this page.")
    var questions: [String] = []
    
    @Guide(description: "Cross-references: page numbers this page depends on or relates to.")
    var relatedPages: [Int] = []
}

@Generable
struct AnalyzedPDF {
    @Guide(description: "Total pages provided by the app. Must equal pages.count.")
    var pageCount: Int = 0
    
    @Guide(description: "Per-page analysis. Must have exactly pageCount items and preserve order (page 1 first).")
    var pages: [AnalyzedPage] = []
}
