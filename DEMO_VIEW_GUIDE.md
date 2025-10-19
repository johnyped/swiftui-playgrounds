# 🎨 DemoReadJsonView - Complete Guide

## 📋 Overview

A beautiful, production-ready SwiftUI demo view that demonstrates how to read and display JSON files using the `JsonFile` utility class.

### Features:
✅ **Modern SwiftUI Design** - Beautiful UI with glassmorphism effects  
✅ **MVVM Architecture** - Clean separation of concerns  
✅ **JsonFile Integration** - Full demonstration of the utility class  
✅ **Interactive Loading** - Load files individually or all at once  
✅ **Error Handling** - Visual feedback for loading states  
✅ **Debug Info** - Collapsible debug section  
✅ **Cross-platform** - Works on iOS, iPadOS, and macOS  

---

## 🏗️ Architecture

### **Models**

#### `Person`
```swift
struct Person: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
}
```
- Main data model matching JSON structure
- `Identifiable` for SwiftUI lists
- `Codable` for JSON decoding
- `Equatable` for comparisons

#### `JsonFileInfo`
```swift
struct JsonFileInfo: Identifiable {
    let id = UUID()
    let fileName: String
    let path: String
    let description: String
    var person: Person?
    var error: String?
    
    var fullPath: String { ... }
}
```
- Wrapper for file metadata and loaded data
- Tracks loading state and errors

### **View Model**

```swift
@Observable
class DemoReadJsonViewModel {
    var jsonFiles: [JsonFileInfo]
    var isLoading: Bool
    var showDebugInfo: Bool
    
    func loadAllFiles()
    func loadFile(at index: Int)
    func getJsonString(at index: Int) -> String?
}
```

**Key Methods:**
- `loadAllFiles()` - Loads all JSON files at once
- `loadFile(at:)` - Loads individual file
- `getJsonString(at:)` - Gets pretty-printed JSON string

### **Views**

1. **DemoReadJsonView** - Main container view
2. **JsonFileCard** - Reusable card component for each file
3. **Sections:**
   - Header Section - Title and "Load All" button
   - Loading Section - Progress indicator
   - Files Section - List of JSON file cards
   - Debug Section - Collapsible debug information

---

## 📁 JSON Files

The demo loads two JSON files from the `Jsons/` folder:

### 1. `Jsons/content.json`
```json
{
    "id": 9,
    "name": "Hwang Bo"
}
```
- **Path:** `Jsons`
- **File:** `content`

### 2. `Jsons/Nest/nest_content.json`
```json
{
    "id": 4,
    "name": "Oppa Gwanghae"
}
```
- **Path:** `Jsons/Nest`
- **File:** `nest_content`

---

## 🎯 How It Works

### **Loading Process:**

1. **User taps "Load All Files" or individual "Load" button**
2. **View Model creates JsonFile instance with path:**
   ```swift
   let jsonFile = JsonFile(path: "Jsons")
   ```
3. **JsonFile decodes the file:**
   ```swift
   let person = jsonFile.decode(from: "content", as: Person.self)
   ```
4. **Smart Fallback Mechanism:**
   - Tries: `Jsons/content.json`
   - Tries: subdirectory parameter
   - Falls back to: `content.json` (flattened)
5. **UI updates with loaded data**

### **View JSON Feature:**

Tapping "View JSON" prints the pretty-printed JSON to console:
```swift
func getJsonString(at index: Int) -> String? {
    let jsonFile = JsonFile(path: fileInfo.path)
    return jsonFile.jsonString(from: fileInfo.fileName, prettyPrinted: true)
}
```

---

## 🎨 UI Components

### **Header Section**
- Large document icon with gradient
- Title and subtitle
- "Load All Files" button with gradient background

### **JSON File Card**
Each card displays:
- 📄 **File name** - e.g., "content.json"
- 📁 **Full path** - e.g., "Jsons/content"
- ✅ **Status badge** - Loaded (green), Error (red), Not loaded (gray)
- 📊 **Content display:**
  - Success: Shows ID and Name in styled boxes
  - Error: Shows error message
  - Empty: Shows placeholder text
- 🔘 **Action buttons:**
  - "Load" - Loads the file
  - "View JSON" - Prints JSON to console

### **Debug Section**
Collapsible section showing:
- Files loaded count
- Status for each file
- Full path for each file
- Helpful tips about JsonFile

---

## 🚀 Usage

### **Add to Navigation:**

```swift
NavigationLink {
    DemoReadJsonView()
} label: {
    Label("JSON Demo", systemImage: "doc.text.fill")
}
```

### **Standalone:**

```swift
struct ContentView: View {
    var body: some View {
        NavigationStack {
            DemoReadJsonView()
        }
    }
}
```

### **With Tab Bar:**

```swift
TabView {
    NavigationStack {
        DemoReadJsonView()
    }
    .tabItem {
        Label("JSON Demo", systemImage: "doc.text")
    }
}
```

---

## 📝 Code Examples

### **Example 1: Load All Files**
```swift
// In ViewModel
func loadAllFiles() {
    isLoading = true
    
    for index in jsonFiles.indices {
        let fileInfo = jsonFiles[index]
        let jsonFile = JsonFile(path: fileInfo.path)
        
        if let person = jsonFile.decode(from: fileInfo.fileName, as: Person.self) {
            jsonFiles[index].person = person
            jsonFiles[index].error = nil
        } else {
            jsonFiles[index].error = "Failed to load"
        }
    }
    
    isLoading = false
}
```

