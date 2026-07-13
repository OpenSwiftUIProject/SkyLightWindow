# SkyLightWindow

A powerful macOS framework that enables views to be displayed above all other windows using private SkyLight APIs.

![Preview](./Resources/Preview.png)

## Features

- 🚀 **Always on Top**: Display windows above all other applications, even fullscreen apps
- 🎯 **SwiftUI Integration**: Simple `.moveToSky()` modifier for any SwiftUI view
- 🔒 **System-Level Positioning**: Uses SkyLight framework for maximum window level control
- 🖥️ **Multi-Screen Support**: Works seamlessly across multiple displays
- 🎨 **Transparent Windows**: Support for transparent backgrounds and custom styling

## Installation

### SwiftPM

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Lakr233/SkyLightWindow", from: "1.0.0"),
]
```

To enable the `OpenSwiftUI` package trait, use:

```swift
dependencies: [
    .package(
        url: "https://github.com/Lakr233/SkyLightWindow",
        from: "1.0.0",
        traits: ["OpenSwiftUI"]
    ),
]
```

This uses [`OpenSwiftUI-spm`](https://github.com/OpenSwiftUIProject/OpenSwiftUI-spm)
binary package. Import `OpenSwiftUI` instead of `SwiftUI` in your app. At the
time of writing, OpenSwiftUI's macOS binary support requires macOS 15.0 or newer.

### Xcode

In Xcode, add the package dependency and enable the `OpenSwiftUI` trait in the package settings.

To enable trait in your Xcode project, Xcode 26.4+ is required.

![OpenSwiftUI trait](./Resources/OpenSwiftUI-trait.png)

Platform compatibility for default trait:

- macOS 11.0+
- Swift Compiler 5.9+

Platform compatibility for `OpenSwiftUI` trait:

- macOS 15.0+
- Swift Compiler 6.1+

## Usage

### SwiftUI Integration

1. **Import the framework**

```swift
import SwiftUI
import SkyLightWindow
```

2. **Apply the modifier to any view**

```swift
struct ContentView: View {
    var body: some View {
        Text("This view is always on top!")
            .moveToSky()
    }
}
```

### OpenSwiftUI Integration

Usage is identical to the SwiftUI integration above. Import `OpenSwiftUI` instead of `SwiftUI`:

```swift
import OpenSwiftUI
import SkyLightWindow
```

```swift
struct ContentView: View {
    var body: some View {
        Text("This view is always on top!")
            .moveToSky()
    }
}
```

### AppKit Usage

You can also create topmost windows programmatically:

```swift
import SkyLightWindow

let screen = NSScreen.main!
let view = AnyView(Text("Overlay Content"))
let controller = SkyLightOperator.shared.delegateView(view, toScreen: screen)

// or you can just delegate a window
```

## How It Works

SkyLightWindow uses macOS's private SkyLight framework to:

1. Create a special space at the highest system level
2. Move target windows to this space
3. Ensure windows remain visible above all other content

The framework handles:
- Connection to the SkyLight service
- Space creation and management
- Window delegation and positioning
- SwiftUI integration through view modifiers

## Important Notes

⚠️ **Privacy & Security**: This framework uses private APIs but works without special entitlements and is available to the Mac App Store.

⚠️ **System Compatibility**: The default SwiftUI integration supports macOS
11.0 or newer. The `OpenSwiftUI` trait requires macOS 15.0 or newer. Private
APIs can change between system updates.

## Example

The examples are generated with Tuist and require Xcode 26.4 or newer plus a
Tuist version containing [native package trait support](https://github.com/tuist/tuist/pull/11799).

Generate the default SwiftUI example:

```bash
tuist generate --path Example/Projects/MoveToSky --no-open
open Example/Projects/MoveToSky/MoveToSky.xcworkspace
```

Generate the OpenSwiftUI example:

```bash
tuist generate --path Example/Projects/MoveToSkyOpenSwiftUI --no-open
open Example/Projects/MoveToSkyOpenSwiftUI/MoveToSkyOpenSwiftUI.xcworkspace
```

Generate the examples separately. Package trait selections belong to an Xcode
project, and combining both projects in one workspace would give the shared
`SkyLightWindow` package conflicting trait selections.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Sponsor

[LookInside](https://lookinside-app.com/) helps you inspect a running iOS or macOS app UI from your Mac.

---

Copyright 2025 © Lakr Aream. All rights reserved.
