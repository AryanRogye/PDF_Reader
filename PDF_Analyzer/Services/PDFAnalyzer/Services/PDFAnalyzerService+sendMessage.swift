//
//  PDFAnalyzerService+sendMessage.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import FoundationModels
import Foundation

enum PersonalHelperError: Error, LocalizedError {
    case ModelUnavailable(String)
    case LanguageModelSessionDoesntExist
    case ModelCouldntFinish(String)
    
    var errorDescription: String? {
        switch self {
        case .ModelUnavailable(let reason):
            return "Model Unavailable: \(reason)"
        case .LanguageModelSessionDoesntExist:
            return "Language Model Session Doesnt Exist"
        case .ModelCouldntFinish(let reason):
            return "Model Couldnt Finish: \(reason)"
        }
    }
}

extension PDFAnalyzerService {
    
    func sendMessage(
        _ content: [String],
        completion: @escaping (AnalyzedPDF.PartiallyGenerated?) -> Void,
        finalText: @escaping (AnalyzedPDF.PartiallyGenerated?) -> Void) async throws {
            
            var content = buildContent(from: content)
            
            guard case .available = SystemLanguageModel.default.availability else {
                throw PersonalHelperError.ModelUnavailable(availabilityReason ?? "Language model is unavailable.")
            }
            
            guard let session = session else {
                throw PersonalHelperError.LanguageModelSessionDoesntExist
            }
            
            
            do {
                let stream = session.streamResponse(
                    to: content,
                    generating: AnalyzedPDF.self
                )
                
                var analyzed : AnalyzedPDF.PartiallyGenerated?
                
                for try await partial in stream {
                    analyzed = partial.content
                    completion(analyzed)
                }
                
                finalText(analyzed)
            } catch {
                throw PersonalHelperError.ModelCouldntFinish(error.localizedDescription)
            }
        }
}
