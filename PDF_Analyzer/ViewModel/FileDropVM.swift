//
//  FileDropVM.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import Foundation

@Observable @MainActor
final class FileDropViewModel {
    var droppedFilePaths: [URL] = []
    
    public func handleDrop(items : [URL]) -> Bool {
        for url in items {
            
            /// Make Sure We Only Allow PDF's For Now
            if url.pathExtension == "pdf" {
                droppedFilePaths.append(url)
                print("Dropped file: \(url.lastPathComponent)")
            }
        }
        return true
    }
    
    public func remove(_ url: URL) {
        droppedFilePaths.removeAll { $0 == url }
    }
}
