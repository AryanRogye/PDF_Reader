//
//  MainView.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI
import PDFKit

struct MainView: View {
    
    @State private var pdfAnalyzerVM : PDFAnalyzerViewModel
    @State private var selection: UserDroppedPDF?
    
    init(pdfURLs: [URL]) {
        _pdfAnalyzerVM = .init(wrappedValue: PDFAnalyzerViewModel(pdfURLs))
    }
    

    var body: some View {
        NavigationSplitView {
            List(pdfAnalyzerVM.pdfs, id: \.self, selection: $selection) { pdf in
                Text(pdf.url.lastPathComponent)
                    .tag(pdf)
            }
            .frame(minWidth: 220)
        } detail: {
            
            if let selection = selection {
                PDFViewer(pdfAnalyzerVM: pdfAnalyzerVM, selection: $selection, url: selection.url)
                    .id(selection)
            } else {
                ContentUnavailableView("Select a PDF", systemImage: "doc.richtext")
            }
        }
        .onAppear {
            if selection == nil {
                selection = pdfAnalyzerVM.pdfs.first
            }
        }
    }
}

struct PDFViewer: View {
    
    @Bindable var pdfAnalyzerVM : PDFAnalyzerViewModel
    @Binding var selection: UserDroppedPDF?
    
    let url: URL
    var body: some View {
        PDFKitView(url: url)
            .inspector(isPresented: $pdfAnalyzerVM.isInspectorShowing) {
                InspectorView(pdfAnalyzerVM: pdfAnalyzerVM, selection: $selection)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        pdfAnalyzerVM.isInspectorShowing.toggle()
                    }) {
                        Image(systemName: "sidebar.right")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
            }
    }
}

struct InspectorView: View {
    
    @Bindable var pdfAnalyzerVM : PDFAnalyzerViewModel
    @Binding var selection : UserDroppedPDF?
    
    var body: some View {
        if let selection = selection {
            TabView {
                List {
                    ForEach(Array(selection.pages.enumerated()), id: \.offset) { index, page in
                        Section(header: Text("Page \(index)")) {
                            Text(page)
                        }
                    }
                }
                .tabItem {
                    Label("Description", systemImage: "library")
                }
                
                VStack {
                    Button("Generate") { Task { await pdfAnalyzerVM.beginAnalyzing(pdf: selection) } }
                    if let analyzed = pdfAnalyzerVM.analyzedPDF, let pages = analyzed.pages {
                        List {
                            ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                                Section(header: Text("Page \(index)")) {
                                    if let keyPoints = page.keyPoints {
                                        Section("Key Points") {
                                            ForEach(keyPoints, id: \.self) { point in
                                                Text("\(point)")
                                            }
                                        }
                                    }
                                    if let questions = page.questions {
                                        Section("Questions") {
                                            ForEach(questions, id: \.self) { question in
                                                Text(question)
                                            }
                                        }
                                    }
                                    if let relatedPages = page.relatedPages {
                                        Section("Related Pages") {
                                            ForEach(relatedPages, id: \.self) { relatedPage in
                                                Text("\(relatedPage)")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .tabItem {
                    Label("Help", systemImage: "wand.and.sparkles")
                }
            }
        }
    }
}

struct PDFKitView: NSViewRepresentable { // use UIViewRepresentable on iOS
    let url: URL
    func makeNSView(context: Context) -> PDFView {
        let view = PDFView()
        view.autoScales = true
        view.document = PDFDocument(url: url)
        return view
    }
    func updateNSView(_ view: PDFView, context: Context) {}
}
