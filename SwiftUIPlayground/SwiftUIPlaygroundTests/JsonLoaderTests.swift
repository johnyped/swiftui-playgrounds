//
//  JsonFileTests.swift
//  SwiftUIPlayground
//
//  Created by MacAir on 18/10/2568 BE.
//

import Foundation
import Testing


// MARK: - Test Suite

@Suite("JsonFile Tests")
struct JsonFileTests {

	let JsonFileRoot: JsonFile
	let JsonFileNested: JsonFile
	let JsonFileFlat: JsonFile // For root-level access with flattened structure

	init() {
		JsonFileRoot = JsonFile(path: "Jsons")
		JsonFileNested = JsonFile(path: "Jsons/Nest")
		JsonFileFlat = JsonFile() // Uses convenience init for root-level files
	}

	// MARK: - Fallback Mechanism Tests

	@Test("JsonFile works with flattened structure using path")
	func testFlattenedStructureWithPath() throws {
		// Given - Files are actually flattened in bundle but we use paths
		let JsonFileRoot = JsonFile(path: "Jsons")
		let JsonFileNested = JsonFile(path: "Jsons/Nest")

		// When - Decode with fallback mechanism
		let person = JsonFileRoot.decode(from: "SingleObject", as: Person.self)
		let nested = JsonFileNested.decode(from: "NestSingleObject", as: Person.self)

		// Then - Should work due to fallback to flattened structure
		let unwrappedPerson = try #require(person)
		#expect(unwrappedPerson.id == 1)
		#expect(unwrappedPerson.name == "John Doe")

		let unwrappedNested = try #require(nested)
		#expect(unwrappedNested.id == 2)
		#expect(unwrappedNested.name == "Hana Khunlay")
	}

	@Test("JsonFile root-level access with convenience init")
	func testRootLevelAccess() throws {
		// Given - Using convenience initializer for root-level files
		let JsonFile = JsonFile()

		// When - Access all flattened files from root
		let content = JsonFile.decode(from: "SingleObject", as: Person.self)
		let nestContent = JsonFile.decode(from: "NestSingleObject", as: Person.self)
		let rootContent = JsonFile.decode(from: "root_content", as: Person.self)

		// Then - All should be accessible
		let unwrappedContent = try #require(content)
		#expect(unwrappedContent.id == 1)
		#expect(unwrappedContent.name == "John Doe")

		let unwrappedNest = try #require(nestContent)
		#expect(unwrappedNest.id == 2)
		#expect(unwrappedNest.name == "Hana Khunlay")

		let unwrappedRoot = try #require(rootContent)
		#expect(unwrappedRoot.id == 1)
		#expect(unwrappedRoot.name == "John Doe")
	}

