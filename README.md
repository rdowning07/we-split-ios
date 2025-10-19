# WeSplit (SwiftUI)

A tiny SwiftUI app that calculates how much **each person** should pay on a check, including tip. This project is part of my **learning journey as a Technical Program Manager (TPM)** exploring Swift, SwiftUI, and iOS development fundamentals.

## ✨ Features

* Enter a **check amount** (currency-aware)
* Pick **number of people** (2–99)
* Choose a **tip** (0%, 10%, 15%, 20%, 25%)
* See **total per person** update automatically as you type
* “**Done**” toolbar button to dismiss the number pad

## 🧠 How the math works

`totalPerPerson` is a computed property:

```swift
var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2) // 0 → 2 people, 1 → 3 people, etc.
    let tipSelection = Double(tipPercentage)

    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    return grandTotal / peopleCount
}
```

> **Why `+ 2`?**
> The app stores a 0-based selection for people (so the UI can show “2…99 people” while the binding keeps 0…97). We add 2 when calculating to get the real count.

## 🛠 Requirements

* **Xcode 16** or newer
* **iOS 18** simulator or device (target can be adjusted)
* Swift 5.9+

## ▶️ Build & Run

1. Open `WeSplit.xcodeproj` (or the `.xcworkspace` if you have one).
2. Choose an iOS simulator (e.g., iPhone 16).
3. **Run** (⌘R).

### SwiftUI Preview

* Open `ContentView.swift` → **Editor → Canvas** (⌥⌘⏎)
* **Resume** previews (⌥⌘P)

## 🧩 Code Tour

* `ContentView`

  * `@State` values: `checkAmount`, `numberOfPeople` (0-based), `tipPercentage`, `amountIsFocused`
  * `Form` with three sections:

    * **Amount & People**: currency `TextField`, people `Picker`
    * **Tip**: segmented `Picker` of percentages
    * **Total per person**: currency `Text(totalPerPerson, …)`
  * `.toolbar` adds a **Done** button while the amount field is focused

## 🔧 Customization ideas

* Persist last-used tip or people count with `@AppStorage`
* Add currency selection via `Locale` or settings
* Input validation / haptic feedback on changes

## ♿ Accessibility

* Uses system **Form**, **Picker**, and **TextField** → VoiceOver-friendly
* Segmented control for tip makes selection clear
* Consider adding `accessibilityLabel`/`Value` for totals if you customize

## 🧪 Notes

* The “Number of people” picker stores 0-based values (to match the original lesson).
  If you prefer 1-to-1 storage, initialize `numberOfPeople = 2`, tag rows with `n`, and use `Double(numberOfPeople)` directly.

## 📦 GitHub

If you haven’t pushed yet:

```bash
git init
git add -A
git commit -m "WeSplit initial commit"
git branch -M main
git remote add origin https://github.com/<your-username>/WeSplit.git
git push -u origin main
```

## 📝 License

This project is licensed under the **MIT License**.

---
