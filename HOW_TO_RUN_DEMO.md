# 🚀 How to Run the JSON Demo

## Quick Start Guide

### Option 1: Add to Existing Navigation (Recommended)

If you have a main menu or scene selector, add this link:

```swift
NavigationLink {
    DemoReadJsonView()
} label: {
    Label("JSON File Demo", systemImage: "doc.text.fill")
}
```

### Option 2: Replace Root View (For Testing)

Update your app entry point temporarily:

```swift
// In SwiftUIPlaygroundApp.swift
@main
struct SwiftUIPlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DemoReadJsonView()  // ✨ Add this
            }
        }
    }
}
```

### Option 3: Add to Scene Group

If you're using the GroupScene pattern, add to your root scene:

```swift
// In iOSRootScene.swift or similar
List {
    NavigationLink("JSON File Demo") {
        DemoReadJsonView()
    }
    
    // ... other navigation links
}
```

---

## 📋 Checklist

Before running, make sure you have:

- ✅ `JsonFile.swift` in your main target (not just test target!)
- ✅ `DemoReadJsonView.swift` in your main target
- ✅ JSON files (`content.json`, `nest_content.json`) added to main target
- ✅ JSON files are in the correct folders:
  - `Jsons/content.json`
  - `Jsons/Nest/nest_content.json`

---

## 🔧 Setup Steps

### Step 1: Verify JsonFile.swift Location

1. Open Xcode
2. Find `JsonFile.swift` in Project Navigator
3. Check File Inspector (⌥⌘1)
4. **Ensure "SwiftUIPlayground" target is checked** ✅
5. If not, check the box

### Step 2: Verify JSON Files in Bundle

1. Find `content.json` and `nest_content.json`
2. Check File Inspector for each
3. **Ensure "SwiftUIPlayground" target is checked** ✅
4. Files should be in "Copy Bundle Resources" build phase

### Step 3: Verify Folder Structure

Your project should look like:
```
SwiftUIPlayground/
├── SwiftUIPlayground/
│   ├── Jsons/
│   │   ├── content.json           ✅
│   │   └── Nest/
│   │       └── nest_content.json  ✅
│   ├── Util/
│   │   └── JsonFile.swift         ✅
│   └── GroupScene/
│       └── Demo/
│           └── DemoReadJsonView.swift ✅
```

### Step 4: Add Navigation (Choose One)

#### A. Simple NavigationStack
```swift
@main
struct SwiftUIPlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DemoReadJsonView()
            }
        }
    }
}
```

#### B. With Menu
```swift
NavigationStack {
    List {
        NavigationLink("JSON Demo") {
            DemoReadJsonView()
        }
    }
    .navigationTitle("Demos")
}
```

#### C. With TabView
```swift
TabView {
    NavigationStack {
        DemoReadJsonView()
    }
    .tabItem {
        Label("JSON", systemImage: "doc.text")
    }
}
```

---

## ▶️ Run the App

1. **Select target**: SwiftUIPlayground (not Tests!)
2. **Select device**: iPhone 15 Pro / iPad / Mac (Designed for iPad)
3. **Press ⌘R** to run
4. **Navigate to** DemoReadJsonView if not root

---

## 🎯 What You Should See

### Initial State:
- Header with large document icon
- "JSON File Reader Demo" title
- Blue "Load All Files" button
- Two file cards:
  - `content.json` (Jsons/content)
  - `nest_content.json` (Jsons/Nest/nest_content)
- Status: Gray dashed circle (not loaded)
- Content: "Tap 'Load' to read file"

### After Loading:
- Status: Green checkmark ✅
- Content shows:
  - **File 1**: ID: 9, Name: "Hwang Bo"
  - **File 2**: ID: 4, Name: "Oppa Gwanghae"

---

## 🐛 Troubleshooting

### Issue: "File not found" Error

**Solution 1**: Check Target Membership
1. Select JSON file in Project Navigator
2. Open File Inspector (⌥⌘1)
3. Check "SwiftUIPlayground" target

**Solution 2**: Clean Build Folder
1. Product → Clean Build Folder (⇧⌘K)
2. Rebuild (⌘B)
3. Run again (⌘R)

