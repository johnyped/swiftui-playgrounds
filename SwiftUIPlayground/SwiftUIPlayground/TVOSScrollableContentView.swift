//
//  TVOSScrollableContentView.swift
//  SwiftUIPlayground
//
//  Created by AI Assistant
//

import SwiftUI

@available(tvOS 15.0, *)
struct TVOSScrollableContentView: View {
    @StateObject private var viewModel = TVOSScrollableContentViewModel()
    @FocusState private var isFocused: Bool
    @FocusState private var toggleButtonFocused: Bool
    
    // View-specific geometry state
    @State private var textHeight: CGFloat = 0
    @State private var viewportHeight: CGFloat = 0
    
    // View constants
    private let extraPadding: CGFloat = 50
    
    // Computed maximum scroll offset based on geometry
    private var maxScrollOffset: CGFloat {
        let calculatedMax = max(0, textHeight - viewportHeight + extraPadding)
        return calculatedMax
    }
    
    var body: some View {
        ZStack {
            // Main ScrollView Container
            GeometryReader { viewportGeometry in
                ScrollView {
                    // Display either plain or attributed text based on contentMode
                    Group {
                        switch viewModel.contentMode {
                        case .plain:
                            Text(viewModel.plainText)
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                        case .attributed:
                            Text(viewModel.attributedText)
								.foregroundStyle(Color.gray.opacity(0.2))
                        }
                    }
                    .padding(.horizontal, 60)
                    .padding(.top, viewModel.topOffset)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        GeometryReader { textGeometry in
                            Color.clear
                                .onAppear {
                                    // Capture text height when it first appears
                                    textHeight = textGeometry.size.height
                                    viewportHeight = viewportGeometry.size.height
									print("#DEBUG: onAppear")
									print("#DEBUG: textHeight: \(textHeight)")
									print("#DEBUG: viewportHeight: \(viewportHeight)")
                                }
                                .onChange(of: textGeometry.size.height) { oldHeight, newHeight in
                                    // Update if text height changes
//									if textHeight == 0 {
//										textHeight = newHeight
//									}
                                    textHeight = newHeight+300
									print("#DEBUG: onChange")
									print("#DEBUG: textGeometry.size.height: \(newHeight)")
                                }
                        }
                    )
                    .animation(.easeInOut(duration: 0.3), value: viewModel.topOffset)
                }
                .scrollDisabled(true) // Disable native scrolling
                .background(Color.black)
                .clipped() // Ensure content is clipped at borders
                .onAppear {
                    viewportHeight = viewportGeometry.size.height
                }
            }
            .overlay(
                // Invisible focusable button to capture remote button input
                Button(action: {}) {
                    Color.clear
                }
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .focusable(true)
                .focused($isFocused)
            )
            .onMoveCommand { direction in
                handleMoveCommand(direction: direction)
            }
            .onAppear {
                // Ensure the view is focused on appear
                isFocused = true
            }
            
            // Loading overlay
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.7)
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(2)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Text("Loading content...")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                    }
                }
                .ignoresSafeArea()
            }

            // Debug indicator (bottom-right)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Mode: \(viewModel.contentMode == .plain ? "Plain" : "Attributed")")
                        Text("Offset: \(Int(viewModel.topOffset))")
                        Text("Max: -\(Int(maxScrollOffset))")
                        Text("Text H: \(Int(textHeight))")
                        Text("View H: \(Int(viewportHeight))")
                    }
                    .font(.system(size: 20))
                    .foregroundColor(.white.opacity(0.7))
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
    }
    
    private func handleMoveCommand(direction: MoveCommandDirection) {
        withAnimation(.easeInOut(duration: 0.3)) {
            switch direction {
            case .down:
                // Button DOWN - scroll content up (show later content)
                viewModel.scrollUp(maxOffset: maxScrollOffset)
            case .up:
                // Button UP - scroll content down (show earlier content)
                viewModel.scrollDown()
            case .left:
                // Switch focus to toggle button
                toggleButtonFocused = true
            case .right:
                // Return focus to scrollable content
                isFocused = true
            default:
                break
            }
        }
    }
}

#Preview {
    if #available(tvOS 15.0, *) {
        TVOSScrollableContentView()
    }
}
