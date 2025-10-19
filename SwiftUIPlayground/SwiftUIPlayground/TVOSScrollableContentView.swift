//
//  TVOSScrollableContentView.swift
//  SwiftUIPlayground
//
//  Created by AI Assistant
//

import SwiftUI

@available(tvOS 15.0, *)
struct TVOSScrollableContentView: View {
    @State private var topOffset: CGFloat = 0
    @FocusState private var isFocused: Bool
    @State private var textHeight: CGFloat = 0
    @State private var viewportHeight: CGFloat = 0
    
    // Fixed scroll offset per button press
    private let scrollStep: CGFloat = 300

    // Computed maximum scroll offset based on text and viewport height
    private var maxScrollOffset: CGFloat {
        // Add 200 points of extra padding to allow scrolling "past" the bottom
        let extraPadding: CGFloat = 50
        let calculatedMax = max(0, textHeight - viewportHeight + extraPadding)
        return calculatedMax
    }
    
    var body: some View {
        ZStack {
            // ScrollView acts as clipping container
            GeometryReader { viewportGeometry in
                ScrollView {
                    Text(generateLongText())
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                        .padding(.horizontal, 60)
                        .padding(.top, topOffset)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            GeometryReader { textGeometry in
                                Color.clear
                                    .onAppear {
                                        // Capture text height when it first appears
                                        textHeight = textGeometry.size.height
                                        viewportHeight = viewportGeometry.size.height
                                    }
//                                    .onChange(of: textGeometry.size.height) { newHeight in
//                                        // Update if text height changes
//                                        textHeight = newHeight
//                                    }
                            }
                        )
                        .animation(.easeInOut(duration: 0.3), value: topOffset)
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
            
            // Debug indicator (optional)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Offset: \(Int(topOffset))")
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
                // Button UP - scroll content up (show later content)
                scrollUp()
			case .up:
                // Button DOWN - scroll content down (show earlier content)
                scrollDown()
            default:
                break
            }
        }
    }
    
    private func scrollUp() {
        // Move content up (negative offset increases)
        topOffset -= scrollStep
        // Clamp to maximum scroll (prevent scrolling past the end)
        if abs(topOffset) > maxScrollOffset {
            topOffset = -maxScrollOffset
        }
    }
    
    private func scrollDown() {
        // Move content down (return towards zero)
        topOffset += scrollStep
        // Don't scroll beyond the top
        if topOffset > 0 {
            topOffset = 0
        }
    }
    
    private func generateLongText() -> String {
        let paragraphs = [
            "In the vast expanse of the digital realm, where code and creativity intertwine, developers embark on journeys to craft experiences that transcend the boundaries of imagination. Each line of code represents a thought, a decision, a pathway to innovation.",
            
            "SwiftUI revolutionized the way we build user interfaces, bringing declarative syntax and reactive programming to the forefront of iOS, macOS, watchOS, and tvOS development. The framework's elegant approach allows developers to describe what they want, and the system handles the how.",
            
            "The Apple TV Remote, with its intuitive touch surface and directional controls, presents unique challenges and opportunities for interface design. Creating seamless navigation experiences requires thoughtful consideration of user interaction patterns and accessibility requirements.",
            
            "Scrolling content on tvOS differs significantly from touch-based devices. Users expect precise control, visual feedback, and smooth animations that respond to their input. The remote's directional pad becomes the primary means of navigation through lengthy content.",
            
            "This demonstration showcases the power of programmatic scrolling using ScrollViewReader, a SwiftUI component that enables precise control over scroll positions. By combining state management with animation, we create a fluid experience that feels natural on the big screen.",
            
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            
            "The integration of focus management in tvOS applications is crucial for creating intuitive user experiences. SwiftUI's focus system allows developers to control which elements receive input from the remote, ensuring that navigation flows naturally through the interface.",
            
            "Performance optimization becomes particularly important when dealing with long scrolling content. Lazy loading, efficient rendering, and careful state management ensure that the application remains responsive even with substantial amounts of text or complex layouts.",
            
            "Accessibility features on tvOS include VoiceOver support, which reads content aloud to users with visual impairments. Proper semantic structure and meaningful labels ensure that all users can navigate and consume content effectively.",
            
            "The tvOS platform offers unique opportunities for immersive experiences in living room environments. Large screens demand careful consideration of typography, spacing, and visual hierarchy to maintain readability from viewing distances of several feet.",
            
            "Animation curves and timing functions play a vital role in creating polished user interfaces. The ease-in-out curve used in this implementation provides a natural acceleration and deceleration that feels responsive without being jarring.",
            
            "State management in SwiftUI follows a unidirectional data flow pattern, where changes to state trigger view updates automatically. This reactive approach simplifies the development of complex interfaces while maintaining predictable behavior.",
            
            "The @State property wrapper enables views to own and modify their local state, triggering re-renders when values change. Combined with @Binding and other property wrappers, SwiftUI provides a comprehensive toolkit for managing application state.",
            
            "Custom text generation functions demonstrate the flexibility of Swift's string handling capabilities. Building dynamic content programmatically allows for adaptable interfaces that can respond to user preferences, localization requirements, and content variations.",
            
            "Testing tvOS applications requires either physical hardware or the Xcode simulator. The simulator provides a convenient development environment, though testing on actual Apple TV devices ensures the most accurate representation of user experience.",
            
            "Debug overlays and visual indicators help developers understand the current state of the application during development. These tools can be conditionally compiled or toggled based on build configurations to keep production releases clean.",
            
            "The future of tvOS development continues to evolve with each new release of the operating system and SwiftUI framework. Staying current with best practices and new APIs ensures that applications remain competitive and provide cutting-edge experiences.",
            
            "Color schemes and visual design principles for large screens differ from mobile devices. High contrast, generous spacing, and carefully chosen typography ensure content remains legible and engaging when viewed from across the room.",
            
            "This implementation demonstrates a proof of concept that can be extended and refined for production use. Additional features might include momentum scrolling, page indicators, content loading states, and integration with backend services.",
            
            "Performance monitoring and profiling tools help identify bottlenecks and optimization opportunities. Instruments, Xcode's profiling suite, provides detailed insights into CPU usage, memory allocation, and rendering performance.",
            
            "The modular architecture of SwiftUI encourages component reusability and separation of concerns. Building small, focused views that can be composed into larger interfaces promotes maintainable and testable code.",
            
            "Documentation and code comments serve as valuable resources for future developers and your future self. Clear explanations of implementation decisions and edge cases prevent confusion and facilitate collaboration.",
            
            "Version control systems like Git enable teams to collaborate effectively, tracking changes over time and facilitating code review processes. Meaningful commit messages and organized branch strategies contribute to project success.",
            
            "Continuous integration and automated testing pipelines ensure code quality and prevent regressions. Investing in testing infrastructure pays dividends in reduced bugs and increased confidence in deployments.",
            
            "The journey of software development is one of continuous learning and improvement. Each project presents new challenges and opportunities to refine skills, explore technologies, and create meaningful experiences for users around the world."
        ]
        
        return paragraphs.joined(separator: "\n\n")
    }
}

#Preview {
    if #available(tvOS 15.0, *) {
        TVOSScrollableContentView()
    }
}
