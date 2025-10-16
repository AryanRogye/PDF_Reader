//
//  URL+creationDate.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import Foundation

extension URL {
    func creationDate() -> Date? {
        do {
            let resourceValues = try self.resourceValues(forKeys: [.creationDateKey])
            return resourceValues.creationDate
        } catch {
            print("Error getting resource values: \(error)")
            return nil
        }
    }
}
