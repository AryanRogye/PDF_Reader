//
//  PDF_AnalyzerApp.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI
import SimpleToast

@main
struct PDF_AnalyzerApp: App {
    
    @State var toastVM : ToastViewModel = ToastViewModel()
    @State var fileDropVM : FileDropViewModel = FileDropViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(toastVM)
                .environment(fileDropVM)
                .simpleToast(
                    isPresented: $toastVM.shouldShowToast,
                    options: toastVM.toastOptions
                ) {
                    toastVM.currentView
                }
            
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        
        WindowGroup(id: "pdfAnalyzerWindow") {
            MainView(pdfURLs: fileDropVM.droppedFilePaths)
                .environment(toastVM)
                .environment(fileDropVM)
        }
        .defaultLaunchBehavior(.suppressed)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
    }
}