	@Test("Print all available paths and files in test bundle")
	func printAllPathsAndFilesInTestBundle() throws {
		final class BundleHelper: AnyObject {}
		let bundle = Bundle(for: BundleHelper.self)

		guard let resourcePath = bundle.resourcePath else {
			print("No resource path found in test bundle")
			Issue.record("No resource path in bundle")
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
		#expect(true) // dummy to register as a valid test
	}

	@Test("loading root_content file")
	func testOnLoadingRootContentFile() throws {
		// 1. Access the test bundle
		final class Helpper: AnyObject {}
		let bundle = Bundle(for: Helpper.self)

		// 2. Locate the JSON file within the bundle
		guard let url = bundle.url(forResource: "root_content", withExtension: "json") else {
			Issue.record("Could not find 'testData.json' in the test bundle.")
			return
		}

		// 3. Read the JSON data
		let data = try Data(contentsOf: url)

		// 4. Decode the JSON data into your struct
		let decoder = JSONDecoder()
		let decodedData = try decoder.decode(Person.self, from: data)

		// 5. Assert the decoded data
		#expect(decodedData.name == "John Doe")
		#expect(decodedData.id == 1)
	}

	@Test("loading content file")
	func testOnLoadingJsonsContentFile() throws {
		// 1. Access the test bundle
		final class Helpper: AnyObject {}
		let bundle = Bundle(for: Helpper.self)

		// 2. Locate the JSON file within the bundle
		guard let url = bundle.url(forResource: "SingleObject", withExtension: "json") else {
			Issue.record("Could not find 'SingleObject.json' in the test bundle.")
			return
		}

		// 3. Read the JSON data
		let data = try Data(contentsOf: url)

		// 4. Decode the JSON data into your struct
		let decoder = JSONDecoder()
		let decodedData = try decoder.decode(Person.self, from: data)

		// 5. Assert the decoded data
		#expect(decodedData.name == "John Doe")
		#expect(decodedData.id == 1)
	}

	@Test("loading nest_content file")
	func testOnLoadingJsonsNestContentFile() throws {
		// 1. Access the test bundle
		final class Helpper: AnyObject {}
		let bundle = Bundle(for: Helpper.self)

		// 2. Locate the JSON file within the bundle
		guard let url = bundle.url(forResource: "NestSingleObject", withExtension: "json") else {			
			Issue.record("Could not find 'NestSingleObject.json' in the test bundle.")
			return
		}

		// 3. Read the JSON data
		let data = try Data(contentsOf: url)

		// 4. Decode the JSON data into your struct
		let decoder = JSONDecoder()
		let decodedData = try decoder.decode(Person.self, from: data)

		// 5. Assert the decoded data
		#expect(decodedData.name == "Hana Khunlay")
		#expect(decodedData.id == 2)
	}
	// MARK: - Root Content Tests

	@Test("Load root_content.json using root-level JsonFile")
	func loadRootContentFile() throws {
		// Given
		let JsonFile = JsonFile() // Root-level access

		// When
		let person = JsonFile.decode(from: "root_content", as: Person.self)

		// Then
		let unwrappedPerson = try #require(person, "root_content should be loaded")
		#expect(unwrappedPerson.id == 1)
		#expect(unwrappedPerson.name == "John Doe")
	}

	@Test("Load root_content.json using JsonFileFlat instance")
	func loadRootContentUsingFlatInstance() throws {
		// Given - Using the JsonFileFlat instance from init

		// When
		let person = JsonFileFlat.decode(from: "root_content", as: Person.self)

		// Then
		let unwrappedPerson = try #require(person, "root_content should be loaded via flat instance")
		#expect(unwrappedPerson.id == 1)
		#expect(unwrappedPerson.name == "John Doe")
	}

	// MARK: - Data Loading Tests (Optional Version)

	@Test("Load data from file successfully")
	func dataFromFileSuccess() {
		// Given
		let fileName = "SingleObject"

		// When
		let data = JsonFileRoot.data(from: fileName)

		// Then
		#expect(data != nil, "Data should be loaded successfully")
		#expect(!data!.isEmpty, "Data should not be empty")
	}

	@Test("Data loading returns nil for non-existent file")
	func dataFromFileNotFound() {
		// Given
		let fileName = "nonexistent"

		// When
		let data = JsonFileRoot.data(from: fileName)

		// Then
		#expect(data == nil, "Data should be nil for non-existent file")
	}

	@Test("Load data from nested directory successfully")
	func dataFromNestedFileSuccess() {
		// Given
		let fileName = "NestSingleObject"

		// When
		let data = JsonFileNested.data(from: fileName)

		// Then
		#expect(data != nil, "Data should be loaded from nested path")
		#expect(!data!.isEmpty, "Data should not be empty")
	}

	// MARK: - Data Loading Tests (Throwing Version)

	@Test("Load data with throwing version successfully")
	func dataThrowingVersionSuccess() throws {
		// Given
		let fileName = "SingleObject"

		// When
		let data = try JsonFileRoot.data(fileName: fileName)

		// Then
		#expect(!data.isEmpty, "Data should not be empty")
	}

	@Test("Throwing version throws error for non-existent file")
	func dataThrowingVersionFileNotFound() {
		// Given
		let fileName = "nonexistent"

		// Then
		#expect(throws: JsonFileError.self) {
			try JsonFileRoot.data(fileName: fileName)
		}
	}

