//
//  JsonFile.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/10/2568 BE.
//

import Foundation

final class JsonFile {
    
    let filePath: String
    private let decoder: JSONDecoder
    
    /// Initialize with a subdirectory path
    /// - Parameters:
    ///   - path: Subdirectory path (e.g., "Jsons" or "Jsons/Nest"). Use empty string "" for root level.
    ///   - decoder: Custom JSONDecoder (optional)
    init(path: String, decoder: JSONDecoder = JSONDecoder()) {
        self.filePath = path
        self.decoder = decoder
    }
    
    /// Initialize for root level files (no subdirectory)
    /// - Parameter decoder: Custom JSONDecoder (optional)
    convenience init(decoder: JSONDecoder = JSONDecoder()) {
        self.init(path: "", decoder: decoder)
    }
    
    // MARK: - Data Loading
    
    /// Find URL for JSON file with fallback strategies
    private func findURL(for fileName: String, in bundle: Bundle) -> URL? {
        // Strategy 1: Try with subdirectory (for folder references)
        if let url = bundle.url(forResource: "\(filePath)/\(fileName)", withExtension: "json") {
            return url
        }
        
        // Strategy 2: Try with subdirectory parameter (alternative approach)
        if !filePath.isEmpty, let url = bundle.url(forResource: fileName, withExtension: "json", subdirectory: filePath) {
            return url
        }
        
        // Strategy 3: Try just the filename (for flattened structure)
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            return url
        }
        
        return nil
    }
    
    /// Load raw Data from JSON file
    func data(from fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = findURL(for: fileName, in: bundle) else {
            print("⚠️ File not found: \(filePath)/\(fileName).json")
            print("   Tried paths:")
            print("   1. \(filePath)/\(fileName).json")
            print("   2. subdirectory: '\(filePath)', resource: '\(fileName).json'")
            print("   3. \(fileName).json (flattened)")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("⚠️ Failed to load data from: \(url.path)")
            return nil
        }
        
        return data
    }
    
    /// Load raw Data from JSON file (throwing version)
    func data(fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = findURL(for: fileName, in: bundle) else {
            throw JsonFileError.fileNotFound(path: "\(filePath)/\(fileName).json")
        }
        
        return try Data(contentsOf: url)
    }
    
    // MARK: - Generic Decoding
    
    /// Decode JSON file to a specific Decodable type
    /// - Parameters:
    ///   - fileName: Name of the JSON file (without extension)
    ///   - type: The type to decode to
    /// - Returns: Decoded object or nil if decoding fails
    func decode<T: Decodable>(from fileName: String, as type: T.Type = T.self) -> T? {
        guard let data = data(from: fileName) else {
            return nil
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("⚠️ Failed to decode \(filePath)/\(fileName).json to \(T.self): \(error)")
            return nil
        }
    }
    
    /// Decode JSON file to a specific Decodable type (throwing version)
    /// - Parameters:
    ///   - fileName: Name of the JSON file (without extension)
    ///   - type: The type to decode to
    /// - Returns: Decoded object
    func decode<T: Decodable>(fileName: String, as type: T.Type = T.self) throws -> T {
        let data = try data(fileName: fileName)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw JsonFileError.decodingFailed(type: String(describing: T.self), error: error)
        }
    }
    
    /// Decode JSON file to an array of a specific Decodable type
    /// - Parameters:
    ///   - fileName: Name of the JSON file (without extension)
    ///   - type: The element type of the array
    /// - Returns: Array of decoded objects or nil if decoding fails
    func decodeArray<T: Decodable>(from fileName: String, as type: T.Type = T.self) -> [T]? {
        guard let data = data(from: fileName) else {
            return nil
        }
        
        do {
            return try decoder.decode([T].self, from: data)
        } catch {
            print("⚠️ Failed to decode \(filePath)/\(fileName).json to [\(T.self)]: \(error)")
            return nil
        }
    }
    
    /// Decode JSON file to an array of a specific Decodable type (throwing version)
    /// - Parameters:
    ///   - fileName: Name of the JSON file (without extension)
    ///   - type: The element type of the array
    /// - Returns: Array of decoded objects
    func decodeArray<T: Decodable>(fileName: String, as type: T.Type = T.self) throws -> [T] {
        let data = try data(fileName: fileName)
        
        do {
            return try decoder.decode([T].self, from: data)
        } catch {
            throw JsonFileError.decodingFailed(type: "[\(String(describing: T.self))]", error: error)
        }
    }
    
    // MARK: - String Conversion
    
    /// Get JSON file content as a formatted string
    func jsonString(from fileName: String, prettyPrinted: Bool = false) -> String? {
        guard let data = data(from: fileName) else {
            return nil
        }
        
        if prettyPrinted,
           let jsonObject = try? JSONSerialization.jsonObject(with: data),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
            return String(data: prettyData, encoding: .utf8)
        }
        
        return String(data: data, encoding: .utf8)
    }
}

