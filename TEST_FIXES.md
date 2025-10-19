# 🔧 Test Fixes - Wrong Type Tests

## ❌ Problem

4 tests were failing because they were using the **correct type** instead of the **wrong type** to test error handling.

---

## 🐛 Failing Tests

1. **`decodeFromFileWrongType()`** (Line 334)
2. **`decodeThrowingVersionDecodingFailed()`** (Line 381)
3. **`decodeArrayWithWrongType()`** (Line 824)
4. **`decodeArrayThrowingVersionWrongType()`** (Line 861)

---

## 🔍 Root Cause

These tests were supposed to verify that decoding fails when using the wrong type, but they were actually using the **correct type**:

### **Before (Wrong):**
```swift
@Test("Decoding with wrong type returns nil")
func decodeFromFileWrongType() {
    let fileName = "content"
    
    // ❌ BUG: Using Person.self (CORRECT type)
    let person = jsonLoaderRoot.decode(from: fileName, as: Person.self)
    
    #expect(person == nil, "Decoding should fail with wrong type")
    // ❌ FAILS: Decoding succeeds because type is correct!
}
```

### **After (Fixed):**
```swift
@Test("Decoding with wrong type returns nil")
func decodeFromFileWrongType() {
    let fileName = "content"
    
    // ✅ FIXED: Using PersonWithStringId.self (WRONG type)
    let person = jsonLoaderRoot.decode(from: fileName, as: PersonWithStringId.self)
    
    #expect(person == nil, "Decoding should fail with wrong type")
    // ✅ PASSES: Decoding fails because id is Int, not String
}
```

---

## ✅ Fixes Applied

### **Test 1: `decodeFromFileWrongType()`**
```swift
// Before
let person = jsonLoaderRoot.decode(from: fileName, as: Person.self)

// After ✅
let person = jsonLoaderRoot.decode(from: fileName, as: PersonWithStringId.self)
```

**Why it works now:**
- JSON has: `{ "id": 1, "name": "John Doe" }` (id is **Int**)
- PersonWithStringId expects: `id: String`
- Type mismatch → decoding fails → returns `nil` ✅

---

### **Test 2: `decodeThrowingVersionDecodingFailed()`**
```swift
// Before
#expect(throws: JsonLoaderError.self) {
    try jsonLoaderRoot.decode(fileName: fileName, as: Person.self)
}

// After ✅
#expect(throws: JsonLoaderError.self) {
    try jsonLoaderRoot.decode(fileName: fileName, as: PersonWithStringId.self)
}
```

**Why it works now:**
- Type mismatch causes decoding to fail
- Throws `JsonLoaderError.decodingFailed` ✅

---

### **Test 3: `decodeArrayWithWrongType()`**
```swift
// Before
let wrongArray = jsonLoaderRoot.decodeArray(from: fileName, as: Person.self)

// After ✅
let wrongArray = jsonLoaderRoot.decodeArray(from: fileName, as: PersonWithStringId.self)
```

**Why it works now:**
- users.json has: `[{ "id": 1, ... }, ...]` (id is **Int**)
- PersonWithStringId expects: `id: String`
- Type mismatch → array decoding fails → returns `nil` ✅

---

### **Test 4: `decodeArrayThrowingVersionWrongType()`**
```swift
// Before
#expect(throws: JsonLoaderError.self) {
    try jsonLoaderRoot.decodeArray(fileName: fileName, as: Person.self)
}

// After ✅
#expect(throws: JsonLoaderError.self) {
    try jsonLoaderRoot.decodeArray(fileName: fileName, as: PersonWithStringId.self)
}
```

**Why it works now:**
- Type mismatch causes array decoding to fail
- Throws `JsonLoaderError.decodingFailed` ✅

---

## 📊 Summary

| Test | Line | Issue | Fix |
|------|------|-------|-----|
| `decodeFromFileWrongType` | 334 | Used `Person.self` | → `PersonWithStringId.self` ✅ |
| `decodeThrowingVersionDecodingFailed` | 381 | Used `Person.self` | → `PersonWithStringId.self` ✅ |
| `decodeArrayWithWrongType` | 824 | Used `Person.self` | → `PersonWithStringId.self` ✅ |
| `decodeArrayThrowingVersionWrongType` | 861 | Used `Person.self` | → `PersonWithStringId.self` ✅ |

---

## 🎯 What These Tests Verify

### **Type Safety:**
These tests ensure that `JsonLoader` properly **rejects invalid type conversions**:

```swift
// JSON: { "id": 1, "name": "John" }
//        ^^^^^
//        Int type

struct PersonWithStringId {
    let id: String  // ❌ Expects String, but JSON has Int
    let name: String
}

// Decoding should fail ✅
```

### **Error Handling:**
- Optional version returns `nil` on type mismatch
- Throwing version throws `JsonLoaderError.decodingFailed`

---

## ✅ Test Results Now

All 4 tests should now **PASS** because:
1. ✅ They use the wrong type (`PersonWithStringId`)
2. ✅ JSON has Int ids, not String ids
3. ✅ Decoding fails as expected
4. ✅ Returns nil or throws error correctly

---

## 🚀 Run Tests

```bash
⌘ + U  # In Xcode
```

**Expected:**
```
✅ decodeFromFileWrongType: PASSED
✅ decodeThrowingVersionDecodingFailed: PASSED
✅ decodeArrayWithWrongType: PASSED
✅ decodeArrayThrowingVersionWrongType: PASSED
```

**All 64+ tests should now pass! 🎉**

---

## 📝 Lesson Learned

When testing error cases:
- ✅ **DO:** Use the wrong type to trigger errors
- ❌ **DON'T:** Use the correct type and expect it to fail

```swift
// ✅ GOOD: Tests error handling
let result = decode(from: "file", as: WrongType.self)
#expect(result == nil)  // Passes because type is wrong

// ❌ BAD: Tests success, not error
let result = decode(from: "file", as: CorrectType.self)
#expect(result == nil)  // Fails because type is correct!
```

---

**Status: 🟢 FIXED! All tests should pass now! ✅**

