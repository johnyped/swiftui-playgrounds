//
//  DemoReadJson.swift
//  SwiftUIPlayground
//
//  Created by MacAir on 18/10/2568 BE.
//

import SwiftUI

// MARK: - Models

struct Person: Codable, Identifiable, Equatable {
	let id: Int
	let name: String
}

struct JsonFileInfo: Identifiable {
	let id = UUID()
	let fileName: String
	let path: String
	let description: String
	var person: Person?
	var error: String?
	
	var fullPath: String {
		path.isEmpty ? fileName : "\(path)/\(fileName)"
	}
}

// MARK: - View Model

@Observable
class DemoReadJsonViewModel {
	var jsonFiles: [JsonFileInfo] = []
	var isLoading = false
	var showDebugInfo = false
	
	init() {
		setupFiles()
	}
	
	private func setupFiles() {
		jsonFiles = [
			JsonFileInfo(
				fileName: "content",
				path: "Jsons",
				description: "Person data from Jsons folder"
			),
			JsonFileInfo(
				fileName: "nest_content",
				path: "Jsons/Nest",
				description: "Person data from nested folder"
			)
		]
	}
	
	func loadAllFiles() {
		isLoading = true
		
		// Load each file using JsonFile
		for index in jsonFiles.indices {
			let fileInfo = jsonFiles[index]
			let jsonFile = JsonFile(path: fileInfo.path)
			
			// Try to decode the file
			if let person = jsonFile.decode(from: fileInfo.fileName, as: Person.self) {
				jsonFiles[index].person = person
				jsonFiles[index].error = nil
			} else {
				jsonFiles[index].person = nil
				jsonFiles[index].error = "Failed to load or decode file"
			}
		}
		
		isLoading = false
	}
	
	func loadFile(at index: Int) {
		guard index < jsonFiles.count else { return }
		
		let fileInfo = jsonFiles[index]
		let jsonFile = JsonFile(path: fileInfo.path)
		
		if let person = jsonFile.decode(from: fileInfo.fileName, as: Person.self) {
			jsonFiles[index].person = person
			jsonFiles[index].error = nil
		} else {
			jsonFiles[index].person = nil
			jsonFiles[index].error = "Failed to load or decode file"
		}
	}
	
	func getJsonString(at index: Int) -> String? {
		guard index < jsonFiles.count else { return nil }
		
		let fileInfo = jsonFiles[index]
		let jsonFile = JsonFile(path: fileInfo.path)
		
		return jsonFile.jsonString(from: fileInfo.fileName, prettyPrinted: true)
	}
}

// MARK: - Main View

struct DemoReadJsonView: View {
	@State private var viewModel = DemoReadJsonViewModel()
	
	var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				headerSection
				
				if viewModel.isLoading {
					loadingSection
				} else {
					filesSection
				}
				
				debugSection
				
				Spacer(minLength: 20)
			}
			.padding()
		}
		.navigationTitle("JSON File Demo")
		#if os(iOS)
		.navigationBarTitleDisplayMode(.large)
		#endif
	}
	
	// MARK: - Header Section
	
	private var headerSection: some View {
		VStack(spacing: 12) {
			Image(systemName: "doc.text.fill")
				.font(.system(size: 50))
				.foregroundStyle(.blue.gradient)
			
			Text("JSON File Reader Demo")
				.font(.title2)
				.fontWeight(.bold)
			
			Text("Using JsonFile utility class")
				.font(.subheadline)
				.foregroundStyle(.secondary)
			
			Button(action: viewModel.loadAllFiles) {
				Label("Load All Files", systemImage: "arrow.clockwise")
					.font(.headline)
					.foregroundStyle(.white)
					.frame(maxWidth: .infinity)
					.padding()
					.background(.blue.gradient, in: RoundedRectangle(cornerRadius: 12))
			}
			.buttonStyle(.plain)
		}
		.padding()
		.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
	}
	
	// MARK: - Loading Section
	
	private var loadingSection: some View {
		VStack(spacing: 16) {
			ProgressView()
				.scaleEffect(1.5)
			Text("Loading JSON files...")
				.font(.headline)
				.foregroundStyle(.secondary)
		}
		.frame(maxWidth: .infinity)
		.padding(40)
	}
	
	// MARK: - Files Section
	
	private var filesSection: some View {
		VStack(spacing: 16) {
			ForEach(Array(viewModel.jsonFiles.enumerated()), id: \.element.id) { index, fileInfo in
				JsonFileCard(
					fileInfo: fileInfo,
					onLoad: { viewModel.loadFile(at: index) },
					onShowJson: {
						if let jsonString = viewModel.getJsonString(at: index) {
							print("📄 JSON Content:\n\(jsonString)")
						}
					}
				)
			}
		}
	}
	
	// MARK: - Debug Section
	
	private var debugSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Button(action: { viewModel.showDebugInfo.toggle() }) {
				HStack {
					Image(systemName: viewModel.showDebugInfo ? "chevron.down" : "chevron.right")
					Text("Debug Info")
						.font(.headline)
				}
			}
			.buttonStyle(.plain)
			
			if viewModel.showDebugInfo {
				VStack(alignment: .leading, spacing: 8) {
					Text("Files loaded: \(viewModel.jsonFiles.filter { $0.person != nil }.count)/\(viewModel.jsonFiles.count)")
					
					ForEach(viewModel.jsonFiles) { fileInfo in
						HStack {
							Image(systemName: fileInfo.person != nil ? "checkmark.circle.fill" : "xmark.circle.fill")
								.foregroundStyle(fileInfo.person != nil ? .green : .red)
							Text(fileInfo.fullPath)
								.font(.system(.caption, design: .monospaced))
						}
					}
					
					Divider()
					
					Text("💡 Tip: JsonFile uses smart fallback")
						.font(.caption)
						.foregroundStyle(.secondary)
					Text("It works with both flattened and structured bundles")
						.font(.caption2)
						.foregroundStyle(.secondary)
				}
				.padding()
				.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
			}
		}
		.padding()
	}
}

