# JSON Test Files Organization

## Current Issue
When JSON files are added to Xcode as **Groups** (yellow folders), they get **flattened** into the bundle's root directory, losing their folder structure.

```
Expected:          Actually in Bundle:
Jsons/            ❌ No folders!
├── content.json  ✅ content.json
└── Nest/         ✅ nest_content.json
    └── nest_content.json  ✅ root_content.json
root_content.json
```

## Solution: Add as Folder References

### Option 1: Use Folder References (Blue Folders) - Recommended

1. **Remove existing JSON folders** from Xcode (don't delete, just remove reference)
2. **Right-click** on `SwiftUIPlaygroundTests` target in Project Navigator
3. Select **"Add Files to SwiftUIPlaygroundTests"**
4. Navigate to your `Jsons` folder
5. **IMPORTANT:** In the dialog, select **"Create folder references"** (NOT "Create groups")
   - This creates a **blue folder** icon (preserves structure)
   - NOT a yellow folder (which flattens files)
6. Ensure **"SwiftUIPlaygroundTests"** is checked in "Add to targets"
7. Click **Add**

### Option 2: Use JsonFile with Fallback (Current Implementation)

The `JsonFile` class now has **automatic fallback** that works with both:
- ✅ Folder references (preserves directories)
- ✅ Flattened structure (all files at root)

```swift
// Works with both flattened and structured bundles
let jsonFile = JsonFile(path: "Jsons")
let person = jsonFile.decode(from: "content", as: Person.self)

// For root level files
let jsonFileRoot = JsonFile(path: "")  // or JsonFile()
let person = jsonFileRoot.decode(from: "root_content", as: Person.self)
```

### Option 3: Direct Bundle Access

For complete control, use bundle methods directly:

```swift
final class BundleHelper: AnyObject {}
let bundle = Bundle(for: BundleHelper.self)

// With subdirectory
if let url = bundle.url(forResource: "content", 
                        withExtension: "json", 
                        subdirectory: "Jsons") {
    let data = try Data(contentsOf: url)
    let person = try JSONDecoder().decode(Person.self, from: data)
}

// Without subdirectory (flattened)
if let url = bundle.url(forResource: "content", withExtension: "json") {
    let data = try Data(contentsOf: url)
    let person = try JSONDecoder().decode(Person.self, from: data)
}
```

## How JsonFile Fallback Works

The updated `JsonFile` class tries **3 strategies** automatically:

1. **Full path**: `"Jsons/content.json"`
2. **Subdirectory param**: `subdirectory: "Jsons"`, `resource: "content.json"`
3. **Flattened**: `"content.json"` (works with current setup)

This means your tests will work regardless of how files are added to Xcode!

## Best Practices

### ✅ DO:
- Use **Folder References** (blue folders) for test resources
- Keep consistent naming conventions
- Document your file structure
- Use `JsonFile` class for consistent loading

### ❌ DON'T:
- Mix folder references and groups for the same resources
- Rely on specific bundle structure in tests
- Use hardcoded absolute paths

## Verifying Bundle Contents

Use this test to see what's actually in your bundle:

```swift
@Test("Print bundle contents")
func printBundleContents() throws {
    final class BundleHelper: AnyObject {}
    let bundle = Bundle(for: BundleHelper.self)
    
    guard let resourcePath = bundle.resourcePath else {
        throw CocoaError(.fileNoSuchFile)
    }
    
    let contents = try FileManager.default
        .contentsOfDirectory(atPath: resourcePath)
    
    print("📦 Bundle contents:")
    for item in contents.sorted() {
        print("   - \(item)")
    }
}
```

## Current Status

✅ **JsonFile class updated** with automatic fallback  
✅ **Works with flattened structure** (your current setup)  
⚠️ **Optional:** Add as folder references to preserve structure  

Your tests should now work! If you want to preserve folder structure for organizational purposes, follow **Option 1** above.

