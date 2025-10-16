# PDF Analyzer

PDF Analyzer is a macOS SwiftUI app that lets you drag-and-drop PDF files, review their metadata, and stage them for deeper inspection. The current focus is providing a smooth drop experience with room to grow into full document analysis tooling.

## Features
- Drag-and-drop drop zone that accepts PDFs and animates when users hover files.
- List of dropped documents with creation-time metadata, delete swipe actions, and quick Finder access.
- Secondary window scaffolding ready for upcoming PDF insight modules.

## Requirements
- macOS 14 (Sonoma) or newer.
- Xcode 15 or newer with Swift 5.9 toolchain.
- Swift Package Manager (SPM) to resolve third-party packages.

## Getting Started
Open `PDF_Analyzer.xcodeproj` in Xcode, select the `PDF_Analyzer` scheme, and press `Run`.

## Project Structure
- `PDF_AnalyzerApp.swift` – App entry point that wires environment objects and windows.
- `Views/` – SwiftUI screens and reusable components (Home layout, drop zone, dropped-file list, analyze button).
- `ViewModel/` – Observable view models (file drop state, toast orchestration).
- `Extensions/` – Helpers for URLs, dates, and view styling.
- `Assets.xcassets/` – App assets and colors.

## Architecture
The app adheres to MVVM. View models own state and side effects, while SwiftUI views declare the UI and observe changes through the `@Observable` macro (Observer pattern). Environment injection keeps dependencies lightweight, and components communicate through those shared view models.

## Dependencies
- [SimpleToast](https://github.com/thomasvisser/SwiftUI-Toast) – Lightweight toast presentation for SwiftUI.

## Roadmap Ideas
- Integrate Apple’s Foundation model APIs (and optionally Ollama) to contextualize on-screen PDF content.
- Implement PDF parsing and summary generation in the secondary window.
- Persist dropped file history across launches.
- Add validation feedback for unsupported file types.
- Provide unit/UI tests and CI automation.

## License
This project does not yet include an explicit license. Add one (e.g., MIT, Apache 2.0) before publishing the repository.
