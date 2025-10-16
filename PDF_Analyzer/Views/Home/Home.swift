//
//  ContentView.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(FileDropViewModel.self) var fileDropVM

    var body: some View {
        @Bindable var fileDropVM = fileDropVM
        VStack {
            DropZone()
                .padding([.top, .horizontal])
            DroppedFiles()
                .padding([.horizontal])
                .padding(.top, 8)
            AnalyzePDFButton()
            .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


#Preview {
    
    @Previewable @State var fileDropVM: FileDropViewModel = .init()
    @Previewable @State var toastVM   : ToastViewModel = .init()
    
    HomeView()
        .environment(fileDropVM)
        .environment(toastVM)
}
