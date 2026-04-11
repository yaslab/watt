# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Watt is a macOS menu bar application that displays the wattage supplied by the charger on the status bar. It shows real-time power adapter information (wattage, voltage, current) and battery status. Available on the [Mac App Store](https://apps.apple.com/us/app/id1642732100).

## Build & Development

This is a native macOS Xcode project (not a Swift Package). Swift 6.0 or later.

```bash
# Build from command line
xcodebuild -scheme Watt -configuration Debug build

# Format code (uses swift-format with .swift-format config: 4-space indent, 200 char line length)
./swift-format.sh
```

There are no test targets. UI verification is done via SwiftUI `#Preview` blocks with mock implementations in `Preview Content/`.

## Architecture

The app uses **MV with a service locator DI pattern**.

### Data Flow

```
IOKit (macOS power source APIs)
  → IOPowerSources/ (type-safe IOKit wrapper)
    → PowerAdapter/ (protocol, converts to domain models)
      → PowerAdapterModel (@Observable, Combine throttle at 0.5s)
        → SwiftUI views (StatusBarButton, StatusBarMenu)
```

### Entry Point

`WattApp.swift` — Uses `MenuBarExtra` with `.window` style. The app is `LSUIElement` (no Dock icon). A single `DIResolver.live()` instance is injected into the SwiftUI environment for both the label and menu content.

### Module Organization (all under `Watt/`)

- **Dependency/** — `DIResolver` service locator with overloaded `resolve()` methods. `DIResolver+Live.swift` for production, `DIResolver+Preview.swift` for previews. Injected via SwiftUI environment (`View+DIResolver.swift`).
- **IOPowerSources/** — Wraps IOKit's `IOPSCopyPowerSourcesInfo`/`IOPSCopyPowerSourcesList` APIs. `PowerSource` reads CFDictionary data into typed structs. `Notifications/` provides Combine publishers for Darwin power change notifications.
- **PowerAdapter/** — `PowerAdapterService` protocol fetches adapter data; `PowerAdapterModel` is the `@Observable` view model that subscribes to notifications with Combine throttling.
- **Launcher/** — `AutoStartManager` protocol wraps `SMAppService` for login item registration. `AutoStartModel` is the `@Observable` view model.
- **MenuBarExtraUI/** — SwiftUI views split into `StatusBarButton/` (menu bar label) and `StatusBarMenu/` (dropdown content with adapter info, battery info, settings, quit).

### Key Patterns

- **Protocol-based services**: `PowerAdapterService` and `AutoStartManager` are protocols with live and preview implementations, enabling SwiftUI previews without hardware dependencies.
- **@Observable macro**: Used for `PowerAdapterModel` and `AutoStartModel` (requires macOS 14+).
- **Combine for notifications**: Power source changes come via Darwin notifications → `PassthroughSubject` → throttled pipeline → model update.
- **IOKit voltage fallback**: Checks `IOPSVoltageKey`, then `IOPSPowerAdapterVoltageKey`, then undocumented `"AdapterVoltage"` key.