### **Example 2: Load Single File**
```swift
func loadFile(at index: Int) {
    let fileInfo = jsonFiles[index]
    let jsonFile = JsonFile(path: fileInfo.path)
    
    if let person = jsonFile.decode(from: fileInfo.fileName, as: Person.self) {
        jsonFiles[index].person = person
    }
}
```

### **Example 3: Get JSON String**
```swift
func getJsonString(at index: Int) -> String? {
    let fileInfo = jsonFiles[index]
    let jsonFile = JsonFile(path: fileInfo.path)
    
    return jsonFile.jsonString(from: fileInfo.fileName, prettyPrinted: true)
}
```

---

## 🎨 Customization

### **Add More Files:**

```swift
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
        ),
        // ✨ Add your own files here
        JsonFileInfo(
            fileName: "users",
            path: "Data",
            description: "User list from Data folder"
        )
    ]
}
```

### **Change Colors:**

```swift
// Change accent color
.foregroundStyle(.purple.gradient)  // Instead of .blue.gradient

// Change success color
.background(.mint.opacity(0.1))  // Instead of .green.opacity(0.1)
```

### **Add Custom Actions:**

```swift
Button(action: {
    // Your custom action
    exportToCSV(person)
}) {
    Label("Export", systemImage: "square.and.arrow.up")
}
```

---

## 🔍 Debug Tips

### **Print Bundle Contents:**

Add this to view model:
```swift
func printBundleInfo() {
    FileHelper.printAllPathsAndFilesInTestBundle()
}
```

### **Verify File Loading:**

Add logging to `loadFile`:
```swift
if let person = jsonFile.decode(from: fileInfo.fileName, as: Person.self) {
    print("✅ Loaded \(fileInfo.fileName): \(person)")
    jsonFiles[index].person = person
} else {
    print("❌ Failed to load \(fileInfo.fileName)")
    jsonFiles[index].error = "Failed to load"
}
```

### **Check JSON Content:**

```swift
if let jsonString = jsonFile.jsonString(from: "content") {
    print("📄 JSON:\n\(jsonString)")
}
```

---

## 📊 State Management

The view uses SwiftUI's `@Observable` macro for reactive state:

```swift
@Observable
class DemoReadJsonViewModel {
    var jsonFiles: [JsonFileInfo] = []  // ✅ Auto-tracked
    var isLoading = false                // ✅ Auto-tracked
    var showDebugInfo = false            // ✅ Auto-tracked
}
```

No need for `@Published` - SwiftUI automatically tracks changes!

---

## 🎯 Best Practices Demonstrated

1. ✅ **MVVM Architecture** - Separation of concerns
2. ✅ **Error Handling** - Graceful failure handling
3. ✅ **Loading States** - Visual feedback for async operations
4. ✅ **Reusable Components** - `JsonFileCard` is standalone
5. ✅ **Type Safety** - Using Codable and generics
6. ✅ **Modern SwiftUI** - Uses latest SwiftUI features
7. ✅ **Responsive Design** - Works on all screen sizes
8. ✅ **Clean Code** - Well-organized with MARK comments

---

## 🚦 Testing the View

### **Manual Testing:**

1. ✅ Tap "Load All Files" - Both files should load
2. ✅ Check status badges - Should be green checkmarks
3. ✅ Verify displayed data matches JSON files
4. ✅ Tap "View JSON" - Check console for output
5. ✅ Toggle "Debug Info" - Verify all files shown
6. ✅ Tap individual "Load" buttons - Each file loads independently

### **Expected Results:**

- **content.json**: ID: 9, Name: "Hwang Bo"
- **nest_content.json**: ID: 4, Name: "Oppa Gwanghae"

---

## 🔗 Integration with JsonFile

The demo showcases all main features of `JsonFile`:

| Feature | Usage in Demo |
|---------|---------------|
| **Path-based loading** | `JsonFile(path: "Jsons")` |
| **Optional decode** | `decode(from:as:)` |
| **Pretty printing** | `jsonString(from:prettyPrinted:)` |
| **Error handling** | Checks for `nil` returns |
| **Smart fallback** | Works with flattened bundles |

---

## 📱 Screenshots Description

### Main View:
- Large document icon at top
- "JSON File Reader Demo" title
- Blue gradient "Load All Files" button
- Two JSON file cards below
- Collapsible "Debug Info" at bottom

### JSON File Card:
- Document icon + filename
- Folder path badge
- Status indicator (checkmark/error/empty)
- Content area with ID and Name
- "Load" and "View JSON" buttons

### Loaded State:
- Green checkmark badge
- Green-tinted content box
- ID in large blue text
- Name in semibold text

---

## 🎉 Summary

This demo view is a complete, production-ready example of:
- ✅ Reading JSON files with `JsonFile` utility
- ✅ Modern SwiftUI design patterns
- ✅ MVVM architecture
- ✅ Error handling and loading states
- ✅ Interactive UI components
- ✅ Debug tools and logging

**Ready to use in your SwiftUI projects!** 🚀

---

## 📚 Related Files

- **JsonFile.swift** - The utility class
- **JsonFileTests.swift** - Comprehensive unit tests
- **content.json** - First demo JSON file
- **nest_content.json** - Second demo JSON file

---

**Enjoy building with SwiftUI and JsonFile! 🎨✨**

