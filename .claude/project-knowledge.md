# Split Bill iOS Project Knowledge Base

## 📋 Table of Contents
1. [Architecture & Patterns](#architecture--patterns)
2. [UI/UX Standards](#uiux-standards)
3. [Component Usage Rules](#component-usage-rules)
4. [Screen Patterns](#screen-patterns)
5. [Coding Standards](#coding-standards)
6. [Common Pitfalls to Avoid](#common-pitfalls-to-avoid)
7. [Testing & Validation](#testing--validation)
8. [Development Workflow](#development-workflow)

---

## 🏗️ Architecture & Patterns

### File Organization Standards
```
Always follow this folder structure:
split bill/
├── Core/
│   ├── Models/           # Data models (UserProfile, GroupModel, AppNotification, etc.)
│   ├── Views/            # Screen views organized by feature
│   │   ├── Authentication/
│   │   ├── Onboarding/
│   │   ├── Dashboard/
│   │   ├── Groups/       # GroupsView, GroupDetailView
│   │   ├── Friends/
│   │   ├── Settings/
│   │   ├── UserProfile/
│   │   ├── Bills/
│   │   └── Notifications/
│   └── Utils/            # Extensions, helpers, DesignConstants.swift
├── Components/           # Reusable UI components
│   ├── Layout/           # ScreenContainer, HeaderView, HeaderContentView
│   └── UI/               # StandardCard, PrimaryButton, CircularIconButton, etc.
├── ContentView.swift      # App entry point
└── Assets.xcassets/      # App assets
```

### SwiftUI Architecture
- **MVVM Pattern**: Views + ViewModels (when needed)
- **Single Responsibility**: Each struct has one clear purpose
- **Component-Based**: Build from reusable components
- **State Management**: Use appropriate property wrappers:
  - `@State`: Local view state
  - `@StateObject`: View models and complex state
  - `@Binding`: Parent-child communication
  - `@EnvironmentObject`: Shared app state

---

## 🎨 UI/UX Standards

### Design System (DesignConstants.swift)
```swift
// Always use these constants - NEVER use magic numbers:

Colors:
- background: #eae2b7 (main app background)
- textPrimary: #003049 (primary text)
- textSecondary: #003049.opacity(0.6)
- secondary: #f77f00 (accent/orange)
- accent: #fcbf49 (yellow accents)
- danger: #d62828 (red for negative amounts)
- white: #ffffff

Typography:
- largeTitle: Main amounts, totals
- title1: Screen titles, app names
- headline: Section headers
- body: Regular text content
- callout: Secondary text, labels
- caption: Small supporting text

Spacing:
- horizontalPadding: 24px (screen edges)
- verticalPadding: 24px (screen edges)
- contentSpacing: 16px (between sections)
- cardPadding: 16px (card content)
- formButtonSpacing: 24px (form elements)
```

### Layout Standards
- **Always use ScreenContainer** for full-screen views
- **Use FormContainer** for authentication screens
- **Use StandardCard** for white content cards
- **Use SecondaryCard** for light background sections
- **Consistent padding**: Always use DesignConstants
- **Never use manual padding values** like `.padding(16)`

---

## 🧩 Component Usage Rules

### Buttons
- **PrimaryButton**: Main actions (Login, Sign Up, Share, Create Bill)
  ```swift
  PrimaryButton(
      text: "LOGIN",
      action: { /* action */ }
  )
  ```
- **SecondaryButton**: Secondary actions with chevron
- **TextButton**: Text-only actions (links, navigation)
- **CircularIconButton**: Header actions (back, edit, notifications)

### Cards
- **StandardCard**: White background with shadow/border (most common)
- **SecondaryCard**: Light background, no shadow (details, secondary content)
- **BaseCard**: Fully customizable when needed

### Headers - Reusable Header System
- **Always use ScreenContainer with header system** for consistent headers
- **HeaderType options**: `.simple`, `.detail`, `.custom`
  ```swift
  // Simple header with title
  ScreenContainer(
      title: "Screen Title",
      headerType: .simple,
      showBackButton: true,
      backButtonAction: { /* back action */ }
  ) { /* content */ }

  // Detail header with custom content
  ScreenContainer(
      headerType: .detail,
      customHeaderContent: HeaderContentView(
          type: .groupDetail(
              groupIcon: "🐻",
              groupName: "Roommates",
              memberCount: 4,
              editButtonAction: nil
          )
      ),
      headerHeight: 280
  ) { /* content */ }
  ```

### HeaderContentView Types
- **`.simple(title: String, subtitle: String?)`**: Basic title with optional subtitle
- **`.groupDetail(groupIcon: String, groupName: String, memberCount: Int, editButtonAction: (() -> Void)?)`**: For group screens
- **`.userProfile(userName: String, avatarUrl: String?, stats: String?)`**: For user profiles
- **`.custom(content: AnyView)`**: Fully custom header content

---

## 📱 Screen Patterns

### Authentication Screens (Login/SignUp)
```swift
ScreenContainer(
    backgroundColor: DesignConstants.Colors.background,
    hasScrollView: false
) {
    VStack(spacing: 0) {
        Spacer() // Push content to center

        // Logo + App Name + Tagline
        SplitBillLogo(size: 96)
        Text("SplitBill")
        Text("Tagline here")

        Spacer()

        // Form Fields + Action Buttons + Navigation Links
        // ... form content

        Spacer()
    }
}
```

### Main Content Screens
```swift
ScreenContainer(
    title: "Screen Title",
    backgroundColor: DesignConstants.Colors.background,
    hasScrollView: true,
    headerType: .simple,
    showBackButton: true,
    backButtonAction: { /* back action */ }
) {
    VStack(spacing: DesignConstants.contentSpacing) {
        // Main content (cards, lists, etc.)

        // Bottom Action Button (if needed)
        PrimaryButton(action: { /* action */ })
    }
}
```

### Group Detail Screens
```swift
ScreenContainer(
    headerType: .detail,
    customHeaderContent: HeaderContentView(
        type: .groupDetail(
            groupIcon: "🐻",
            groupName: "Roommates",
            memberCount: 4,
            editButtonAction: nil
        )
    ),
    headerHeight: 280,
    hasScrollView: true
) {
    VStack(spacing: DesignConstants.sectionSpacing) {
        // Group content sections
    }
}
```

### Card Content Structure
```swift
StandardCard {
    VStack(spacing: 0) {
        // Header Section (person info, bold name)
        HStack {
            // Person image and info
            Text("Person's Name").fontWeight(.bold)
            Spacer()
            Text("$Amount")
        }
        .padding(DesignConstants.cardPadding)

        // Divider (if needed)
        Divider()
            .background(DesignConstants.Colors.textPrimary.opacity(0.1))
            .padding(.horizontal, DesignConstants.cardPadding)

        // Content Section (items, details)
        VStack(spacing: 12) {
            // ... content
        }
        .padding(DesignConstants.cardPadding)
    }
}
```

---

## 🔧 Coding Standards

### Shadow Implementation
```swift
// ALWAYS use this pattern (separate background from stroke):
.background(
    RoundedRectangle(cornerRadius: cornerRadius)
        .fill(backgroundColor)
        .shadow(color: shadowColor, radius: 0, x: shadowOffset, y: shadowOffset)
)
.overlay(
    RoundedRectangle(cornerRadius: cornerRadius)
        .stroke(borderColor, lineWidth: borderWidth)
)
```

### Import Management
- No explicit imports needed for same-module files
- Organize by functionality, not file location
- Swift automatically finds structs in same target

### State Management
```swift
@State private var localVar: String = ""        // Local state
@StateObject private var viewModel: ViewModel     // Complex objects
@Binding var parentValue: String                 // Parent communication
@EnvironmentObject var appState: AppState         // Shared state
```

### Naming Conventions
- **PascalCase** for types (structs, classes, enums)
- **camelCase** for variables and functions
- **Descriptive names** - no abbreviations unless widely known
- **File names match struct names**

---

## ⚠️ Common Pitfalls to Avoid

### Padding Issues (CRITICAL)
- ❌ NEVER use `.padding(.edge, value)` - causes compilation errors
- ❌ NEVER use `.padding(.horizontal, 16)` or `.padding(.vertical, 24)`
- ✅ ALWAYS use `.padding(EdgeInsets(top: 0, leading: 0, bottom: value, trailing: 0))`
- ✅ ALWAYS use DesignConstants for consistent spacing

### File Structure
- ❌ NEVER duplicate files (causes "Multiple commands produce" errors)
- ✅ ALWAYS move files one at a time and test compilation
- ✅ ALWAYS use safe migration approach for reorganization

### Component Usage
- ❌ NEVER create monolithic views (>200 lines)
- ✅ ALWAYS extract reusable components
- ✅ ALWAYS follow single responsibility principle

### Magic Numbers
- ❌ NEVER use hardcoded values like `padding(16)` or `spacing: 4`
- ✅ ALWAYS use DesignConstants for all spacing, colors, typography

---

## 🧪 Testing & Validation

### Compilation Testing
After each file move/creation:
```bash
xcodebuild -scheme "split bill" -destination "platform=iOS Simulator,name=iPhone 17,OS=26.1" build
```

### Code Review Checklist
Before completing any task:
- ✅ Uses DesignConstants instead of magic numbers
- ✅ Follows folder structure standards
- ✅ Components are reusable and focused
- ✅ Proper state management patterns
- ✅ No manual padding values
- ✅ Shadow implementation follows the correct pattern
- ✅ Project compiles successfully

---

## 🚀 Development Workflow

### Safe File Operations
1. **Plan the changes** first
2. **Create new directories** if needed
3. **Move/copy files one at a time**
4. **Test compilation** after each change
5. **Update imports** if needed
6. **Test again**
7. **Commit changes** with descriptive messages

### Git Standards
- **main branch**: Production-ready code only
- **development branch**: Feature development and testing
- **Descriptive commits**: Explain what and why
- **Branch naming**: feature/description or fix/description

### Project Maintenance
- Keep this file updated when adding new patterns
- Reference this file in complex code with comments
- When in doubt, follow the patterns documented here

---

## 🔔 Quick Reference

### Creating a New Screen
1. Use `ScreenContainer` wrapper with appropriate header type
2. Choose header type: `.simple` for basic screens, `.detail` for rich content
3. Add header content if using `.detail` type
4. Use `StandardCard` for content sections
5. Use `PrimaryButton` for main actions
6. Test compilation

### Creating a New Component
1. Place in appropriate Components subfolder
2. Follow single responsibility principle
3. Use DesignConstants for all styling
4. Add proper documentation comments
5. Make it reusable and focused

### Debugging Common Issues
- **"Multiple commands produce"**: Duplicate files - remove duplicates
- **Padding errors**: Use EdgeInsets syntax, not .edge notation
- **Missing constants**: Use DesignConstants, never magic numbers
- **Compilation fails**: Check file moves one at a time
- **Header title not centered**: Check HeaderView layout balancing - ensure both sides have equal weight
- **Parameter order errors**: "Argument 'X' must precede argument 'Y'" - fix parameter order in function calls
- **Missing header content**: Ensure customHeaderContent is provided when using .detail headerType
- **Edit button duplication**: Remove edit buttons from custom content, use header edit button instead

### Navigation Patterns
- **Independent Screens**: Use `@Binding var showScreen: Bool` for navigation control
- **Back Navigation**: Set binding to `false` instead of using `@Environment(\.dismiss)`
- **Conditional Navigation**: Use ContentView with if/else statements for screen flow
- **ScreenContainer Parameters**: Always include `showBackButton` and `backButtonAction` for proper navigation

### Header System Usage
- **HeaderType Selection**: Choose appropriate header type for content complexity
- **Edit Button Placement**: Edit functionality should be in header edit button, not in custom content
- **Parameter Order**: CRITICAL - Follow exact parameter order in ScreenContainer and HeaderView initializers
- **Header Heights**:
  - Default simple headers: 100px (updated from 64px)
  - Detail headers: 120px-300px depending on content complexity
  - GroupDetailView: 300px for group icon, name, and member count display
- **Navigation Header Container**: Navigation elements wrapped in dedicated container for better structure
- **Alignment Behavior**: Navigation buttons stay at top regardless of header height due to `.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)`
- **Bottom Spacing**: Simple headers have 48pt bottom spacing for visual separation
- **Content Integration**: HeaderContentView provides predefined content types for common patterns

### Swift Parameter Order Rules (CRITICAL)
- **Never change parameter order** - Swift enforces this strictly
- **Common error**: "Argument 'X' must precede argument 'Y'" indicates wrong parameter order
- **Solution**: Always follow the exact sequence defined in initializers
- **This applies to**: All SwiftUI components and custom initializers

### Sheet Presentation (Modal Views)
- **Usage**: Perfect for overlays, notifications, settings, and secondary views
- **Implementation**: Use `.sheet(isPresented: $binding)` modifier on view
- **Benefits**: Built-in slide-down animation, swipe-to-dismiss gesture, clean UX
- **Configuration Options**:
  ```swift
  .sheet(isPresented: $showNotifications) {
      NotificationsView(showNotifications: $showNotifications)
          .presentationDetents([.medium, .large])     // Flexible sizing
          .presentationDragIndicator(.visible)        // Show/hide drag handle
          .presentationCornerRadius(DesignConstants.CornerRadius.large)
  }
  ```
- **Best Practices**:
  - Apply sheet modifier to all relevant views for consistent access
  - Use detents for flexible sizing (medium for notifications, large for full content)
  - Test swipe-to-dismiss functionality
  - Remove manual drag indicators when using built-in `.presentationDragIndicator(.visible)`

### Notification System Implementation
- **Data Model**: Use `AppNotification` struct with properties (id, type, title, message, time, iconName, color, isRead)
- **Navigation**: Bind `showNotifications` state across all screens for universal access
- **UI Components**:
  - Notification cards in settings/lists use button actions to trigger modal
  - Header notification buttons provide quick access
  - Sheet presentation provides smooth animation and gesture dismissal
- **Visual Design**: Match app theme with consistent colors and typography

---

### Component Architecture Summary
- **ScreenContainer**: Main wrapper with header system integration (default headerHeight: 100px)
- **HeaderView**: Enhanced header with Navigation Header Container and HeaderType support (.simple, .detail, .custom)
- **HeaderContentView**: Enum-based content system for flexible header content
- **StandardCard**: Reusable content card with consistent styling
- **PrimaryButton**: Main action button with configurable styling
- **SearchHeader**: Reusable search component (available but not currently used in main views)
- **ShareManager**: Utility for formatted share content across the app

### Latest Implementation Rules
- **Reusable Header System**: All screens should use the new header system
- **Edit Button Placement**: Always in header edit button, never in custom content
- **Parameter Order**: Critical - follow exact initializer parameter sequence
- **Header Content Types**: Use appropriate HeaderContentView type for the content
- **Groups System**: Complete implementation with GroupsView and GroupDetailView
- **Search Functionality**: Removed from MainScreenView and GroupsView for cleaner UI
- **Accessibility**: All header components include proper accessibility labels and hints
- **Action Button Patterns**: Bell icons for notifications (main views), Share icons for detail views

*📝 Remember: When implementing new features, always reference this document first for patterns and standards.*