//
//  TVOSScrollableContentViewModel.swift
//  SwiftUIPlayground
//
//  Created by AI Assistant
//

import SwiftUI
import Combine

@available(tvOS 15.0, *)
@MainActor
class TVOSScrollableContentViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isLoading: Bool = false
    @Published var contentMode: ContentMode = .plain
    
    // Content
    @Published var plainText: String = ""
    @Published var attributedText: AttributedString = AttributedString("")

    // MARK: - Content Mode
    enum ContentMode {
        case plain
        case attributed
    }
    
    // MARK: - Initialization
    init() {
        // Load initial plain text
		switch contentMode {
		case .plain:
			loadPlainText()
		case .attributed:
			loadAttributedText()
		}
    }
    
    // MARK: - Data Loading
    
    /// Simulate loading plain text from a service
    func loadPlainText() {
        isLoading = true
        
        // Simulate network delay using Task with MainActor
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0 seconds
            plainText = generatePlainText()
            isLoading = false
        }
    }
    
    /// Simulate loading attributed text from a service
    func loadAttributedText() {
        isLoading = true
        
        // Simulate network delay using Task with MainActor
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0 seconds
            attributedText = generateAttributedText()
            isLoading = false
        }
    }

    func leftBtnAction() {
        guard contentMode != .plain else { return }

        // Load plain text if not already loaded
        if plainText.isEmpty {
            loadPlainText()
        }
        
        self.contentMode = .plain
    }

    func rightBtnAction() {
        guard contentMode != .attributed else { return }

        // Load attributed text if not already loaded
        if attributedText.characters.isEmpty {
            loadAttributedText()
        }
        
        self.contentMode = .attributed
    }

    // MARK: - Content Generation
    
    private func generatePlainText() -> String {
        let paragraphs = [
            "Welcome to tvOS ScrollView Demo",
            "",
            "In the vast expanse of the digital realm, where code and creativity intertwine, developers embark on journeys to craft experiences that transcend the boundaries of imagination. Each line of code represents a thought, a decision, a pathway to innovation.",
            
            "SwiftUI revolutionized the way we build user interfaces, bringing declarative syntax and reactive programming to the forefront of iOS, macOS, watchOS, and tvOS development. The framework's elegant approach allows developers to describe what they want, and the system handles the how.",
            
            "The Apple TV Remote, with its intuitive touch surface and directional controls, presents unique challenges and opportunities for interface design. Creating seamless navigation experiences requires thoughtful consideration of user interaction patterns and accessibility requirements.",
            
            "Scrolling content on tvOS differs significantly from touch-based devices. Users expect precise control, visual feedback, and smooth animations that respond to their input. The remote's directional pad becomes the primary means of navigation through lengthy content.",
            
            "This demonstration showcases the power of programmatic scrolling using padding-based offset control. By combining state management with animation, we create a fluid experience that feels natural on the big screen.",
            
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            
            "The integration of focus management in tvOS applications is crucial for creating intuitive user experiences. SwiftUI's focus system allows developers to control which elements receive input from the remote, ensuring that navigation flows naturally through the interface.",
            
            "Performance optimization becomes particularly important when dealing with long scrolling content. Lazy loading, efficient rendering, and careful state management ensure that the application remains responsive even with substantial amounts of text or complex layouts.",
            
            "Accessibility features on tvOS include VoiceOver support, which reads content aloud to users with visual impairments. Proper semantic structure and meaningful labels ensure that all users can navigate and consume content effectively.",
            
            "The tvOS platform offers unique opportunities for immersive experiences in living room environments. Large screens demand careful consideration of typography, spacing, and visual hierarchy to maintain readability from viewing distances of several feet.",
            
            "Animation curves and timing functions play a vital role in creating polished user interfaces. The ease-in-out curve used in this implementation provides a natural acceleration and deceleration that feels responsive without being jarring.",
            
            "State management in SwiftUI follows a unidirectional data flow pattern, where changes to state trigger view updates automatically. This reactive approach simplifies the development of complex interfaces while maintaining predictable behavior.",
            
            "The @Published property wrapper enables ViewModels to broadcast changes to views, triggering re-renders when values change. Combined with ObservableObject protocol, SwiftUI provides a comprehensive toolkit for managing application state.",
            
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
    
    private func generateAttributedText() -> AttributedString {
        var result = AttributedString()
        
        // Title - Large, Bold, Colored
        var title = AttributedString("tvOS AttributedString Demo\n\n")
        title.font = .system(size: 48, weight: .bold)
        title.foregroundColor = .cyan
        result.append(title)
        
        // Subtitle - Medium, Italic
        var subtitle = AttributedString("Demonstrating Rich Text Formatting\n\n")
        subtitle.font = .system(size: 36, weight: .medium).italic()
        subtitle.foregroundColor = .yellow
        result.append(subtitle)
        
        // Section 1
        var section1Title = AttributedString("Introduction\n")
        section1Title.font = .system(size: 38, weight: .semibold)
        section1Title.foregroundColor = .green
        result.append(section1Title)
        
        var section1Body = AttributedString("Welcome to the world of ")
        section1Body.font = .system(size: 32)
        section1Body.foregroundColor = .white
        result.append(section1Body)
        
        var boldText = AttributedString("attributed strings")
        boldText.font = .system(size: 32, weight: .bold)
        boldText.foregroundColor = .orange
        result.append(boldText)
        
        var section1Body2 = AttributedString(" where you can mix and match different text styles, colors, and formatting within a single text view. This enables ")
        section1Body2.font = .system(size: 32)
        section1Body2.foregroundColor = .white
        result.append(section1Body2)
        
        var italicText = AttributedString("rich typography")
        italicText.font = .system(size: 32).italic()
        italicText.foregroundColor = .pink
        result.append(italicText)
        
        var section1Body3 = AttributedString(" and enhanced readability.\n\n")
        section1Body3.font = .system(size: 32)
        section1Body3.foregroundColor = .white
        result.append(section1Body3)
        
        // Section 2
        var section2Title = AttributedString("Styling Capabilities\n")
        section2Title.font = .system(size: 38, weight: .semibold)
        section2Title.foregroundColor = .green
        result.append(section2Title)
        
        var section2Body = AttributedString("You can create ")
        section2Body.font = .system(size: 32)
        section2Body.foregroundColor = .white
        result.append(section2Body)
        
        var coloredText1 = AttributedString("colored text")
        coloredText1.font = .system(size: 32)
        coloredText1.foregroundColor = .red
        result.append(coloredText1)
        
        var separator1 = AttributedString(", ")
        separator1.font = .system(size: 32)
        separator1.foregroundColor = .white
        result.append(separator1)
        
        var boldText2 = AttributedString("bold text")
        boldText2.font = .system(size: 32, weight: .bold)
        boldText2.foregroundColor = .white
        result.append(boldText2)
        
        var separator2 = AttributedString(", ")
        separator2.font = .system(size: 32)
        separator2.foregroundColor = .white
        result.append(separator2)
        
        var italicText2 = AttributedString("italic text")
        italicText2.font = .system(size: 32).italic()
        italicText2.foregroundColor = .white
        result.append(italicText2)
        
        var separator3 = AttributedString(", and even ")
        separator3.font = .system(size: 32)
        separator3.foregroundColor = .white
        result.append(separator3)
        
        var largeText = AttributedString("LARGE TEXT")
        largeText.font = .system(size: 44, weight: .heavy)
        largeText.foregroundColor = .purple
        result.append(largeText)
        
        var section2End = AttributedString(" or ")
        section2End.font = .system(size: 32)
        section2End.foregroundColor = .white
        result.append(section2End)
        
        var smallText = AttributedString("small text")
        smallText.font = .system(size: 24)
        smallText.foregroundColor = .gray
        result.append(smallText)
        
        var section2End2 = AttributedString(" all in the same paragraph.\n\n")
        section2End2.font = .system(size: 32)
        section2End2.foregroundColor = .white
        result.append(section2End2)
        
        // Section 3
        var section3Title = AttributedString("Color Palette Examples\n")
        section3Title.font = .system(size: 38, weight: .semibold)
        section3Title.foregroundColor = .green
        result.append(section3Title)
        
        let colors: [(String, Color)] = [
            ("Red", .red),
            ("Orange", .orange),
            ("Yellow", .yellow),
            ("Green", .green),
            ("Blue", .blue),
            ("Purple", .purple),
            ("Pink", .pink),
            ("Cyan", .cyan)
        ]
        
        for (index, colorPair) in colors.enumerated() {
            var colorText = AttributedString(colorPair.0)
            colorText.font = .system(size: 32, weight: .semibold)
            colorText.foregroundColor = colorPair.1
            result.append(colorText)
            
            if index < colors.count - 1 {
                var separator = AttributedString(" • ")
                separator.font = .system(size: 32)
                separator.foregroundColor = .white
                result.append(separator)
            }
        }
        
        let section3End = AttributedString("\n\n")
        result.append(section3End)
        
        // Section 4 - Mixed formatting
        var section4Title = AttributedString("Mixed Formatting Example\n")
        section4Title.font = .system(size: 38, weight: .semibold)
        section4Title.foregroundColor = .green
        result.append(section4Title)
        
        var mixedText = AttributedString("In this paragraph, we demonstrate ")
        mixedText.font = .system(size: 32)
        mixedText.foregroundColor = .white
        result.append(mixedText)
        
        var emphasis1 = AttributedString("multiple")
        emphasis1.font = .system(size: 32, weight: .bold)
        emphasis1.foregroundColor = .orange
        result.append(emphasis1)
        
        var mixedText2 = AttributedString(" different ")
        mixedText2.font = .system(size: 32)
        mixedText2.foregroundColor = .white
        result.append(mixedText2)
        
        var emphasis2 = AttributedString("styles")
        emphasis2.font = .system(size: 32).italic()
        emphasis2.foregroundColor = .cyan
        result.append(emphasis2)
        
        var mixedText3 = AttributedString(" within the ")
        mixedText3.font = .system(size: 32)
        mixedText3.foregroundColor = .white
        result.append(mixedText3)
        
        var emphasis3 = AttributedString("same")
        emphasis3.font = .system(size: 36, weight: .heavy)
        emphasis3.foregroundColor = .red
        result.append(emphasis3)
        
        var mixedText4 = AttributedString(" sentence. This creates ")
        mixedText4.font = .system(size: 32)
        mixedText4.foregroundColor = .white
        result.append(mixedText4)
        
        var emphasis4 = AttributedString("visual hierarchy")
        emphasis4.font = .system(size: 32, weight: .semibold)
        emphasis4.foregroundColor = .yellow
        result.append(emphasis4)
        
        var mixedText5 = AttributedString(" and helps ")
        mixedText5.font = .system(size: 32)
        mixedText5.foregroundColor = .white
        result.append(mixedText5)
        
        var emphasis5 = AttributedString("important information")
        emphasis5.font = .system(size: 32, weight: .bold).italic()
        emphasis5.foregroundColor = .pink
        result.append(emphasis5)
        
        var mixedText6 = AttributedString(" stand out to readers.\n\n")
        mixedText6.font = .system(size: 32)
        mixedText6.foregroundColor = .white
        result.append(mixedText6)
        
        // Additional paragraphs with mixed formatting
        var para1 = AttributedString("SwiftUI's AttributedString API provides a type-safe way to create rich text. Unlike NSAttributedString, it uses Swift's modern syntax and value semantics, making it easier to work with and less error-prone.\n\n")
        para1.font = .system(size: 32)
        para1.foregroundColor = .white
        result.append(para1)
        
        var highlightText = AttributedString("Important: ")
        highlightText.font = .system(size: 32, weight: .bold)
        highlightText.foregroundColor = .red
        result.append(highlightText)
        
        var para2 = AttributedString("On tvOS, text formatting must be carefully considered for readability on large screens viewed from a distance. Appropriate font sizes, weights, and colors ensure the best user experience.\n\n")
        para2.font = .system(size: 32)
        para2.foregroundColor = .white
        result.append(para2)
        
        var para3 = AttributedString("This scrolling implementation works seamlessly with both plain and attributed text, demonstrating the flexibility of the SwiftUI framework and the power of proper architecture using ViewModels.\n\n")
        para3.font = .system(size: 32)
        para3.foregroundColor = .white
        result.append(para3)
        
        // Footer
        var footer = AttributedString("End of AttributedString Demo")
        footer.font = .system(size: 36, weight: .semibold).italic()
        footer.foregroundColor = .cyan
        result.append(footer)
        
        return result
    }
}