// MARK: - JSON File Card Component

struct JsonFileCard: View {
	let fileInfo: JsonFileInfo
	let onLoad: () -> Void
	let onShowJson: () -> Void
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			// Header
			HStack {
				Image(systemName: "doc.text.fill")
					.font(.title2)
					.foregroundStyle(.blue)
				
				VStack(alignment: .leading, spacing: 4) {
					Text(fileInfo.fileName + ".json")
						.font(.headline)
						.fontWeight(.semibold)
					
					Text(fileInfo.description)
						.font(.caption)
						.foregroundStyle(.secondary)
				}
				
				Spacer()
				
				statusBadge
			}
			
			// Path info
			HStack {
				Image(systemName: "folder.fill")
					.foregroundStyle(.orange)
				Text(fileInfo.fullPath)
					.font(.system(.caption, design: .monospaced))
					.foregroundStyle(.secondary)
			}
			.padding(.horizontal, 12)
			.padding(.vertical, 6)
			.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
			
			Divider()
			
			// Content
			if let person = fileInfo.person {
				personContent(person)
			} else if let error = fileInfo.error {
				errorContent(error)
			} else {
				emptyContent
			}
			
			// Actions
			HStack(spacing: 12) {
				Button(action: onLoad) {
					Label("Load", systemImage: "arrow.down.circle")
						.font(.subheadline)
						.fontWeight(.medium)
						.frame(maxWidth: .infinity)
						.padding(.vertical, 10)
						.background(.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
						.foregroundStyle(.blue)
				}
				.buttonStyle(.plain)
				
				Button(action: onShowJson) {
					Label("View JSON", systemImage: "doc.plaintext")
						.font(.subheadline)
						.fontWeight(.medium)
						.frame(maxWidth: .infinity)
						.padding(.vertical, 10)
						.background(.green.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
						.foregroundStyle(.green)
				}
				.buttonStyle(.plain)
			}
		}
		.padding()
		.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
		.overlay(
			RoundedRectangle(cornerRadius: 16)
				.stroke(.gray.opacity(0.2), lineWidth: 1)
		)
	}
	
	private var statusBadge: some View {
		Group {
			if fileInfo.person != nil {
				Image(systemName: "checkmark.circle.fill")
					.foregroundStyle(.green)
			} else if fileInfo.error != nil {
				Image(systemName: "exclamationmark.circle.fill")
					.foregroundStyle(.red)
			} else {
				Image(systemName: "circle.dashed")
					.foregroundStyle(.gray)
			}
		}
		.font(.title3)
	}
	
	private func personContent(_ person: Person) -> some View {
		VStack(spacing: 12) {
			HStack {
				VStack(alignment: .leading, spacing: 4) {
					Text("ID")
						.font(.caption)
						.foregroundStyle(.secondary)
					Text("\(person.id)")
						.font(.title2)
						.fontWeight(.bold)
						.foregroundStyle(.blue)
				}
				
				Spacer()
				
				VStack(alignment: .trailing, spacing: 4) {
					Text("Name")
						.font(.caption)
						.foregroundStyle(.secondary)
					Text(person.name)
						.font(.title3)
						.fontWeight(.semibold)
				}
			}
			.padding()
			.background(.green.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
		}
	}
	
	private func errorContent(_ error: String) -> some View {
		HStack {
			Image(systemName: "exclamationmark.triangle.fill")
				.foregroundStyle(.red)
			Text(error)
				.font(.subheadline)
				.foregroundStyle(.secondary)
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(.red.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
	}
	
	private var emptyContent: some View {
		HStack {
			Image(systemName: "doc.badge.ellipsis")
				.foregroundStyle(.gray)
			Text("Tap 'Load' to read file")
				.font(.subheadline)
				.foregroundStyle(.secondary)
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
	}
}

// MARK: - Preview

#Preview {
	NavigationStack {
		DemoReadJsonView()
	}
}
