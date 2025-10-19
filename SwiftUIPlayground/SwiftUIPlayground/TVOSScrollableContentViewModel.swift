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
        
        // Main Title
        var title = AttributedString("tvOS AttributedString Showcase\n\n")
        title.font = .system(size: 52, weight: .black)
        title.foregroundColor = .cyan
        result.append(title)
        
        // Subtitle
        var subtitle = AttributedString("A Comprehensive Guide to Rich Text Formatting on Apple TV\n\n")
        subtitle.font = .system(size: 36, weight: .medium).italic()
        subtitle.foregroundColor = .yellow
        result.append(subtitle)
        
        // SECTION 1: Introduction
        var section1Title = AttributedString("📱 Introduction to AttributedStrings\n")
        section1Title.font = .system(size: 40, weight: .bold)
        section1Title.foregroundColor = .green
        result.append(section1Title)
        
        var intro1 = AttributedString("Welcome to the comprehensive world of ")
        intro1.font = .system(size: 32)
        intro1.foregroundColor = .white
        result.append(intro1)
        
        var intro1Bold = AttributedString("attributed strings")
        intro1Bold.font = .system(size: 32, weight: .bold)
        intro1Bold.foregroundColor = .orange
        result.append(intro1Bold)
        
        var intro2 = AttributedString(" in SwiftUI! This powerful feature allows you to create ")
        intro2.font = .system(size: 32)
        intro2.foregroundColor = .white
        result.append(intro2)
        
        var intro2Italic = AttributedString("stunning, dynamic text")
        intro2Italic.font = .system(size: 32).italic()
        intro2Italic.foregroundColor = .pink
        result.append(intro2Italic)
        
        var intro3 = AttributedString(" with multiple styles, colors, and formatting options all within a single text view.\n\n")
        intro3.font = .system(size: 32)
        intro3.foregroundColor = .white
        result.append(intro3)
        
        var intro4 = AttributedString("Unlike traditional plain text, attributed strings give you ")
        intro4.font = .system(size: 32)
        intro4.foregroundColor = .white
        result.append(intro4)
        
        var intro4Emphasis = AttributedString("pixel-perfect control")
        intro4Emphasis.font = .system(size: 34, weight: .heavy)
        intro4Emphasis.foregroundColor = .red
        result.append(intro4Emphasis)
        
        var intro5 = AttributedString(" over every character, word, and paragraph. This enables rich typography, enhanced readability, and beautiful visual presentations that capture your users' attention.\n\n")
        intro5.font = .system(size: 32)
        intro5.foregroundColor = .white
        result.append(intro5)
        
        // SECTION 2: Text Styling Features
        var section2Title = AttributedString("🎨 Text Styling Features\n")
        section2Title.font = .system(size: 40, weight: .bold)
        section2Title.foregroundColor = .green
        result.append(section2Title)
        
        var styling1 = AttributedString("With AttributedString, you can effortlessly create ")
        styling1.font = .system(size: 32)
        styling1.foregroundColor = .white
        result.append(styling1)
        
        var coloredWord = AttributedString("colored")
        coloredWord.font = .system(size: 32)
        coloredWord.foregroundColor = .red
        result.append(coloredWord)
        
        var comma1 = AttributedString(" text, ")
        comma1.font = .system(size: 32)
        comma1.foregroundColor = .white
        result.append(comma1)
        
        var boldWord = AttributedString("bold")
        boldWord.font = .system(size: 32, weight: .bold)
        boldWord.foregroundColor = .white
        result.append(boldWord)
        
        var comma2 = AttributedString(" text, ")
        comma2.font = .system(size: 32)
        comma2.foregroundColor = .white
        result.append(comma2)
        
        var italicWord = AttributedString("italic")
        italicWord.font = .system(size: 32).italic()
        italicWord.foregroundColor = .white
        result.append(italicWord)
        
        var comma3 = AttributedString(" text, ")
        comma3.font = .system(size: 32)
        comma3.foregroundColor = .white
        result.append(comma3)
        
        var largeWord = AttributedString("LARGE")
        largeWord.font = .system(size: 44, weight: .heavy)
        largeWord.foregroundColor = .purple
        result.append(largeWord)
        
        var comma4 = AttributedString(" text, ")
        comma4.font = .system(size: 32)
        comma4.foregroundColor = .white
        result.append(comma4)
        
        var smallWord = AttributedString("small")
        smallWord.font = .system(size: 24)
        smallWord.foregroundColor = .gray
        result.append(smallWord)
        
        var comma5 = AttributedString(" text, and even ")
        comma5.font = .system(size: 32)
        comma5.foregroundColor = .white
        result.append(comma5)
        
        var combinedWord = AttributedString("combined styles")
        combinedWord.font = .system(size: 36, weight: .bold).italic()
        combinedWord.foregroundColor = .cyan
        result.append(combinedWord)
        
        var styling2 = AttributedString(" all in one paragraph!\n\n")
        styling2.font = .system(size: 32)
        styling2.foregroundColor = .white
        result.append(styling2)
        
        // SECTION 3: Color Spectrum
        var section3Title = AttributedString("🌈 Full Color Spectrum\n")
        section3Title.font = .system(size: 40, weight: .bold)
        section3Title.foregroundColor = .green
        result.append(section3Title)
        
        let colorPairs: [(String, Color)] = [
            ("Red", .red), ("Orange", .orange), ("Yellow", .yellow),
            ("Green", .green), ("Blue", .blue), ("Indigo", .indigo),
            ("Purple", .purple), ("Pink", .pink), ("Cyan", .cyan),
            ("Mint", .mint), ("Teal", .teal), ("Brown", .brown)
        ]
        
        for (index, colorPair) in colorPairs.enumerated() {
            var colorText = AttributedString(colorPair.0)
            colorText.font = .system(size: 32, weight: .semibold)
            colorText.foregroundColor = colorPair.1
            result.append(colorText)
            
            if index < colorPairs.count - 1 {
                var separator = AttributedString(" • ")
                separator.font = .system(size: 32)
                separator.foregroundColor = .white
                result.append(separator)
            }
        }
        result.append(AttributedString("\n\n"))
        
        // SECTION 4: Typography Weights
        var section4Title = AttributedString("⚖️ Font Weight Variations\n")
        section4Title.font = .system(size: 40, weight: .bold)
        section4Title.foregroundColor = .green
        result.append(section4Title)
        
        var weight1 = AttributedString("Ultralight • ")
        weight1.font = .system(size: 32, weight: .ultraLight)
        weight1.foregroundColor = .white
        result.append(weight1)
        
        var weight2 = AttributedString("Thin • ")
        weight2.font = .system(size: 32, weight: .thin)
        weight2.foregroundColor = .white
        result.append(weight2)
        
        var weight3 = AttributedString("Light • ")
        weight3.font = .system(size: 32, weight: .light)
        weight3.foregroundColor = .white
        result.append(weight3)
        
        var weight4 = AttributedString("Regular • ")
        weight4.font = .system(size: 32, weight: .regular)
        weight4.foregroundColor = .white
        result.append(weight4)
        
        var weight5 = AttributedString("Medium • ")
        weight5.font = .system(size: 32, weight: .medium)
        weight5.foregroundColor = .white
        result.append(weight5)
        
        var weight6 = AttributedString("Semibold • ")
        weight6.font = .system(size: 32, weight: .semibold)
        weight6.foregroundColor = .white
        result.append(weight6)
        
        var weight7 = AttributedString("Bold • ")
        weight7.font = .system(size: 32, weight: .bold)
        weight7.foregroundColor = .white
        result.append(weight7)
        
        var weight8 = AttributedString("Heavy • ")
        weight8.font = .system(size: 32, weight: .heavy)
        weight8.foregroundColor = .white
        result.append(weight8)
        
        var weight9 = AttributedString("Black")
        weight9.font = .system(size: 32, weight: .black)
        weight9.foregroundColor = .white
        result.append(weight9)
        
        result.append(AttributedString("\n\n"))
        
        // SECTION 5: Advanced Formatting
        var section5Title = AttributedString("✨ Advanced Formatting Techniques\n")
        section5Title.font = .system(size: 40, weight: .bold)
        section5Title.foregroundColor = .green
        result.append(section5Title)
        
        var advanced1 = AttributedString("In this advanced section, we explore ")
        advanced1.font = .system(size: 32)
        advanced1.foregroundColor = .white
        result.append(advanced1)
        
        var advanced1a = AttributedString("complex")
        advanced1a.font = .system(size: 32, weight: .bold)
        advanced1a.foregroundColor = .orange
        result.append(advanced1a)
        
        var advanced2 = AttributedString(" text compositions that combine ")
        advanced2.font = .system(size: 32)
        advanced2.foregroundColor = .white
        result.append(advanced2)
        
        var advanced2a = AttributedString("multiple")
        advanced2a.font = .system(size: 34).italic()
        advanced2a.foregroundColor = .cyan
        result.append(advanced2a)
        
        var advanced3 = AttributedString(" attributes within the ")
        advanced3.font = .system(size: 32)
        advanced3.foregroundColor = .white
        result.append(advanced3)
        
        var advanced3a = AttributedString("SAME")
        advanced3a.font = .system(size: 38, weight: .heavy)
        advanced3a.foregroundColor = .red
        result.append(advanced3a)
        
        var advanced4 = AttributedString(" sentence. This creates ")
        advanced4.font = .system(size: 32)
        advanced4.foregroundColor = .white
        result.append(advanced4)
        
        var advanced4a = AttributedString("visual hierarchy")
        advanced4a.font = .system(size: 32, weight: .semibold)
        advanced4a.foregroundColor = .yellow
        result.append(advanced4a)
        
        var advanced5 = AttributedString(" and draws attention to ")
        advanced5.font = .system(size: 32)
        advanced5.foregroundColor = .white
        result.append(advanced5)
        
        var advanced5a = AttributedString("key concepts")
        advanced5a.font = .system(size: 32, weight: .bold).italic()
        advanced5a.foregroundColor = .pink
        result.append(advanced5a)
        
        var advanced6 = AttributedString(" that readers should remember.\n\n")
        advanced6.font = .system(size: 32)
        advanced6.foregroundColor = .white
        result.append(advanced6)
        
        // SECTION 6: SwiftUI Integration
        var section6Title = AttributedString("🔧 SwiftUI Integration\n")
        section6Title.font = .system(size: 40, weight: .bold)
        section6Title.foregroundColor = .green
        result.append(section6Title)
        
        var swiftui1 = AttributedString("SwiftUI's AttributedString API provides a ")
        swiftui1.font = .system(size: 32)
        swiftui1.foregroundColor = .white
        result.append(swiftui1)
        
        var swiftui1a = AttributedString("type-safe")
        swiftui1a.font = .system(size: 32, weight: .bold)
        swiftui1a.foregroundColor = .orange
        result.append(swiftui1a)
        
        var swiftui2 = AttributedString(" way to create rich text. Unlike ")
        swiftui2.font = .system(size: 32)
        swiftui2.foregroundColor = .white
        result.append(swiftui2)
        
        var swiftui2a = AttributedString("NSAttributedString")
        swiftui2a.font = .system(size: 30, weight: .medium)
        swiftui2a.foregroundColor = .gray
        result.append(swiftui2a)
        
        var swiftui3 = AttributedString(", it uses Swift's modern syntax and ")
        swiftui3.font = .system(size: 32)
        swiftui3.foregroundColor = .white
        result.append(swiftui3)
        
        var swiftui3a = AttributedString("value semantics")
        swiftui3a.font = .system(size: 32).italic()
        swiftui3a.foregroundColor = .cyan
        result.append(swiftui3a)
        
        var swiftui4 = AttributedString(", making it easier to work with and significantly less error-prone than traditional approaches.\n\n")
        swiftui4.font = .system(size: 32)
        swiftui4.foregroundColor = .white
        result.append(swiftui4)
        
        var swiftui5 = AttributedString("The framework seamlessly integrates with SwiftUI's ")
        swiftui5.font = .system(size: 32)
        swiftui5.foregroundColor = .white
        result.append(swiftui5)
        
        var swiftui5a = AttributedString("declarative")
        swiftui5a.font = .system(size: 32, weight: .semibold)
        swiftui5a.foregroundColor = .purple
        result.append(swiftui5a)
        
        var swiftui6 = AttributedString(" syntax, allowing developers to compose complex text layouts with minimal code.\n\n")
        swiftui6.font = .system(size: 32)
        swiftui6.foregroundColor = .white
        result.append(swiftui6)
        
        // SECTION 7: tvOS Considerations
        var section7Title = AttributedString("📺 tvOS Design Considerations\n")
        section7Title.font = .system(size: 40, weight: .bold)
        section7Title.foregroundColor = .green
        result.append(section7Title)
        
        var tvos1 = AttributedString("Note: ")
        tvos1.font = .system(size: 32, weight: .bold)
        tvos1.foregroundColor = .red
        result.append(tvos1)
        
        var tvos2 = AttributedString("On tvOS, text formatting must be carefully considered for readability on ")
        tvos2.font = .system(size: 32)
        tvos2.foregroundColor = .white
        result.append(tvos2)
        
        var tvos2a = AttributedString("large screens")
        tvos2a.font = .system(size: 34, weight: .bold)
        tvos2a.foregroundColor = .yellow
        result.append(tvos2a)
        
        var tvos3 = AttributedString(" viewed from a distance. Appropriate font sizes (typically ")
        tvos3.font = .system(size: 32)
        tvos3.foregroundColor = .white
        result.append(tvos3)
        
        var tvos3a = AttributedString("28-48pt")
        tvos3a.font = .system(size: 32, weight: .semibold)
        tvos3a.foregroundColor = .cyan
        result.append(tvos3a)
        
        var tvos4 = AttributedString("), sufficient weights, and high-contrast colors ensure the best user experience.\n\n")
        tvos4.font = .system(size: 32)
        tvos4.foregroundColor = .white
        result.append(tvos4)
        
        var tvos5 = AttributedString("The living room environment presents unique challenges: varying lighting conditions, different viewing distances (typically ")
        tvos5.font = .system(size: 32)
        tvos5.foregroundColor = .white
        result.append(tvos5)
        
        var tvos5a = AttributedString("8-12 feet")
        tvos5a.font = .system(size: 32).italic()
        tvos5a.foregroundColor = .orange
        result.append(tvos5a)
        
        var tvos6 = AttributedString("), and diverse screen sizes ranging from modest 40-inch displays to expansive 85-inch home theaters.\n\n")
        tvos6.font = .system(size: 32)
        tvos6.foregroundColor = .white
        result.append(tvos6)
        
        // SECTION 8: Performance Tips
        var section8Title = AttributedString("⚡ Performance Optimization\n")
        section8Title.font = .system(size: 40, weight: .bold)
        section8Title.foregroundColor = .green
        result.append(section8Title)
        
        var perf1 = AttributedString("Performance optimization becomes ")
        perf1.font = .system(size: 32)
        perf1.foregroundColor = .white
        result.append(perf1)
        
        var perf1a = AttributedString("critically important")
        perf1a.font = .system(size: 32, weight: .bold)
        perf1a.foregroundColor = .red
        result.append(perf1a)
        
        var perf2 = AttributedString(" when dealing with long scrolling content like this demonstration. Efficient rendering, careful state management, and proper view hierarchy design ensure that applications remain ")
        perf2.font = .system(size: 32)
        perf2.foregroundColor = .white
        result.append(perf2)
        
        var perf2a = AttributedString("responsive")
        perf2a.font = .system(size: 32).italic()
        perf2a.foregroundColor = .green
        result.append(perf2a)
        
        var perf3 = AttributedString(" even with substantial amounts of styled text.\n\n")
        perf3.font = .system(size: 32)
        perf3.foregroundColor = .white
        result.append(perf3)
        
        var perf4 = AttributedString("Key strategies include: using ")
        perf4.font = .system(size: 32)
        perf4.foregroundColor = .white
        result.append(perf4)
        
        var perf4a = AttributedString("lazy loading")
        perf4a.font = .system(size: 32, weight: .semibold)
        perf4a.foregroundColor = .yellow
        result.append(perf4a)
        
        var perf5 = AttributedString(" for content, minimizing ")
        perf5.font = .system(size: 32)
        perf5.foregroundColor = .white
        result.append(perf5)
        
        var perf5a = AttributedString("view redraws")
        perf5a.font = .system(size: 32, weight: .semibold)
        perf5a.foregroundColor = .cyan
        result.append(perf5a)
        
        var perf6 = AttributedString(", and avoiding unnecessary ")
        perf6.font = .system(size: 32)
        perf6.foregroundColor = .white
        result.append(perf6)
        
        var perf6a = AttributedString("state updates")
        perf6a.font = .system(size: 32, weight: .semibold)
        perf6a.foregroundColor = .purple
        result.append(perf6a)
        
        var perf7 = AttributedString(".\n\n")
        perf7.font = .system(size: 32)
        perf7.foregroundColor = .white
        result.append(perf7)
        
        // SECTION 9: Accessibility
        var section9Title = AttributedString("♿ Accessibility Features\n")
        section9Title.font = .system(size: 40, weight: .bold)
        section9Title.foregroundColor = .green
        result.append(section9Title)
        
        var access1 = AttributedString("Accessibility on tvOS includes ")
        access1.font = .system(size: 32)
        access1.foregroundColor = .white
        result.append(access1)
        
        var access1a = AttributedString("VoiceOver")
        access1a.font = .system(size: 32, weight: .bold)
        access1a.foregroundColor = .orange
        result.append(access1a)
        
        var access2 = AttributedString(" support, which reads content aloud to users with visual impairments. Proper semantic structure, meaningful labels, and logical reading order ensure that ")
        access2.font = .system(size: 32)
        access2.foregroundColor = .white
        result.append(access2)
        
        var access2a = AttributedString("all users")
        access2a.font = .system(size: 34, weight: .bold).italic()
        access2a.foregroundColor = .pink
        result.append(access2a)
        
        var access3 = AttributedString(" can navigate and consume content effectively, regardless of their physical abilities.\n\n")
        access3.font = .system(size: 32)
        access3.foregroundColor = .white
        result.append(access3)
        
        var access4 = AttributedString("Additional features include ")
        access4.font = .system(size: 32)
        access4.foregroundColor = .white
        result.append(access4)
        
        var access4a = AttributedString("Dynamic Type")
        access4a.font = .system(size: 32, weight: .semibold)
        access4a.foregroundColor = .cyan
        result.append(access4a)
        
        var access5 = AttributedString(" for text scaling, ")
        access5.font = .system(size: 32)
        access5.foregroundColor = .white
        result.append(access5)
        
        var access5a = AttributedString("Reduce Motion")
        access5a.font = .system(size: 32, weight: .semibold)
        access5a.foregroundColor = .yellow
        result.append(access5a)
        
        var access6 = AttributedString(" for animation preferences, and ")
        access6.font = .system(size: 32)
        access6.foregroundColor = .white
        result.append(access6)
        
        var access6a = AttributedString("Increase Contrast")
        access6a.font = .system(size: 32, weight: .semibold)
        access6a.foregroundColor = .purple
        result.append(access6a)
        
        var access7 = AttributedString(" for better visibility.\n\n")
        access7.font = .system(size: 32)
        access7.foregroundColor = .white
        result.append(access7)
        
        // SECTION 10: Animation & Transitions
        var section10Title = AttributedString("🎬 Animation & Transitions\n")
        section10Title.font = .system(size: 40, weight: .bold)
        section10Title.foregroundColor = .green
        result.append(section10Title)
        
        var anim1 = AttributedString("This scrolling implementation uses ")
        anim1.font = .system(size: 32)
        anim1.foregroundColor = .white
        result.append(anim1)
        
        var anim1a = AttributedString("easeInOut")
        anim1a.font = .system(size: 32, weight: .semibold)
        anim1a.foregroundColor = .cyan
        result.append(anim1a)
        
        var anim2 = AttributedString(" animation curves that provide natural acceleration and deceleration. The ")
        anim2.font = .system(size: 32)
        anim2.foregroundColor = .white
        result.append(anim2)
        
        var anim2a = AttributedString("0.3-second duration")
        anim2a.font = .system(size: 32).italic()
        anim2a.foregroundColor = .yellow
        result.append(anim2a)
        
        var anim3 = AttributedString(" feels responsive without being jarring, creating a polished user experience that feels ")
        anim3.font = .system(size: 32)
        anim3.foregroundColor = .white
        result.append(anim3)
        
        var anim3a = AttributedString("premium")
        anim3a.font = .system(size: 34, weight: .bold)
        anim3a.foregroundColor = .pink
        result.append(anim3a)
        
        var anim4 = AttributedString(" and professional.\n\n")
        anim4.font = .system(size: 32)
        anim4.foregroundColor = .white
        result.append(anim4)
        
        // SECTION 11: Architecture
        var section11Title = AttributedString("🏗️ MVVM Architecture\n")
        section11Title.font = .system(size: 40, weight: .bold)
        section11Title.foregroundColor = .green
        result.append(section11Title)
        
        var arch1 = AttributedString("This demonstration follows the ")
        arch1.font = .system(size: 32)
        arch1.foregroundColor = .white
        result.append(arch1)
        
        var arch1a = AttributedString("Model-View-ViewModel")
        arch1a.font = .system(size: 32, weight: .bold)
        arch1a.foregroundColor = .orange
        result.append(arch1a)
        
        var arch2 = AttributedString(" pattern, separating ")
        arch2.font = .system(size: 32)
        arch2.foregroundColor = .white
        result.append(arch2)
        
        var arch2a = AttributedString("presentation logic")
        arch2a.font = .system(size: 32).italic()
        arch2a.foregroundColor = .cyan
        result.append(arch2a)
        
        var arch3 = AttributedString(" from ")
        arch3.font = .system(size: 32)
        arch3.foregroundColor = .white
        result.append(arch3)
        
        var arch3a = AttributedString("business logic")
        arch3a.font = .system(size: 32).italic()
        arch3a.foregroundColor = .purple
        result.append(arch3a)
        
        var arch4 = AttributedString(" and ")
        arch4.font = .system(size: 32)
        arch4.foregroundColor = .white
        result.append(arch4)
        
        var arch4a = AttributedString("UI rendering")
        arch4a.font = .system(size: 32).italic()
        arch4a.foregroundColor = .yellow
        result.append(arch4a)
        
        var arch5 = AttributedString(". This architectural approach promotes ")
        arch5.font = .system(size: 32)
        arch5.foregroundColor = .white
        result.append(arch5)
        
        var arch5a = AttributedString("testability")
        arch5a.font = .system(size: 32, weight: .semibold)
        arch5a.foregroundColor = .green
        result.append(arch5a)
        
        var arch6 = AttributedString(", ")
        arch6.font = .system(size: 32)
        arch6.foregroundColor = .white
        result.append(arch6)
        
        var arch6a = AttributedString("maintainability")
        arch6a.font = .system(size: 32, weight: .semibold)
        arch6a.foregroundColor = .cyan
        result.append(arch6a)
        
        var arch7 = AttributedString(", and ")
        arch7.font = .system(size: 32)
        arch7.foregroundColor = .white
        result.append(arch7)
        
        var arch7a = AttributedString("reusability")
        arch7a.font = .system(size: 32, weight: .semibold)
        arch7a.foregroundColor = .pink
        result.append(arch7a)
        
        var arch8 = AttributedString(".\n\n")
        arch8.font = .system(size: 32)
        arch8.foregroundColor = .white
        result.append(arch8)
        
        var arch9 = AttributedString("The ViewModel handles content loading, state management, and mode switching, while the View focuses purely on presentation and user interaction.\n\n")
        arch9.font = .system(size: 32)
        arch9.foregroundColor = .white
        result.append(arch9)
        
        // SECTION 12: Real-World Applications
        var section12Title = AttributedString("💼 Real-World Applications\n")
        section12Title.font = .system(size: 40, weight: .bold)
        section12Title.foregroundColor = .green
        result.append(section12Title)
        
        var app1 = AttributedString("AttributedStrings shine in numerous real-world scenarios:\n\n")
        app1.font = .system(size: 32)
        app1.foregroundColor = .white
        result.append(app1)
        
        var bullet1 = AttributedString("• News & Articles: ")
        bullet1.font = .system(size: 32, weight: .bold)
        bullet1.foregroundColor = .yellow
        result.append(bullet1)
        
        var bullet1a = AttributedString("Headlines, bylines, and body text with distinct styling\n")
        bullet1a.font = .system(size: 32)
        bullet1a.foregroundColor = .white
        result.append(bullet1a)
        
        var bullet2 = AttributedString("• Movie Descriptions: ")
        bullet2.font = .system(size: 32, weight: .bold)
        bullet2.foregroundColor = .cyan
        result.append(bullet2)
        
        var bullet2a = AttributedString("Titles, ratings, genres, and synopses with rich formatting\n")
        bullet2a.font = .system(size: 32)
        bullet2a.foregroundColor = .white
        result.append(bullet2a)
        
        var bullet3 = AttributedString("• Shopping Apps: ")
        bullet3.font = .system(size: 32, weight: .bold)
        bullet3.foregroundColor = .orange
        result.append(bullet3)
        
        var bullet3a = AttributedString("Product names, prices, discounts, and descriptions\n")
        bullet3a.font = .system(size: 32)
        bullet3a.foregroundColor = .white
        result.append(bullet3a)
        
        var bullet4 = AttributedString("• Recipe Apps: ")
        bullet4.font = .system(size: 32, weight: .bold)
        bullet4.foregroundColor = .pink
        result.append(bullet4)
        
        var bullet4a = AttributedString("Ingredients, instructions, timing, and nutritional info\n")
        bullet4a.font = .system(size: 32)
        bullet4a.foregroundColor = .white
        result.append(bullet4a)
        
        var bullet5 = AttributedString("• Educational Content: ")
        bullet5.font = .system(size: 32, weight: .bold)
        bullet5.foregroundColor = .purple
        result.append(bullet5)
        
        var bullet5a = AttributedString("Lessons with emphasized key terms and concepts\n\n")
        bullet5a.font = .system(size: 32)
        bullet5a.foregroundColor = .white
        result.append(bullet5a)
        
        // SECTION 13: Best Practices
        var section13Title = AttributedString("✅ Best Practices & Guidelines\n")
        section13Title.font = .system(size: 40, weight: .bold)
        section13Title.foregroundColor = .green
        result.append(section13Title)
        
        var bp1 = AttributedString("Tip #1: ")
        bp1.font = .system(size: 32, weight: .bold)
        bp1.foregroundColor = .red
        result.append(bp1)
        
        var bp1a = AttributedString("Use ")
        bp1a.font = .system(size: 32)
        bp1a.foregroundColor = .white
        result.append(bp1a)
        
        var bp1b = AttributedString("consistent color palettes")
        bp1b.font = .system(size: 32).italic()
        bp1b.foregroundColor = .yellow
        result.append(bp1b)
        
        var bp1c = AttributedString(" throughout your app to maintain visual coherence and brand identity.\n\n")
        bp1c.font = .system(size: 32)
        bp1c.foregroundColor = .white
        result.append(bp1c)
        
        var bp2 = AttributedString("Tip #2: ")
        bp2.font = .system(size: 32, weight: .bold)
        bp2.foregroundColor = .red
        result.append(bp2)
        
        var bp2a = AttributedString("Limit the number of ")
        bp2a.font = .system(size: 32)
        bp2a.foregroundColor = .white
        result.append(bp2a)
        
        var bp2b = AttributedString("font weights")
        bp2b.font = .system(size: 32).italic()
        bp2b.foregroundColor = .cyan
        result.append(bp2b)
        
        var bp2c = AttributedString(" in a single view to avoid visual clutter and maintain hierarchy.\n\n")
        bp2c.font = .system(size: 32)
        bp2c.foregroundColor = .white
        result.append(bp2c)
        
        var bp3 = AttributedString("Tip #3: ")
        bp3.font = .system(size: 32, weight: .bold)
        bp3.foregroundColor = .red
        result.append(bp3)
        
        var bp3a = AttributedString("Test on ")
        bp3a.font = .system(size: 32)
        bp3a.foregroundColor = .white
        result.append(bp3a)
        
        var bp3b = AttributedString("actual TV hardware")
        bp3b.font = .system(size: 32).italic()
        bp3b.foregroundColor = .purple
        result.append(bp3b)
        
        var bp3c = AttributedString(" from typical viewing distances to ensure readability.\n\n")
        bp3c.font = .system(size: 32)
        bp3c.foregroundColor = .white
        result.append(bp3c)
        
        var bp4 = AttributedString("Tip #4: ")
        bp4.font = .system(size: 32, weight: .bold)
        bp4.foregroundColor = .red
        result.append(bp4)
        
        var bp4a = AttributedString("Prioritize ")
        bp4a.font = .system(size: 32)
        bp4a.foregroundColor = .white
        result.append(bp4a)
        
        var bp4b = AttributedString("high contrast")
        bp4b.font = .system(size: 32).italic()
        bp4b.foregroundColor = .orange
        result.append(bp4b)
        
        var bp4c = AttributedString(" between text and background colors for maximum legibility.\n\n")
        bp4c.font = .system(size: 32)
        bp4c.foregroundColor = .white
        result.append(bp4c)
        
        // SECTION 14: Future Enhancements
        var section14Title = AttributedString("🚀 Future Enhancements\n")
        section14Title.font = .system(size: 40, weight: .bold)
        section14Title.foregroundColor = .green
        result.append(section14Title)
        
        var future1 = AttributedString("This implementation serves as a ")
        future1.font = .system(size: 32)
        future1.foregroundColor = .white
        result.append(future1)
        
        var future1a = AttributedString("proof of concept")
        future1a.font = .system(size: 32, weight: .bold)
        future1a.foregroundColor = .cyan
        result.append(future1a)
        
        var future2 = AttributedString(" that can be extended with additional features such as:\n\n")
        future2.font = .system(size: 32)
        future2.foregroundColor = .white
        result.append(future2)
        
        var future3 = AttributedString("→ Momentum scrolling with deceleration\n→ Page indicators showing scroll progress\n→ Search functionality with highlighted results\n→ Bookmarking favorite sections\n→ Content sharing capabilities\n→ Dark/Light mode theming\n→ Customizable font size preferences\n→ Multi-column layouts for large displays\n\n")
        future3.font = .system(size: 30)
        future3.foregroundColor = .white
        result.append(future3)
        
        // SECTION 15: Conclusion
        var section15Title = AttributedString("🎯 Conclusion\n")
        section15Title.font = .system(size: 40, weight: .bold)
        section15Title.foregroundColor = .green
        result.append(section15Title)
        
        var conclusion1 = AttributedString("AttributedStrings in SwiftUI represent a ")
        conclusion1.font = .system(size: 32)
        conclusion1.foregroundColor = .white
        result.append(conclusion1)
        
        var conclusion1a = AttributedString("powerful tool")
        conclusion1a.font = .system(size: 34, weight: .bold)
        conclusion1a.foregroundColor = .yellow
        result.append(conclusion1a)
        
        var conclusion2 = AttributedString(" for creating ")
        conclusion2.font = .system(size: 32)
        conclusion2.foregroundColor = .white
        result.append(conclusion2)
        
        var conclusion2a = AttributedString("engaging")
        conclusion2a.font = .system(size: 32).italic()
        conclusion2a.foregroundColor = .orange
        result.append(conclusion2a)
        
        var conclusion3 = AttributedString(", ")
        conclusion3.font = .system(size: 32)
        conclusion3.foregroundColor = .white
        result.append(conclusion3)
        
        var conclusion3a = AttributedString("beautiful")
        conclusion3a.font = .system(size: 32).italic()
        conclusion3a.foregroundColor = .pink
        result.append(conclusion3a)
        
        var conclusion4 = AttributedString(", and ")
        conclusion4.font = .system(size: 32)
        conclusion4.foregroundColor = .white
        result.append(conclusion4)
        
        var conclusion4a = AttributedString("highly readable")
        conclusion4a.font = .system(size: 32).italic()
        conclusion4a.foregroundColor = .cyan
        result.append(conclusion4a)
        
        var conclusion5 = AttributedString(" text interfaces. When combined with proper architecture, thoughtful design, and attention to platform-specific considerations, they enable developers to craft ")
        conclusion5.font = .system(size: 32)
        conclusion5.foregroundColor = .white
        result.append(conclusion5)
        
        var conclusion5a = AttributedString("exceptional user experiences")
        conclusion5a.font = .system(size: 34, weight: .bold).italic()
        conclusion5a.foregroundColor = .purple
        result.append(conclusion5a)
        
        var conclusion6 = AttributedString(" that delight users and set your applications apart.\n\n")
        conclusion6.font = .system(size: 32)
        conclusion6.foregroundColor = .white
        result.append(conclusion6)
        
        var conclusion7 = AttributedString("The journey of mastering attributed strings is one of continuous exploration and refinement. Each project presents new opportunities to experiment with typography, color, and layout—creating digital experiences that are not just functional, but ")
        conclusion7.font = .system(size: 32)
        conclusion7.foregroundColor = .white
        result.append(conclusion7)
        
        var conclusion7a = AttributedString("truly memorable")
        conclusion7a.font = .system(size: 36, weight: .bold)
        conclusion7a.foregroundColor = .red
        result.append(conclusion7a)
        
        var conclusion8 = AttributedString(".\n\n")
        conclusion8.font = .system(size: 32)
        conclusion8.foregroundColor = .white
        result.append(conclusion8)
        
        // Footer
        var footer = AttributedString("━━━━━━━━━━━━━━━━━━━━━━\n")
        footer.font = .system(size: 28)
        footer.foregroundColor = .gray
        result.append(footer)
        
        var footerText = AttributedString("Thank you for exploring this AttributedString showcase!\n")
        footerText.font = .system(size: 32).italic()
        footerText.foregroundColor = .cyan
        result.append(footerText)
        
        var footerEnd = AttributedString("Built with ❤️ using SwiftUI & AttributedString")
        footerEnd.font = .system(size: 28, weight: .medium)
        footerEnd.foregroundColor = .yellow
        result.append(footerEnd)
        
        return result
    }
}

