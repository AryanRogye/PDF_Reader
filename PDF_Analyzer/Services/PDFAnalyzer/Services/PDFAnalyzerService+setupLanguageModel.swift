//
//  PersonalHelperService+setupLanguageModel.swift
//  VocalMe
//
//  Created by Aryan Rogye on 10/15/25.
//

import FoundationModels

extension PDFAnalyzerService {
    internal func setupLanguageModel() {
        let instructions = """
        You are an expert PDF learning assistant. You receive the PDF as
        page-delimited text and must return JSON conforming to AnalyzedPDF.
        
        CONTRACT:
        - pages.count MUST equal pageCount.
        - Preserve order (page 1 first).
        - Keep keyPoints concise. Avoid repeating across pages—use relatedPages.
        - If a page is blank/noisy, still include it with empty keyPoints and an explanation.
        
        INPUT FORMAT:
        <<<PAGE 1>>>
        ...text...
        <<<PAGE 2>>>
        ...text...
        (continues)
        
        OUTPUT: strictly fill AnalyzedPDF schema. No extra fields.
        """
        
        session = LanguageModelSession(instructions: instructions)
    }
}