// MARK: - Error Handling

enum JsonFileError: LocalizedError {
    case fileNotFound(path: String)
    case decodingFailed(type: String, error: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound(let path):
            return "JSON file not found at path: \(path)"
        case .decodingFailed(let type, let error):
            return "Failed to decode JSON to \(type): \(error.localizedDescription)"
        }
    }
}

// MARK: - Static Helpers

extension JsonFile {
    /// Decode JSON data to a specific Decodable type
    static func decode<T: Decodable>(_ data: Data, as type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
    
    /// Decode JSON string to a specific Decodable type
    static func decode<T: Decodable>(from jsonString: String, as type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        guard let data = jsonString.data(using: .utf8) else {
            throw JsonFileError.decodingFailed(type: String(describing: T.self), error: NSError(domain: "Invalid UTF8", code: -1))
        }
        return try decoder.decode(T.self, from: data)
    }
    
    /// Decode JSON data to an array of a specific Decodable type
    static func decodeArray<T: Decodable>(_ data: Data, as type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> [T] {
        return try decoder.decode([T].self, from: data)
    }
    
    /// Decode JSON string to an array of a specific Decodable type
    static func decodeArray<T: Decodable>(from jsonString: String, as type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> [T] {
        guard let data = jsonString.data(using: .utf8) else {
            throw JsonFileError.decodingFailed(type: "[\(String(describing: T.self))]", error: NSError(domain: "Invalid UTF8", code: -1))
        }
        return try decoder.decode([T].self, from: data)
    }
}

// MARK: - BundleHelper (Simplified)

class BundleHelper {
    static let shared = BundleHelper()
    private let decoder = JSONDecoder()
    
    /// Load data from a resource file
    func data(fromResource name: String, withExtension ext: String = "json") throws -> Data {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: name, withExtension: ext) else {
            throw JsonFileError.fileNotFound(path: "\(name).\(ext)")
        }
        
        return try Data(contentsOf: url)
    }
    
    /// Decode a resource file to a specific Decodable type
    func decode<T: Decodable>(fromResource name: String, as type: T.Type = T.self, withExtension ext: String = "json") throws -> T {
        let data = try data(fromResource: name, withExtension: ext)
        return try decoder.decode(T.self, from: data)
    }
    
    /// Decode a resource file to an array of a specific Decodable type
    func decodeArray<T: Decodable>(fromResource name: String, as type: T.Type = T.self, withExtension ext: String = "json") throws -> [T] {
        let data = try data(fromResource: name, withExtension: ext)
        return try decoder.decode([T].self, from: data)
    }

    /// Print all available paths and files in the bundle for debugging purposes.
    /// This helps visualize the folder structure and all files packaged in the bundle.
    static func printAllPathsAndFilesInBundle() {
        final class BundleHelper: AnyObject {}
        let bundle = Bundle(for: BundleHelper.self)

        guard let resourcePath = bundle.resourcePath else {
            print("No resource path found in test bundle")
            return
        }

        func printDirectoryContents(at path: String, level: Int = 0) {
            let indent = String(repeating: "  ", count: level)
            let fileManager = FileManager.default
            guard let enumerator = fileManager.enumerator(atPath: path) else {
                print("\(indent)- Could not enumerate directory at \(path)")
                return
            }
            var seenDirs = Set<String>()
            for case let item as String in enumerator {
                let fullPath = (path as NSString).appendingPathComponent(item)
                var isDir: ObjCBool = false
                if fileManager.fileExists(atPath: fullPath, isDirectory: &isDir) {
                    if isDir.boolValue {
                        let dir = (item as NSString).lastPathComponent
                        if !seenDirs.contains(dir) {
                            print("\(indent)📁 \(item)/")
                            seenDirs.insert(dir)
                        }
                    } else {
                        print("\(indent)📄 \(item)")
                    }
                }
            }
        }

        print("====== Listing all files and folders in test target bundle ======")
        printDirectoryContents(at: resourcePath)
        print("======= End of listing =======")
    }
}
