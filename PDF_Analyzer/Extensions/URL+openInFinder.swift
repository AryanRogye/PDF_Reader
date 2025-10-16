//
//  URL+openInFinder.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import AppKit

extension URL {
    func openInFinder() {
        NSWorkspace.shared.activateFileViewerSelecting([self])
    }
}