**Solution 3**: Re-add Files
1. Remove reference to JSON files (don't delete)
2. Add files back to project
3. **Important**: Ensure "Copy items if needed" is checked
4. Check target membership

### Issue: "Cannot find 'JsonFile' in scope"

**Solution**: JsonFile.swift not in main target
1. Find `JsonFile.swift`
2. Check File Inspector
3. Enable "SwiftUIPlayground" target
4. Rebuild

### Issue: View Doesn't Appear

**Solution**: Check navigation setup
```swift
// Make sure you're in a NavigationStack
NavigationStack {
    DemoReadJsonView()  // ✅
}

// Not just:
DemoReadJsonView()  // ❌ Navigation won't work
```

### Issue: Cards Show Error Message

**Solution 1**: Verify JSON file content
```bash
# Check content.json exists
cat SwiftUIPlayground/SwiftUIPlayground/Jsons/content.json

# Should show:
{
    "id" : 9,
    "name" : "Hwang Bo"
}
```

**Solution 2**: Check JSON structure matches Person model
```swift
struct Person: Codable {
    let id: Int      // Must be Int, not String
    let name: String // Must be String
}
```

### Issue: Bundle Path Shows Flattened Structure

**This is OK!** The `JsonFile` class has smart fallback that handles both:
- ✅ Structured: `Jsons/content.json`
- ✅ Flattened: `content.json`

The fallback mechanism will find your files regardless.

---

## 🔍 Verify Installation

### Test 1: Print Bundle Contents
Add to your code temporarily:
```swift
Button("Print Bundle") {
    FileHelper.printAllPathsAndFilesInTestBundle()
}
```

Check console for:
```
📄 content.json
📄 nest_content.json
```

### Test 2: Manual File Check
```swift
Button("Test Load") {
    let jsonFile = JsonFile(path: "Jsons")
    if let person = jsonFile.decode(from: "content", as: Person.self) {
        print("✅ Loaded: \(person.name)")
    } else {
        print("❌ Failed to load")
    }
}
```

---

## 📱 Platform-Specific Notes

### iOS
- Works on iPhone and iPad
- Uses `.navigationBarTitleDisplayMode(.large)`
- Full scrolling support

### macOS
- Works on Mac (Designed for iPad)
- Uses standard navigation
- Sidebar navigation recommended

### iPadOS
- Optimized for larger screens
- Side-by-side navigation works great

---

## 🎨 Quick Customization

### Change Files Loaded:
```swift
// In DemoReadJsonViewModel.setupFiles()
jsonFiles = [
    JsonFileInfo(
        fileName: "your_file",
        path: "YourFolder",
        description: "Your description"
    )
]
```

### Change Colors:
```swift
// Find and replace:
.blue.gradient  → .purple.gradient
.green          → .mint
.orange         → .pink
```

### Change Title:
```swift
.navigationTitle("Your Title")
```

---

## ✅ Success Criteria

You'll know it's working when:
1. ✅ App launches without crashes
2. ✅ Demo view appears with header
3. ✅ "Load All Files" button is visible
4. ✅ Tapping button loads data
5. ✅ Green checkmarks appear
6. ✅ ID and Name are displayed correctly
7. ✅ "View JSON" prints to console
8. ✅ Debug info shows file status

---

## 📚 Next Steps

After getting it running:
1. ✅ Explore the code structure
2. ✅ Try adding your own JSON files
3. ✅ Customize the UI to match your app
4. ✅ Add error handling for your use case
5. ✅ Build upon this foundation

---

## 💡 Tips

- **Use Preview**: The view has `#Preview` - works in Canvas!
- **Console Output**: "View JSON" button prints to console
- **Debug Section**: Toggle to see file loading status
- **Reusable**: `JsonFileCard` can be used elsewhere

---

## 🎉 You're Ready!

The demo is production-ready and fully functional. Just:
1. ✅ Verify file locations
2. ✅ Check target memberships
3. ✅ Add navigation
4. ✅ Run and enjoy!

Happy coding! 🚀✨