	// MARK: - Decode Tests (Optional Version)

	@Test("Decode JSON file to model successfully")
	func decodeFromFileSuccess() throws {
		// Given
		let fileName = "SingleObject"

		// When
		let person = JsonFileRoot.decode(from: fileName, as: Person.self)

		// Then
		let unwrappedPerson = try #require(person, "Person should be decoded successfully")
		#expect(unwrappedPerson.id == 1)
		#expect(unwrappedPerson.name == "John Doe")
	}

	@Test("Type inference works when decoding")
	func decodeFromFileTypeInference() throws {
		// Given
		let fileName = "SingleObject"

		// When
		let person: Person? = JsonFileRoot.decode(from: fileName)

		// Then
		let unwrappedPerson = try #require(person, "Type inference should work")
		#expect(unwrappedPerson.id == 1)
		#expect(unwrappedPerson.name == "John Doe")
	}

	@Test("Decode from nested file successfully")
	func decodeFromNestedFileSuccess() throws {
		// Given
		let fileName = "NestSingleObject"

		// When - nest_content.json has Int id, not String id
		let person = JsonFileNested.decode(from: fileName, as: Person.self)

		// Then
		let unwrappedPerson = try #require(person, "Person should be decoded from nested path")
		#expect(unwrappedPerson.id == 2)
		#expect(unwrappedPerson.name == "Hana Khunlay")
	}

	@Test("Decoding with wrong type returns nil")
	func decodeFromFileWrongType() {
		// Given
		let fileName = "SingleObject"

		// When - Attempting to decode with incompatible struct (different fields)
		let invalidModel = JsonFileRoot.decode(from: fileName, as: InvalidModel.self)

		// Then
		#expect(invalidModel == nil, "Decoding should fail with incompatible type")
	}

	@Test("Decoding non-existent file returns nil")
	func decodeFromFileNotFound() {
		// Given
		let fileName = "nonexistent"

		// When
		let person = JsonFileRoot.decode(from: fileName, as: Person.self)

		// Then
		#expect(person == nil, "Should return nil for non-existent file")
	}

	// MARK: - Decode Tests (Throwing Version)

	@Test("Decode with throwing version successfully")
	func decodeThrowingVersionSuccess() throws {
		// Given
		let fileName = "SingleObject"

		// When
		let person = try JsonFileRoot.decode(fileName: fileName, as: Person.self)

		// Then
		#expect(person.id == 1)
		#expect(person.name == "John Doe")
	}

