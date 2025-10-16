//
//  DroppedFiles.swift
//  PDF_Analyzer
//
//  Created by Aryan Rogye on 10/15/25.
//

import SwiftUI

struct DroppedFiles: View {
    
    @Environment(FileDropViewModel.self) var fileDropVM
    @Environment(ToastViewModel.self) var toastVM
    
    var body: some View {
        @Bindable var fileDropVM = fileDropVM
        VStack(alignment: .center) {
            if fileDropVM.droppedFilePaths.isEmpty {
                Image(systemName: "doc.text")
                    .resizable()
                    .frame(width: 20, height: 25)
                    .foregroundStyle(.secondary)
                    .opacity(0.3)
                    .padding(.top)
                Text("No Files Dropped")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .opacity(0.3)
            } else {
                List {
                    ForEach(fileDropVM.droppedFilePaths, id: \.self) { path in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(path.lastPathComponent)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                                if let creation = path.creationDate() {
                                    Text(creation.timeAgoDisplay())
                                }
                            }
                            Spacer()
                        }
                        .listRowSeparator(.hidden)
                        .padding()
                        .appBackground(material: .thickMaterial)
                        .padding(.horizontal)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive, action: {
                                fileDropVM.remove(path)
                            }) {
                                Image(systemName: "trash")
                            }
                            Button(action: path.openInFinder) {
                                Image(systemName: "folder")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        toastVM.showToast(message: "Swipe Left To Delete A File", isError: false)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .appBackground(material: .thickMaterial)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: fileDropVM.droppedFilePaths)
    }
}