	@Test("Throwing decode throws error for non-existent file")
	func decodeThrowingVersionFileNotFound() {
		// Given
		let fileName = "nonexistent"

		// Then
		#expect(throws: JsonFileError.self) {
			try JsonFileRoot.decode(fileName: fileName, as: Person.self)
		}
	}

	@Test("Throwing decode throws error when decoding fails")
	func decodeThrowingVersionDecodingFailed() {
		// Given
		let fileName = "SingleObject"

		// Then
		#expect(throws: JsonFileError.self) {
			try JsonFileRoot.decode(fileName: fileName, as: InvalidModel.self)
		}
	}

	// MARK: - JSON String Tests

	@Test("Convert JSON file to string successfully")
	func jsonStringSuccess() throws {
		// Given
		let fileName = "SingleObject"

		// When
		let jsonString = JsonFileRoot.jsonString(from: fileName)

		// Then
		let unwrappedString = try #require(jsonString, "JSON string should be returned")
		#expect(unwrappedString.contains("John Doe"))
		#expect(unwrappedString.contains("id"))
	}

	@Test("Convert JSON to pretty printed string")
	func jsonStringPrettyPrinted() throws {
		// Given
		let fileName = "SingleObject"

		// When
		let jsonString = JsonFileRoot.jsonString(from: fileName, prettyPrinted: true)

		// Then
		let unwrappedString = try #require(jsonString, "Pretty printed JSON string should be returned")
		#expect(unwrappedString.contains("John Doe"))
		#expect(unwrappedString.contains("\n"), "Pretty printed should have newlines")
	}

	@Test("JSON string returns nil for non-existent file")
	func jsonStringFileNotFound() {
		// Given
		let fileName = "nonexistent"

		// When
		let jsonString = JsonFileRoot.jsonString(from: fileName)

		// Then
		#expect(jsonString == nil, "Should return nil for non-existent file")
	}

	@Test("Get JSON string from nested file")
	func jsonStringFromNestedFile() throws {
		// Given
		let fileName = "NestSingleObject"

		// When
		let jsonString = JsonFileNested.jsonString(from: fileName)

		// Then
		let unwrappedString = try #require(jsonString, "JSON string should be returned from nested path")
		#expect(unwrappedString.contains("Hana Khunlay"))
	}

	// MARK: - Custom Decoder Tests

	@Test("Use custom JSONDecoder configuration")
	func customDecoder() throws {
		// Given
		let customDecoder = JSONDecoder()
		customDecoder.keyDecodingStrategy = .convertFromSnakeCase
		let JsonFile = JsonFile(path: "Jsons", decoder: customDecoder)

		// When
		let person = JsonFile.decode(from: "SingleObject", as: Person.self)

		// Then
		let unwrappedPerson = try #require(person, "Should work with custom decoder")
		#expect(unwrappedPerson.id == 1)
	}

	// MARK: - Static Helper Tests

	@Test("Static decode from Data")
	func staticDecodeFromData() throws {
		// Given
		let jsonString = """
			{"id": 3, "name": "Test User"}
			"""
		let data = try #require(jsonString.data(using: .utf8))

		// When
		let person = try JsonFile.decode(data, as: Person.self)

		// Then
		#expect(person.id == 3)
		#expect(person.name == "Test User")
	}

	@Test("Static decode from String")
	func staticDecodeFromString() throws {
		// Given
		let jsonString = """
			{"id": 4, "name": "String User"}
			"""

		// When
		let person = try JsonFile.decode(from: jsonString, as: Person.self)

		// Then
		#expect(person.id == 4)
		#expect(person.name == "String User")
	}

	@Test("Static decode array from Data")
	func staticDecodeArrayFromData() throws {
		// Given
		let jsonString = """
			[{"id": 1, "name": "User 1"}, {"id": 2, "name": "User 2"}]
			"""
		let data = try #require(jsonString.data(using: .utf8))

		// When
		let people = try JsonFile.decodeArray(data, as: Person.self)

		// Then
		#expect(people.count == 2)
		#expect(people[0].id == 1)
		#expect(people[1].name == "User 2")
	}

	@Test("Static decode array from String")
	func staticDecodeArrayFromString() throws {
		// Given
		let jsonString = """
			[{"id": 5, "name": "Array User 1"}, {"id": 6, "name": "Array User 2"}]
			"""

		// When
		let people = try JsonFile.decodeArray(from: jsonString, as: Person.self)

		// Then
		#expect(people.count == 2)
		#expect(people[0].id == 5)
		#expect(people[1].id == 6)
	}

	// MARK: - Error Description Tests

	@Test("Error description for file not found")
	func errorDescriptionFileNotFound() throws {
		// Given
		let error = JsonFileError.fileNotFound(path: "test/path.json")

		// When
		let description = error.errorDescription

		// Then
		let unwrappedDescription = try #require(description)
		#expect(unwrappedDescription.contains("test/path.json"))
	}

	@Test("Error description for decoding failed")
	func errorDescriptionDecodingFailed() throws {
		// Given
		let underlyingError = NSError(domain: "TestError", code: 1)
		let error = JsonFileError.decodingFailed(type: "InvalidModel", error: underlyingError)

		// When
		let description = error.errorDescription

		// Then
		let unwrappedDescription = try #require(description)
		#expect(unwrappedDescription.contains("InvalidModel"))
	}

	// MARK: - Integration Tests

	@Test("Full workflow: load, decode, and verify")
	func fullWorkflowLoadDecodeVerify() throws {
		// Given
		let fileName = "SingleObject"

		// When - Load data
		let data = try JsonFileRoot.data(fileName: fileName)

		// Then - Verify data is not empty
		#expect(!data.isEmpty)

		// When - Decode data
		let person = try JsonFileRoot.decode(fileName: fileName, as: Person.self)

		// Then - Verify decoded data
		#expect(person.id == 1)
		#expect(person.name == "John Doe")

		// When - Get as string
		let jsonString = JsonFileRoot.jsonString(from: fileName)

		// Then - Verify string contains expected data
		let unwrappedString = try #require(jsonString)
		#expect(unwrappedString.contains("John Doe"))
	}

	@Test("Load and decode from multiple paths")
	func multipleFilesInDifferentPaths() throws {
		// When - Load from root path
		let rootPerson = JsonFileRoot.decode(from: "SingleObject", as: Person.self)

		// Then
		let unwrappedRootPerson = try #require(rootPerson)
		#expect(unwrappedRootPerson.id == 1)
		#expect(unwrappedRootPerson.name == "John Doe")

		// When - Load from nested path
		let nestedPerson = JsonFileNested.decode(from: "NestSingleObject", as: Person.self)

		// Then
		let unwrappedNestedPerson = try #require(nestedPerson)
		#expect(unwrappedNestedPerson.id == 2)
		#expect(unwrappedNestedPerson.name == "Hana Khunlay")
	}

	// MARK: - Flattened Structure Tests

	@Test("Access all JSON files from root level with flat instance")
	func accessAllFilesFromRootLevel() throws {
		// Given - All files are accessible from root due to flattened structure

		// When - Load all three JSON files using JsonFileFlat
		let content = JsonFileFlat.decode(from: "SingleObject", as: Person.self)
		let nestContent = JsonFileFlat.decode(from: "NestSingleObject", as: Person.self)
		let rootContent = JsonFileFlat.decode(from: "root_content", as: Person.self)

		// Then - All should be successfully decoded
		#expect(content != nil, "SingleObject.json should be accessible")
		#expect(nestContent != nil, "NestSingleObject.json should be accessible")
		#expect(rootContent != nil, "root_content.json should be accessible")

		#expect(content?.id == 1)
		#expect(nestContent?.id == 2)
		#expect(rootContent?.id == 1)
	}

	@Test("Throwing version loads all files from root level")
	func throwingVersionLoadsAllFiles() throws {
		// Given
		let JsonFile = JsonFile()

		// When & Then - All files should load without throwing
		let content = try JsonFile.decode(fileName: "SingleObject", as: Person.self)
		#expect(content.id == 1)
		#expect(content.name == "John Doe")

		let nestContent = try JsonFile.decode(fileName: "NestSingleObject", as: Person.self)
		#expect(nestContent.id == 2)
		#expect(nestContent.name == "Hana Khunlay")

		let rootContent = try JsonFile.decode(fileName: "root_content", as: Person.self)
		#expect(rootContent.id == 1)
		#expect(rootContent.name == "John Doe")
	}

	@Test("Data loading from root level for all files")
	func dataLoadingFromRootLevel() throws {
		// Given
		let JsonFile = JsonFile()

		// When - Load raw data for all files
		let contentData = try JsonFile.data(fileName: "SingleObject")
		let nestData = try JsonFile.data(fileName: "NestSingleObject")
		let rootData = try JsonFile.data(fileName: "root_content")

		// Then - All data should be loaded
		#expect(!contentData.isEmpty, "SingleObject.json data should not be empty")
		#expect(!nestData.isEmpty, "NestSingleObject.json data should not be empty")
		#expect(!rootData.isEmpty, "root_content.json data should not be empty")

		// Verify data can be decoded
		let decoder = JSONDecoder()
		let contentPerson = try decoder.decode(Person.self, from: contentData)
		let nestPerson = try decoder.decode(Person.self, from: nestData)
		let rootPerson = try decoder.decode(Person.self, from: rootData)

		#expect(contentPerson.id == 1)
		#expect(nestPerson.id == 2)
		#expect(rootPerson.id == 1)
	}

	@Test("JSON string from all files using flat structure")
	func jsonStringFromAllFiles() throws {
		// Given
		let JsonFile = JsonFile()

		// When
		let contentString = JsonFile.jsonString(from: "SingleObject")
		let nestString = JsonFile.jsonString(from: "NestSingleObject")
		let rootString = JsonFile.jsonString(from: "root_content")

		// Then
		let unwrappedContent = try #require(contentString)
		#expect(unwrappedContent.contains("John Doe"))
		#expect(unwrappedContent.contains("\"id\""))

		let unwrappedNest = try #require(nestString)
		#expect(unwrappedNest.contains("Hana Khunlay"))

		let unwrappedRoot = try #require(rootString)
		#expect(unwrappedRoot.contains("John Doe"))
	}

	// MARK: - Comparison Tests

	@Test("Same file accessible via different JsonFile instances")
	func sameFileAccessibleViaDifferentInstances() throws {
		// Given - content.json should be accessible via JsonFileRoot and JsonFileFlat

		// When
		let viaRoot = JsonFileRoot.decode(from: "SingleObject", as: Person.self)
		let viaFlat = JsonFileFlat.decode(from: "SingleObject", as: Person.self)

		// Then - Both should return the same data
		let unwrappedRoot = try #require(viaRoot, "Should load via JsonFileRoot")
		let unwrappedFlat = try #require(viaFlat, "Should load via JsonFileFlat")

		#expect(unwrappedRoot == unwrappedFlat, "Should be equal regardless of path")
		#expect(unwrappedRoot.id == 1)
		#expect(unwrappedFlat.id == 1)
	}

	@Test("Fallback mechanism works for files with path prefix")
	func fallbackMechanismWorksWithPathPrefix() throws {
		// Given - JsonFile with path prefix that doesn't exist in flattened structure
		let jsonFileWithPath = JsonFile(path: "Jsons")
		let jsonFileNoPath = JsonFile()

		// When - Access the same file both ways
		let withPath = jsonFileWithPath.decode(from: "SingleObject", as: Person.self)
		let withoutPath = jsonFileNoPath.decode(from: "SingleObject", as: Person.self)

		// Then - Both should succeed due to fallback
		#expect(withPath != nil, "Should work with path due to fallback")
		#expect(withoutPath != nil, "Should work without path")

		let unwrappedWithPath = try #require(withPath)
		let unwrappedWithoutPath = try #require(withoutPath)
		#expect(unwrappedWithPath == unwrappedWithoutPath, "Should load the same file")
	}

	// MARK: - Array Decoding Tests (Optional Version)

	@Test("Decode array from JSON file successfully")
	func decodeArrayFromFileSuccess() throws {
		// Given
		let fileName = "ArrayObject"

		// When
		let users = JsonFileRoot.decodeArray(from: fileName, as: Person.self)

		// Then
		let unwrappedUsers = try #require(users, "Users array should be decoded successfully")
		#expect(unwrappedUsers.count == 3, "Should have 3 users")
		#expect(unwrappedUsers[0].id == 1)
		#expect(unwrappedUsers[0].name == "Alice Johnson")
		#expect(unwrappedUsers[1].id == 2)
		#expect(unwrappedUsers[1].name == "Bob Smith")
		#expect(unwrappedUsers[2].id == 3)
		#expect(unwrappedUsers[2].name == "Charlie Brown")
	}

	@Test("Decode array from nested directory")
	func decodeArrayFromNestedDirectory() throws {
		// Given
		let fileName = "NestArrayObject"

		// When
		let team = JsonFileNested.decodeArray(from: fileName, as: Person.self)

		// Then
		let unwrappedTeam = try #require(team, "Team array should be decoded from nested path")
		#expect(unwrappedTeam.count == 4, "Should have 4 team members")
		#expect(unwrappedTeam[0].id == 10)
		#expect(unwrappedTeam[0].name == "David Lee")
		#expect(unwrappedTeam[3].id == 40)
		#expect(unwrappedTeam[3].name == "Grace Kim")
	}

	@Test("Decode empty array from JSON file")
	func decodeEmptyArrayFromFile() throws {
		// Given
		let fileName = "EmptyArrayObject"

		// When
		let emptyArray = JsonFileRoot.decodeArray(from: fileName, as: Person.self)

		// Then
		let unwrappedArray = try #require(emptyArray, "Empty array should be decoded")
		#expect(unwrappedArray.isEmpty, "Array should be empty")
		#expect(unwrappedArray.count == 0, "Count should be 0")
	}

	@Test("Array decoding returns nil for non-existent file")
	func decodeArrayFromNonExistentFile() {
		// Given
		let fileName = "nonexistent_array"

		// When
		let array = JsonFileRoot.decodeArray(from: fileName, as: Person.self)

		// Then
		#expect(array == nil, "Should return nil for non-existent file")
	}

	@Test("Array decoding returns nil for wrong type")
	func decodeArrayWithWrongType() {
		// Given
		let fileName = "ArrayObject"

		// When - Try to decode with incompatible struct
		let wrongArray = JsonFileRoot.decodeArray(from: fileName, as: InvalidModel.self)

		// Then
		#expect(wrongArray == nil, "Should return nil when array element types don't match")
	}

	// MARK: - Array Decoding Tests (Throwing Version)

	@Test("Decode array with throwing version successfully")
	func decodeArrayThrowingVersionSuccess() throws {
		// Given
		let fileName = "ArrayObject"

		// When
		let users = try JsonFileRoot.decodeArray(fileName: fileName, as: Person.self)

		// Then
		#expect(users.count == 3)
		#expect(users[0].name == "Alice Johnson")
		#expect(users[1].name == "Bob Smith")
		#expect(users[2].name == "Charlie Brown")
	}

	@Test("Throwing array decode throws error for non-existent file")
	func decodeArrayThrowingVersionFileNotFound() {
		// Given
		let fileName = "nonexistent_array"

		// Then
		#expect(throws: JsonFileError.self) {
			try JsonFileRoot.decodeArray(fileName: fileName, as: Person.self)
		}
	}

	@Test("Throwing array decode throws error for wrong type")
	func decodeArrayThrowingVersionWrongType() {
		// Given
		let fileName = "ArrayObject"

		// Then
		#expect(throws: JsonFileError.self) {
			try JsonFileRoot.decodeArray(fileName: fileName, as: InvalidModel.self)
		}
	}

	@Test("Decode array from root level using flat instance")
	func decodeArrayFromRootLevel() throws {
		// Given - Using root-level JsonFile
		let JsonFile = JsonFile()

		// When
		let users = JsonFile.decodeArray(from: "ArrayObject", as: Person.self)
		let team = JsonFile.decodeArray(from: "NestArrayObject", as: Person.self)

		// Then
		let unwrappedUsers = try #require(users, "Users should be accessible from root")
		#expect(unwrappedUsers.count == 3)

		let unwrappedTeam = try #require(team, "Team should be accessible from root")
		#expect(unwrappedTeam.count == 4)
	}

	// MARK: - Array Filter and Transform Tests

	@Test("Filter array elements after decoding")
	func filterArrayAfterDecoding() throws {
		// Given
		let fileName = "ArrayObject"

		// When
		let users = try JsonFileRoot.decodeArray(fileName: fileName, as: Person.self)
		
		// Filter users with id >= 2
		let filteredUsers = users.filter { $0.id >= 2 }

		// Then
		#expect(filteredUsers.count == 2)
		#expect(filteredUsers[0].id == 2)
		#expect(filteredUsers[1].id == 3)
	}

	@Test("Map array elements after decoding")
	func mapArrayAfterDecoding() throws {
		// Given
		let fileName = "ArrayObject"

		// When
		let users = try JsonFileRoot.decodeArray(fileName: fileName, as: Person.self)
		let names = users.map { $0.name }
		let ids = users.map { $0.id }

		// Then
		#expect(names.count == 3)
		#expect(names == ["Alice Johnson", "Bob Smith", "Charlie Brown"])
		#expect(ids == [1, 2, 3])
	}

	@Test("Find specific element in decoded array")
	func findElementInDecodedArray() throws {
		// Given
		let fileName = "NestArrayObject"

		// When
		let team = try JsonFileNested.decodeArray(fileName: fileName, as: Person.self)
		let emma = team.first { $0.name == "Emma Watson" }

		// Then
		let unwrappedEmma = try #require(emma, "Should find Emma Watson")
		#expect(unwrappedEmma.id == 20)
		#expect(unwrappedEmma.name == "Emma Watson")
	}

	@Test("Sort decoded array")
	func sortDecodedArray() throws {
		// Given
		let fileName = "NestArrayObject"

		// When
		let team = try JsonFileNested.decodeArray(fileName: fileName, as: Person.self)
		let sortedByName = team.sorted { $0.name < $1.name }
		let sortedById = team.sorted { $0.id < $1.id }

		// Then
		#expect(sortedByName.first?.name == "David Lee")
		#expect(sortedByName.last?.name == "Grace Kim")
		#expect(sortedById.first?.id == 10)
		#expect(sortedById.last?.id == 40)
	}

	// MARK: - Array Integration Tests

	@Test("Load multiple array files and combine")
	func loadMultipleArrayFilesAndCombine() throws {
		// Given
		let usersFile = "ArrayObject"
		let teamFile = "NestArrayObject"

		// When
		let users = try JsonFileRoot.decodeArray(fileName: usersFile, as: Person.self)
		let team = try JsonFileNested.decodeArray(fileName: teamFile, as: Person.self)
		let combined = users + team

		// Then
		#expect(users.count == 3)
		#expect(team.count == 4)
		#expect(combined.count == 7, "Combined array should have 7 elements")
		
		// Verify first element from users
		#expect(combined[0].name == "Alice Johnson")
		
		// Verify first element from team
		#expect(combined[3].name == "David Lee")
	}

	@Test("Decode array and verify all elements")
	func decodeArrayAndVerifyAllElements() throws {
		// Given
		let fileName = "ArrayObject"

		// When
		let users = try JsonFileRoot.decodeArray(fileName: fileName, as: Person.self)

		// Then - Verify each element
		#expect(users.count == 3)
		
		for (index, user) in users.enumerated() {
			#expect(user.id == index + 1, "ID should match index + 1")
			#expect(!user.name.isEmpty, "Name should not be empty")
		}
	}

	@Test("Empty array vs single object distinction")
	func emptyArrayVsSingleObject() throws {
		// Given
		let emptyArrayFile = "EmptyArrayObject"
		let singleObjectFile = "SingleObject"

		// When
		let emptyArray = JsonFileRoot.decodeArray(from: emptyArrayFile, as: Person.self)
		let singleObjectAsArray = JsonFileRoot.decodeArray(from: singleObjectFile, as: Person.self)

		// Then
		let unwrappedEmpty = try #require(emptyArray, "Empty array should decode")
		#expect(unwrappedEmpty.isEmpty, "Should be empty array")
		
		#expect(singleObjectAsArray == nil, "Single object should not decode as array")
	}
}

extension JsonFileTests {
	struct Person: Decodable, Equatable {
		let id: Int
		let name: String
	}

	struct InvalidModel: Decodable {
		let id: Int
		let age: Int
	}
}
